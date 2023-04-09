/**
 * Code related to the logic of the companion app.
 */

import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";


const ENDPOINT = "***REMOVED***";

/**
 * Fetches patient data and sends it to the smartwatch app.
 *
 * @param {string} userId - The user's Fitbit user ID.
 * @param {string} accessToken - The access token for the Fitbit API.
 */
export function fetchPatientData(userId, accessToken) {
    const date = new Date();
    const todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; // YYYY-MM-DD
    const currentDateInNZST = getCurrentDateInNZST(date);

    const responseData = {
        UserId: userId,
        TotalMinutesAsleep: 0,
        FullName: "",
        DateTime: currentDateInNZST
    };

    fetch(`https://api.fitbit.com/1.2/user/-/sleep/date/${todayDate}.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    })
        .then((response) => response.json())
        .then((data) => {
            responseData.TotalMinutesAsleep = data.summary.totalMinutesAsleep;
            return fetch(`https://api.fitbit.com/1/user/-/profile.json`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${accessToken}`,
                },
            });
        })
        .then((response) => response.json())
        .then((data) => {
            responseData.FullName = data.user.fullName;
            console.log(responseData);
            if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
                messaging.peerSocket.send(responseData);
            }
            return fetch(ENDPOINT, {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(responseData),
            });
        })
        .catch((err) => console.log("[REQUEST FAILED]: " + err));
}

// Handle user settings changes
settingsStorage.onchange = (evt) => {
    if (evt.key === "oauth") {
        const data = JSON.parse(evt.newValue);
        fetchPatientData(data.user_id, data.access_token);
    }
};

// Restore previously saved settings and send to the device
function restoreSettings() {
    for (let index = 0; index < settingsStorage.length; index++) {
        const key = settingsStorage.key(index);
        if (key && key === "oauth") {
            const data = JSON.parse(settingsStorage.getItem(key));
            fetchPatientData(data.user_id, data.access_token);
        }
    }
}

// Invoke restoreSettings to apply saved settings
restoreSettings();