# Purpose

Essentially any lambda functions that exceed a storage limit of 10MB can't be edited through the built-in editor. Hence,
for documentation and accessibility we've stored all the lambda functions which are above 10MB in our local repository.

## Modifying and using

To modify and use the lambda functions, edit them in their respective folder, then create a zip file, for
example `AddCaregiverToRDS.zip`, which will hold all the folders and files in the `AddCareGiverToRDS` folder.

Ensure you run `npm i` in the corresponding directory too.

The upload the zip file into the respective lambda function.

## Future Plans

## Personalised Medical Suggestions and Analyses

We aim to offer individualised medical insights by leveraging the power of machine learning (ML). We plan to integrate
AWS Sagemaker into our pipeline to process the health metrics we store in our DynamoDB tables. This will allow us to
understand patients' unique health patterns, given that individual patients have different base heart rates and other
health metrics. Our application will become suitable for industrial-level usage with these tailored insights.

## Improve the notification pipeline

Currently, our application is capable of detecting anomalies in heart rates and notifying the corresponding caregiver
via email. However, we are planning to improve and expand this functionality in several ways:

1. **Diversified Health Metrics:** We plan to incorporate a broader range of health metrics into our anomaly detection
   system. This will allow for more comprehensive monitoring of patient's health.
2. **Machine Learning Integration:** By incorporating a machine learning pipeline, our system will be able to deliver
   more
   precise and timely alerts, improving the reliability of our notifications.
3. **Notification Channels:** We also aim to diversify the notification channels, potentially expanding beyond email to
   include other forms of communication like SMS, push notifications, or even integration with healthcare monitoring
   systems.