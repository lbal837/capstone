import {SNSClient, PublishCommand} from '@aws-sdk/client-sns';
import {LambdaClient, InvokeCommand} from '@aws-sdk/client-lambda'; // Import LambdaClient and InvokeCommand

// Create a new SNS client
const sns = new SNSClient({});
const lambda = new LambdaClient({}); // Create a new Lambda client

// Handler function
async function handler(event) {
    console.log(event)
    // Extract the patient_id, topic_arn, and heart_rate from the event object
    const patient_id = event.PatientId;
    const topic_arn = event.TopicArn;
    const heart_rate = event.HeartRate;
    const full_name = event.FullName;

    const message = `Patient ${full_name} (${patient_id}) has a heart rate of ${heart_rate} bpm.`;

    const params = {
        Message: JSON.stringify({
            default: message,
            GCM: JSON.stringify({
                notification: {
                    title: 'High Heart Rate Alert',
                    body: message
                }
            })
        }),
        MessageStructure: 'json',
        TargetArn: topic_arn
    };

    try {
        const response = await sns.send(new PublishCommand(params));
        return {
            statusCode: 200,
            body: JSON.stringify(response)
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify(error)
        };
    }
}

// Export the handler function
export {handler};