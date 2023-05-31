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


def get_subscription_arn_and_status(caregiver_email, topic_arn):
    subscriptions = sns.list_subscriptions_by_topic(TopicArn=topic_arn)['Subscriptions']
    for subscription in subscriptions:
        if subscription['Protocol'] == 'email' and subscription['Endpoint'] == caregiver_email:
            return subscription['SubscriptionArn'], subscription['SubscriptionArn'].split(":")[-1]
    return None, None


# Lambda function
def lambda_handler(event, context):
    print(context)
    print("*******")
    print(event)

    body = json.loads(event["body"])

    caregiver_email = body["caregiver_email"]
    patient_id = body["patient_id"]

    try:
        topic_arn = get_patient_topic_arn(patient_id)
        subscription_arn, subscription_status = get_subscription_arn_and_status(caregiver_email, topic_arn)

        if subscription_arn is None:
            return {
                "statusCode": 400,
                "headers": {"Content-Type": "application/json"},
                "body": json.dumps({"message": "Caregiver is not subscribed to the patient."})
            }

        if subscription_status == 'PendingConfirmation':
            return {
                "statusCode": 400,
                "headers": {"Content-Type": "application/json"},
                "body": json.dumps({"message": "Confirm the subscription through your email and try again!"})
            }

        sns.unsubscribe(SubscriptionArn=subscription_arn)
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Unsubscribed from patient with ID: {}".format(patient_id)})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Failed to unsubscribe from patient: {}".format(str(e))})
        }
