import json
import boto3
import numpy as np
from random import random
from decimal import Decimal

'''
POST Request with a body format of
{
    "userId": "EMAIL"
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

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    candidateStack = dynamodb.Table('UserCandidateStack')
    userIssueFactorValuesTable = dynamodb.Table('UserIssueFactorValues')
    # Returns all candidates from candidate table
    candidateIssueFactorValuesTable = dynamodb.Table('CandidateIssueFactorValues')
    

    if event["routeKey"] == "POST /matching":
        body = json.loads(event['body'])
        userIssueFactorValues = userIssueFactorValuesTable.get_item(
            Key = { 'userId': body['userId'] }
        )["Item"]

        
        candidateIssueFactorValues = candidateIssueFactorValuesTable.scan()['Items']
        
        rankedCandidates = rankCandidates(candidateIssueFactorValues,userIssueFactorValues,ISSUES)
        item = json.loads(json.dumps(rankedCandidates), parse_float=Decimal)
        
        
        candidateStack.put_item(
            Item = {
                "userId": body['userId'],
                "stack":item
            }
        )
        
        message = json.dumps(f"Put Stack for {body['userId']}")
        status = 200
    else:
        status = 400
        message = json.dumps("Route Doesn't Exist")
    # except:
    #     status = 400
    #     message = json.dumps('Failed to put stack')
    
    return {
        'statusCode': status,
        'body': message 
    }

# Calculates the weighted scores for issues by scaling, adding a small amount of random noise, and multiplying by the weight
def calculateWeightedIssues(issueFactorVales: dict, issues: list):
    weightedScores = []
    for issue in issues:
        weight = float(issueFactorVales[f"{issue}Weight"]) + (random()/10)
        score = score_conversion(int(issueFactorVales[f"{issue}Score"])) + (random()/10)
        weightedScores.append(weight * score)
    print(weightedScores)
    return np.array(weightedScores).astype(float)

# Converts score into a different scaling to help with correlation
def score_conversion(score: int):
    converstion_key = {1: -5, 2: -3, 3: 1, 4: 3, 5: 5}
    return converstion_key[score]

# Calculates correlation between user and candidate
def correlation(user: np.array, candidate: np.array, candidateId: str):
    r = np.corrcoef(user, candidate)[0, 1]
    return {
        "candidateId": candidateId, 
        "R": r,
        "R-Squared": r**2
    }

# Sorts the candidates by best match and eliminates negative correlation
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