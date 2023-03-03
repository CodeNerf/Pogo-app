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

const tableName = "CandidateIssueFactorValues";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /candidateissuefactorvalues/{candidateId}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              candidateId: event.pathParameters.candidateId,
            },
          })
        );
        body = `Deleted candidateissuefactorvalue ${event.pathParameters.candidateId}`;
        break;
      case "GET /candidateissuefactorvalues/{candidateId}":
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
      case "GET /candidateissuefactorvalues":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      case "PUT /candidateissuefactorvalues":
        let requestJSON = JSON.parse(event.body);
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: requestJSON,
          })
        );
        body = `Put candidateissuefactorvalue ${requestJSON.candidateId}`;
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
