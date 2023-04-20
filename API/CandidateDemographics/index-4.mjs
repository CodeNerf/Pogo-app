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

const tableName = "CandidateDemographics-Test";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /candidateDemographics/test/{candidateId}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              candidateId: event.pathParameters.candidateId,
            },
          })
        );
        body = `Deleted candidateDemographics ${event.pathParameters.candidateId}`;
        break;
      case "GET /candidateDemographics/test/{candidateId}":
        body = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              candidateId: event.pathParameters.candidateId,
            },
          })
        );
        body = body.Item;
        break;
      case "GET /candidateDemographics/test":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      case "PUT /candidateDemographics/test":
        let requestJSON = JSON.parse(event.body);
  
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: requestJSON,
          })
        );
        body = `Put candidateDemographic ${requestJSON.candidateId}`;
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

