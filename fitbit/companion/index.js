/**
 * Code related to the logic of the companion app.
 */

import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";


const ENDPOINT = "***REMOVED***";

async function fetchSleepData(date, accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1.2/user/-/sleep/date/${date}.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}

async function fetchUserProfile(accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1/user/-/profile.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}

async function sendDataToEndpoint(data, endpoint = ENDPOINT, fetchFn = fetch) {
    await fetchFn(endpoint, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
    });
}

async function fetchPatientData(userId, accessToken) {
    const date = new Date();
    const todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; // YYYY-MM-DD
    const currentDateInNZST = getCurrentDateInNZST(date);

    const responseData = {
        UserId: userId,
        TotalMinutesAsleep: 0,
        FullName: "",
        DateTime: currentDateInNZST,
    };

    try {
        const sleepData = await fetchSleepData(todayDate, accessToken);
        responseData.TotalMinutesAsleep = sleepData.summary.totalMinutesAsleep;

        const userProfile = await fetchUserProfile(accessToken);
        responseData.FullName = userProfile.user.fullName;

        console.log(responseData);
        if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
            messaging.peerSocket.send(responseData);
        }

        await sendDataToEndpoint(responseData);
    } catch (err) {
        console.log("[REQUEST FAILED]: " + err);
    }
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