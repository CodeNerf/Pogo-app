import json
import boto3
import numpy as np
from decimal import Decimal
from random import random

'''
POST Request with a body format of
{
    "UserIssueFactorValues": {}
}
'''

ISSUES = [
    "reproductive",
    "policing",
    "housing",
    "healthcare",
    "drugPolicy",
    "immigration",
    "education",
    "economy",
    "climate",
    "gunPolicy",
    "climate"
]

class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Decimal):
            return float(o)
        return super().default(o)

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    candidateStack = dynamodb.Table('UserCandidateStack')
    candidateIssueFactorValuesTable = dynamodb.Table('CandidateIssueFactorValues')
    candidateDemographicsTable = dynamodb.Table('CandidateDemographics-Test')
    
    candidate_list = []
    if event["routeKey"] == "POST /matching/test":
        print(event['body'])
        userIssueFactorValues = json.loads(event['body'])
        candidateIssueFactorValues = candidateIssueFactorValuesTable.scan()['Items']
        rankedCandidates = rankCandidates(candidateIssueFactorValues,userIssueFactorValues,ISSUES)
        
        if(userIssueFactorValues['userId'] != ''):
            item = json.loads(json.dumps(rankedCandidates), parse_float=Decimal)
            candidateStack.put_item(
                Item = {
                    "userId": userIssueFactorValues['userId'],
                    "stack":item
                }
            )
        
        for candidate in rankedCandidates:
            demographics = candidateDemographicsTable.get_item(
                Key = { 'candidateId': candidate["candidateId"] }
                )["Item"]
                
            issues = candidateIssueFactorValuesTable.get_item(
                Key = { 'candidateId': candidate["candidateId"] }
                )["Item"]
            
            candidate_list.append(
                {
                    "Issue Factor Values": issues,
                    "Demographics": demographics,
                    "Statistics": candidate
                }
                )
                
        status = 200
    else:
        status = 400
    
    temp = json.dumps({'statusCode': status,'body': candidate_list}, cls=DecimalEncoder)

    return temp

def calculateWeightedIssues(issueFactorVales: dict, issues: list):
    weightedScores = []
    for issue in issues:
        weight = float(issueFactorVales[f"{issue}Weight"]) + (random()/10)
        score = score_conversion(int(issueFactorVales[f"{issue}Score"])) + (random()/10)
        weightedScores.append(weight * score)
    print(weightedScores)
    return np.array(weightedScores).astype(float)

def score_conversion(score: int):
    converstion_key = {1: -5, 2: -3, 3: 1, 4: 3, 5: 5}
    return converstion_key[score]

def correlation(user: np.array, candidate: np.array, candidateId: str):
    r = np.corrcoef(user, candidate)[0, 1]
    return {
        "candidateId": candidateId, 
        "R": r,
        "R-Squared": r**2
    }

def rankCandidates(candidateIssueFactorVales: list, userIssueFactorValues: dict, issues: list):
    rankedCandidates = []
    userWeightedIssues = calculateWeightedIssues(userIssueFactorValues, issues)
    for candidate in candidateIssueFactorVales:
        candidateWeightedIssues = calculateWeightedIssues(candidate, issues)
        temp = correlation(userWeightedIssues, candidateWeightedIssues, candidate['candidateId'])
        if(temp["R"] > 0):
            rankedCandidates.append(temp)
    rankedCandidates.sort(key=lambda x: x["R"], reverse=True)
    return rankedCandidates
