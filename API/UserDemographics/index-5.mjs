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

const tableName = "UserDemographics";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /userDemographics/{userId}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              userId: event.pathParameters.userId,
            },
          })
        );
        body = `Deleted userDemographics ${event.pathParameters.candidateId}`;
        break;
      case "GET /userDemographics/{userId}":
        console.log(`Get ${event.pathParameters.userId} demographics`);
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
      case "GET /userDemographics":
        console.log("Get all userDemographics");
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      case "PUT /userDemographics":
        let requestJSON = JSON.parse(event.body);
  
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: requestJSON,
          })
        );
        body = `Put userDemographics ${requestJSON.userId}`;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    console.log(err.message);
    statusCode = 400;
    body = err.message;
  } finally {
    console.log(statusCode);
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers,
  };
};

