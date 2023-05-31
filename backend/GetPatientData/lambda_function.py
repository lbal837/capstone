import json
import urllib3
import boto3
import os
from decimal import Decimal


# Create a custom JSON encoder to handle Decimal objects.
class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Decimal):
            return float(o)
        return super(DecimalEncoder, self).default(o)


def lambda_handler(event, context):
    # Extract connectionId from incoming event.
    print(context)
    print("*******")
    print(event)
    print("Event:", json.dumps(event))

    # Create a DynamoDB client
    dynamodb = boto3.resource("dynamodb")
    table_name = os.environ["TABLE_NAME"]
    table = dynamodb.Table(table_name)

    # Fetch the UserId from the event object.
    user_id = event['queryStringParameters']['UserId']

    # Query the DynamoDB table to fetch the latest item for the given UserId
    db_items = table.query(
        KeyConditionExpression=boto3.dynamodb.conditions.Key('UserId').eq(user_id),
        ScanIndexForward=False,
        Limit=1
    )

    # Check if an item was returned
    if db_items['Items']:
        response = {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'message': 'Success', 'data': db_items['Items'][0]}, cls=DecimalEncoder)
        }
        return response
    else:
        response = {
            'statusCode': 404,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'message': 'Error, Item not found'})
        }
        return response
