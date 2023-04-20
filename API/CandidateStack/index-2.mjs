import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  ScanCommand,
  PutCommand,
  GetCommand,
  DeleteCommand,
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "UserCandidateStack";

export const handler = async (event, context) => {
  let body;
  let stack;
  let statusCode = 200;
  let candidateList;
  
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /userCandidateStack/test/{userId}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        body = `Deleted userCandidateStack ${event.pathParameters.candidateId}`;
        break;
      case "GET /userCandidateStack/test/{userId}":
        body = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        body = body.Item.stack;
        break;
      case "GET /userCandidateStack/test/demographics/{userId}":
        stack = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        
        let candidateDemographics = await dynamo.send(
          new ScanCommand({ TableName: "CandidateDemographics-Test" })
        );
        
        candidateList = [];
        
        for(let i = 0; i < stack.Item.stack.length; i++){
            for(let j = 0; j < candidateDemographics.Items.length; j++){
                if(stack.Item.stack[i].candidateId === candidateDemographics.Items[j].candidateId){
                    candidateList.push(candidateDemographics.Items[j]);
                }
            }
        }
        

        body = candidateList;
        break;
      case "GET /userCandidateStack/test/issues/{userId}":
        stack = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        
        let candidateIssueFactorValues = await dynamo.send(
          new ScanCommand({ TableName: "CandidateIssueFactorValues" })
        );
        
        candidateList = [];
        
        for(let i = 0; i < stack.Item.stack.length; i++){
            for(let j = 0; j < candidateIssueFactorValues.Items.length; j++){
                if(stack.Item.stack[i].candidateId === candidateIssueFactorValues.Items[j].candidateId){
                    candidateList.push(candidateIssueFactorValues.Items[j]);
                }
            }
        }
        

        body = candidateList;
        break;
      case "GET /userCandidateStack/":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers,
  };
};

