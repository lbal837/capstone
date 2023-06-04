# Installation Guidelines

Refer to the following link to get started with Fitbit development:
https://dev.fitbit.com/getting-started/

Here are the step-by-step instructions:
![image](https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/fdf0d207-2381-4295-992f-00de2c9cc1e6)

For Windows users, install nvm from this link:
https://github.com/coreybutler/nvm-windows#readme

For macOS users, use this link instead:
https://github.com/nvm-sh/nvm#troubleshooting-on-macos

You'll then need to sign up as a Fitbit Developer
![image](https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/34bcbba4-6a4e-4ca2-9a55-935ecc385dd0)

## Pre-requisites

- Node.js
- nvm

## Setup and Running

1. Execute `nvm install 14`
2. Execute `nvm alias default 14`
3. Verify the correct Node version with `node --version` (you should have v14.21.3)
4. Run `npm install --global yarn` to install Yarn
5. Initialize the Fitbit OS Simulator
6. If it's your first time using the Fitbit OS Simulator, navigate to the settings tab and check for the
   message `Device bridge is waiting for a debugger`
7. If launching for the first time, run `yarn`
8. To execute the application, run `npx fitbit` then `bi` - this stands for "build and install"

## Future Plans

### Patient ID Modification

Our plans include implementing functionality that allows patient IDs to be modified in the app. The patient ID is
currently hardcoded and linked to the device, which may pose security risks down the line.

### Location Alerts

We aim to enhance patient safety by introducing a feature that allows caregivers to set a defined location range for the
patient. This location-based system will alert the caregiver whenever the patient strays beyond the specified scope.
Such functionality will be particularly beneficial for caregivers of patients with dementia, where wandering can be a
concern.

### Usability improvements

Future improvements also include making our application as user-friendly as possible. These include:

1. **Empty State Handling:** We will introduce custom screens for scenarios when the user isn't subscribed to patients.
   This will provide a more engaging user experience and clear direction for newcomers to our application.
2. **Seamless Subscription Experience:** To make subscribing to patients more intuitive, we plan to improve the user
   interface of our patients_portal screen. In the future, patients will only appear on the patients_portal screen once
   the user has confirmed the subscription, ensuring a smoother and more streamlined experience for users.
