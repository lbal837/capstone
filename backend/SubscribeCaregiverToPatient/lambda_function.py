import boto3
import json
import os

sns = boto3.client("sns")
dynamodb = boto3.resource("dynamodb")
table_name = os.environ["MAPPING_TABLE_NAME"]
table = dynamodb.Table(table_name)

def get_patient_topic_arn(patient_id):
    response = table.get_item(Key={"PatientId": patient_id})
    return response["Item"]["TopicArn"]

def lambda_handler(event, context):
    print(context)
    print("*******")
    print(event)

    body = json.loads(event["body"])

    caregiver_email = body["caregiver_email"]
    patient_id = body["patient_id"]

    try:
        topic_arn = get_patient_topic_arn(patient_id)
        response = sns.subscribe(TopicArn=topic_arn, Protocol="email", Endpoint=caregiver_email)
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Subscribed to patient with ID: {}".format(patient_id)})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Failed to subscribe to patient: {}".format(str(e))})
        }
