import os
import psycopg2
import sys
import json

sys.path.insert(0, "/var/task/dependencies")


def remove_patient_from_user(user_id, patient_id):
    db_host = os.environ.get("DB_HOST")
    db_user = os.environ.get("DB_USER")
    db_password = os.environ.get("DB_PASSWORD")
    db_name = os.environ.get("DB_NAME")

    conn = psycopg2.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        dbname=db_name
    )

    with conn:
        with conn.cursor() as cur:
            # Get the current patient_ids for the user
            cur.execute("SELECT patient_ids FROM users WHERE email = %s", (user_id,))
            result = cur.fetchone()
            if result:
                patient_ids = result[0]
                if patient_ids is None:
                    return {"error": "User not subscribed to any Patient"}
            else:
                return {"error": "User not found"}

            # Guard clause to see if patient_id exists
            if patient_id not in patient_ids:
                return {"error": "User is not subscribed to this Patient"}

            patient_ids.remove(patient_id)

            # Update the patient_ids in the users table
            cur.execute(
                "UPDATE users SET patient_ids = %s WHERE email = %s",
                (patient_ids, user_id)
            )

    conn.close()
    return result


# Lambda function.
def lambda_handler(event, context):
    # Debugging.
    print(event)
    print("********")
    print(context)
    print("********")

    body = json.loads(event["body"])
    user_id = body["UserId"]
    patient_id = body["PatientId"]

    try:
        result = remove_patient_from_user(user_id, patient_id)
        print(result)
        if "error" in result:
            if result["error"] == "User is not subscribed to this Patient":
                return {
                    "statusCode": 400,
                    "headers": {"Content-Type": "application/json"},
                    "body": json.dumps({"message": result["error"]})
                }
            else:
                return {
                    "statusCode": 404,
                    "headers": {"Content-Type": "application/json"},
                    "body": json.dumps({"message": result["error"]})
                }
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Successfully removed patient from user"})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": str(e)})
        }
