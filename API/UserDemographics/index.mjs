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
            Item: {
              userId: requestJSON.userId,
              firstName: requestJSON.firstName,
              lastName: requestJSON.lastName,
              dateOfBirth: requestJSON.dateOfBirth,
              racialIdentity: requestJSON.racialIdentity,
              gender: requestJSON.gender,
              politicalAffiliation: requestJSON.politicalAffiliation,
              zipCode: requestJSON.zipCode,
              addressLine1: requestJSON.addressLine1,
              voterRegistration: requestJSON.voterRegistration,
              phoneNumber: requestJSON.phoneNumber,
              profileImageURL: requestJSON.profileImageURL
            },
          })
        );
        body = `Put userDemographics ${requestJSON.userId}`;
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

