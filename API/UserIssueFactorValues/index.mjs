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

const tableName = "UserIssueFactorValues";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /userissuefactorvalues/{userId}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        body = `Deleted userissuefactorvalue ${event.pathParameters.userId}`;
        break;
      case "GET /userissuefactorvalues/{userId}":
        body = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        body = body.Item;
        break;
      case "GET /userissuefactorvalues":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      case "PUT /userissuefactorvalues":
        let requestJSON = JSON.parse(event.body);
  
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: requestJSON,
          })
        );
        body = `Put userissuefactorvalue ${requestJSON.userId}`;
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
