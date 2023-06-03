# LifeSavers - Project Team 4

## Our Project Managment Tool:
[Jira](https://compsci399team4.atlassian.net/jira/software/projects/LB/boards/1)

## Overview:
This is an overview of our project aimed at creating an app that monitors the wellbeing of individuals with dementia using a wearable device. The objectives of the project were to develop a system capable of monitoring patients' wellbeing and sending alert notifications when necessary. The target audience for the project primarily consists of caregivers for the elderly, particularly those with dementia. The project scope entailed creating a wearable device capable of monitoring patients and notifying caregivers in case of urgent care requirements.

Our Final Report is [Here](https://docs.google.com/document/d/1YlUvtqlReOlDLZJfMkR7j_rECE_j8aPcOfNGaDZMD2M/edit?usp=sharing)

## Technologies Used to build the project:
AWS:
- Python
- Javascript - Node 18

Mobile application:
- Flutter

Fitbit application:
- Javascript - Node 14

External APIs:
- Mapbox API
- Fitbit API


## Instructions on how to install and setup the project (specify all dependencies).
- Installing Fitbit App (Backend) [Here](https://github.com/uoa-compsci399-s1-2023/project-team-4/tree/main/fitbit#readme)
- Intalling Andriod App (Frontend) [Here](https://github.com/uoa-compsci399-s1-2023/project-team-4/blob/main/frontend/README.md)

## Usage Examples
Generate client id on the fitbit:

<img width="200" alt="fitbit-image" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/70e7dfb6-876d-4ee1-a57d-c8f92dd7e632">

Data displayed is as follows: 

(top: "13:58")current time of day, (middle: "B249LG")the patient's unique id used for subscribing a caregiver to that patient on the companion app and (bottom: "1")the number is the number of times data is sent to the database since the watch was last active, which is fetched every minute and changes accordingly.

Starting Page:

<img width="200" alt="start-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/e5adc11b-e339-4798-a0fe-dac5e6b2108b">

This is the starting page for a caregiver when they have downloaded the LifeSaver Application.

Sign Up Page:

<img width="200" alt="register-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/f668d02d-f505-4643-ac3b-a83c8f6d3dc0">

They will then Sign Up to create an account. Once they have signed up there will be an email sent for confirmation as application has this has 2FA. Since it is dealing with sensitive data.


Account Confirmation Page:

<img width="200" alt="account-confirmation-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/cc12df53-c042-4afd-af71-6bc31fe87ca3">

To confirm their account they will need to put in their email address and also the confirmation code that they have recieved from the email that they have signed up with.

Login Page:

<img width="200" alt="login-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/dd62934c-95f4-4465-9aa8-daf1d912013b">

Once confirmed they can login with their email address and password. This will not need to be continually entered everytime as we have a cahce system.

Home Page:

<img width="200" alt="home-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/989aedaa-a0cd-4310-bcbf-0f831ee6fc9b">

This is the Home Page where the caregiver will be visiting the most often. From here they can access the Add Patient Page, each individual Patient Data Page and the Settings Page where they are able to logout from the application. 

Add Patient Page:

<img width="200" alt="add-patient-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/e1123fd0-3cee-49af-adfd-4174da29c3f7">


From here they can enter the Patient ID from the LifeSaver Application on the Fitbit. Once added they can now be accessed through the Patient Data Page.

Patient Data Page:

<img width="200" alt="patient-data-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/b8862559-c316-43c8-9f1c-1e1200fc22b7">

Once in the Patient Data Page you are able to see the different Health Metrics that the fitbit is tracking. It's also tracking the Status of the Patient, on whether the patient is connected with the Fitbit or not. It can show how many steps have been taken per minute and also the SleepStatus of the patient, whether they are awake or asleep. If there are any analomalies with the patient's heartrate then a email notification will be sent to the caregiver. From here the caregiver can also access the location of the patient.

Map of Patient:

<img width="200" alt="map-page" src="https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/3ee86709-ee5b-4ef2-a45a-149b6b019c58">

This is a map of the patient and where the patient is located.

## Future Plan
* Add push notification or SMS notifications.
* Add medical suggestions and analysis from data collected.
* Add location alerts once the patient has gone out of range.

## Acknowledgements
* Flutter Dev Documentation [Here](https://docs.flutter.dev/)
* Fitbit Dev Documentation [Here](https://dev.fitbit.com/build/guides/)
* AWS Docmentation [Here](https://docs.aws.amazon.com/)
