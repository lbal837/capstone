/**
 * Code related to the logic of the companion app.
 */

import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./getDate";

// TODO: Make this an env variable
const ENDPOINT = "https://sog1p6r867.execute-api.ap-southeast-2.amazonaws.com/Production/SendPatientData";

function fetchPatientData(userId, accessToken) {
    // Initialise variables
    let date = new Date();
    let todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; //YYYY-MM-DD

    let responseData = {
        UserId: userId,
        TotalMinutesAsleep: 0,
        FullName: "",
        DateTime: getCurrentDateInNZST()
    }

    // Fetch Sleep Data from Fitbit Web API
    fetch(`https://api.fitbit.com/1.2/user/-/sleep/date/${todayDate}.json`, {
        method: "GET",
        headers: {
            "Authorization": `Bearer ${accessToken}`
        }
    })
        .then(response => response.json())
        .then(data => {
            responseData.TotalMinutesAsleep = data.summary.totalMinutesAsleep;
            return fetch(`https://api.fitbit.com/1/user/-/profile.json`, {
                method: "GET",
                headers: {
                    "Authorization": `Bearer ${accessToken}`
                }
            })
        })
        .then(response => response.json())
        .then(data => {
            responseData.FullName = data.user.fullName;
            console.log(responseData);
            if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
                messaging.peerSocket.send(responseData);
            }
            return fetch(ENDPOINT, {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(responseData)
            })
        })
        .catch(err => console.log('[REQUEST FAILED]: ' + err));
}

// A user changes Settings
settingsStorage.onchange = evt => {
    if (evt.key === "oauth") {
        // Settings page sent us an oAuth token
        let data = JSON.parse(evt.newValue);

        // Sends data to the watch every 15 seconds -> disabled cause it drains your requests
        // setInterval(() => fetchPatientData(data.user_id, data.access_token), 15 * 1000);

        // Temporary fetch instead
        fetchPatientData(data.user_id, data.access_token);
    }
};

// Restore previously saved settings and send to the device
function restoreSettings() {
    for (let index = 0; index < settingsStorage.length; index++) {
        let key = settingsStorage.key(index);
        if (key && key === "oauth") {
            // We already have an oauth token
            let data = JSON.parse(settingsStorage.getItem(key));

            // Sends data to the watch every 15 seconds -> disabled cause it drains your requests
            // setInterval(() => fetchPatientData(data.user_id, data.access_token), 15 * 1000);

            // Temporary fetch instead
            fetchPatientData(data.user_id, data.access_token);
        }
    }
}