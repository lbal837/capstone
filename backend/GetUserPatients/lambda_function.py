import json
import psycopg2
import os


# Lambda function
def lambda_handler(event, context):
    # Extract connectionId from incoming event.
    print(context)
    print("*******")
    print(event)

    # Fetch RDS details from environment variables
    db_host = os.environ.get("DB_HOST")
    db_user = os.environ.get("DB_USER")
    db_password = os.environ.get("DB_PASSWORD")
    db_name = os.environ.get("DB_NAME")

    # Establish connection to the RDS
    conn = psycopg2.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        dbname=db_name
    )

    # Create a cursor object
    cur = conn.cursor()

    # Execute a SQL query to fetch the user's patients
    user_id = event["queryStringParameters"]["UserId"]
    cur.execute(f"SELECT patient_ids FROM users WHERE email = %s", (user_id,))

    # Fetch the result
    result = cur.fetchone()

    # Close the cursor and the connection
    cur.close()
    conn.close()

    # Check if any items were returned
    if result:
        patient_ids = result[0]
        response = {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'message': 'Success', 'data': patient_ids})
        }
        return response
    else:
        response = {
            'statusCode': 404,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'message': 'Error, No items found'})
        }
        return response
