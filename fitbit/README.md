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
