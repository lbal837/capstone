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


def is_subscribed(caregiver_email, topic_arn):
    subscriptions = sns.list_subscriptions_by_topic(TopicArn=topic_arn)['Subscriptions']
    for subscription in subscriptions:
        if subscription['Protocol'] == 'email' and subscription['Endpoint'] == caregiver_email:
            return True
    return False


def get_subscription_status(caregiver_email, topic_arn):
    subscriptions = sns.list_subscriptions_by_topic(TopicArn=topic_arn)['Subscriptions']
    for subscription in subscriptions:
        if subscription['Protocol'] == 'email' and subscription['Endpoint'] == caregiver_email:
            return subscription['SubscriptionArn'].split(":")[-1]
    return None


def lambda_handler(event, context):
    print(context)
    print("*******")
    print(event)

    body = json.loads(event["body"])

    caregiver_email = body["caregiver_email"]
    patient_id = body["patient_id"]

    try:
        topic_arn = get_patient_topic_arn(patient_id)
        subscription_status = get_subscription_status(caregiver_email, topic_arn)

        if subscription_status == "Confirmed":
            return {
                "statusCode": 400,
                "headers": {"Content-Type": "application/json"},
                "body": json.dumps({"message": "Caregiver is already subscribed to the patient."})
            }
        elif subscription_status == "PendingConfirmation":
            return {
                "statusCode": 400,
                "headers": {"Content-Type": "application/json"},
                "body": json.dumps({"message": "Confirm the subscription through your email and try again!"})
            }

        sns.subscribe(TopicArn=topic_arn, Protocol="email", Endpoint=caregiver_email)
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
