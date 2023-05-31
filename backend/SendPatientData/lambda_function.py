import json
import urllib3
import boto3
import os
from botocore.exceptions import ClientError

lambda_client = boto3.client('lambda')
sns = boto3.client('sns')
dynamodb = boto3.resource("dynamodb")


def lambda_handler(event, context):
    print(context)
    print("*******")
    print(event)

    table_name = os.environ["TABLE_NAME"]
    mapping_table_name = os.environ["MAPPING_TABLE_NAME"]
    table = dynamodb.Table(table_name)
    mapping_table = dynamodb.Table(mapping_table_name)

    patient_id = event['UserId']
    heart_rate = event['HeartRate']
    full_name = event['FullName']

    # Check if the patient already has an SNS topic
    patient_item = mapping_table.get_item(Key={'PatientId': patient_id}).get('Item')

    if not patient_item:
        # Create an SNS topic for the new patient
        topic_name = f'Patient-{patient_id}'
        response = sns.create_topic(Name=topic_name)
        topic_arn = response['TopicArn']

        # Store the mapping between the patient ID and the SNS topic ARN in the mapping table
        mapping_table.put_item(Item={
            'PatientId': patient_id,
            'TopicArn': topic_arn
        })
    else:
        topic_arn = patient_item['TopicArn']

    # Put existing connection to table - needs to match up
    table.put_item(Item=event)

    # Send push notifications based on conditions
    if heart_rate > 100:
        try:
            # Invoke the push notification Lambda function
            response = lambda_client.invoke(
                FunctionName=os.environ["HEART_RATE_PUSH_NOTIFICATION"],
                InvocationType='Event',
                Payload=json.dumps({
                    'FullName': full_name,
                    'PatientId': patient_id,
                    'TopicArn': topic_arn,
                    'HeartRate': heart_rate
                })
            )

            print('Push notification Lambda function invoked')
            return {
                'statusCode': 200,
                'body': json.dumps(response)
            }
        except ClientError as e:
            print('Failed to invoke the push notification Lambda function')
            return {'status': 'error', 'message': str(e)}

    return {
        'statusCode': 200,
    }
