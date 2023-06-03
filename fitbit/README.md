# Installation Instructions

https://dev.fitbit.com/getting-started/

Follow these instructions:
![image](https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/fdf0d207-2381-4295-992f-00de2c9cc1e6)

If you have windows install nvm here:
https://github.com/coreybutler/nvm-windows#readme

otherwise for MacOS:
https://github.com/nvm-sh/nvm#troubleshooting-on-macos

You then need to become a Fitbit Dev
![image](https://github.com/uoa-compsci399-s1-2023/project-team-4/assets/67040087/34bcbba4-6a4e-4ca2-9a55-935ecc385dd0)

then follow the instructions :)

## Pre-requisites

- Node.js
- nvm

## Setup and Running

1. Run `nvm install 14`
2. Run `nvm alias default 14`
3. Verify the correct version of Node is installed with `node --version` (we want `v14.21.3`)
4. Run `npm install --global yarn` to set up Yarn
5. Set up the Fitbit OS Simulator
6. If running the Fitbit OS Simulator for the first time, navigate to the `settings` tab first and ensure there is a
   message `Device bridge is waiting for a debugger`
7. If running for the first time, run `yarn`
8. To run the application run `npx fitbit` then `bi` -> means build and install (not the other one)

## Testing and Developing

- If you wanna test the fetch requests, hit the login button on the Fitbit phone simulator (which should show up after
  running `bi`)
- All the back-end functions are somewhere on lambda so gl with that
  Update

## Future Plans

### Changing Patient Ids

Implement a way to change the patient id in the app. Currently, the patient id is hardcoded and associated with the
device, this may present security concerns in the future.