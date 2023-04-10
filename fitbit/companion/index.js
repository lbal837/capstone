/**
 * Code related to the logic of the companion app.
 */

import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";

let latestHeartRate = null;

const ENDPOINT = "***REMOVED***";

/**
 * Fetches sleep data for the given date using the provided access token.
 *
 * @param {string} date - The date to fetch sleep data for (YYYY-MM-DD).
 * @param {string} accessToken - The Fitbit API access token.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 * @returns {Promise<object>} - The sleep data response as a JSON object.
 */
async function fetchSleepData(date, accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1.2/user/-/sleep/date/${date}.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}

/**
 * Fetches user profile data using the provided access token.
 *
 * @param {string} accessToken - The Fitbit API access token.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 * @returns {Promise<object>} - The user profile data response as a JSON object.
 */
async function fetchUserProfile(accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1/user/-/profile.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}

/**
 * Sends patient data to the specified endpoint.
 *
 * @param {object} data - The patient data object to send.
 * @param {string} [endpoint=ENDPOINT] - Optional API endpoint URL.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 */
async function sendDataToEndpoint(data, endpoint = ENDPOINT, fetchFn = fetch) {
    await fetchFn(endpoint, {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(data),
    });
}

/**
 * Fetches patient data and sends it to the device and endpoint.
 *
 * @param {string} userId - The user ID.
 * @param {string} accessToken - The Fitbit API access token.
 */
async function fetchPatientData(userId, accessToken) {
    const date = new Date();
    const todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; // YYYY-MM-DD
    const currentDateInNZST = getCurrentDateInNZST(date);

    const responseData = {
        UserId: userId,
        TotalMinutesAsleep: 0,
        FullName: "",
        DateTime: currentDateInNZST,
        HeartRate: latestHeartRate
    };

    try {
        const sleepData = await fetchSleepData(todayDate, accessToken);
        responseData.TotalMinutesAsleep = sleepData.summary.totalMinutesAsleep;

        const userProfile = await fetchUserProfile(accessToken);
        responseData.FullName = userProfile.user.fullName;

        console.log(responseData);

        // Send data to device
        if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
            messaging.peerSocket.send(responseData);
        }

        // Send data to endpoint
        await sendDataToEndpoint(responseData);
    } catch (err) {
        console.log("[REQUEST FAILED]: " + err);
    }
}

messaging.peerSocket.addEventListener("message", (event) => {
    if (event.data.type === "heart_rate") {
        latestHeartRate = event.data.value;

        const oauthData = JSON.parse(settingsStorage.getItem("oauth"));
        if (oauthData) {
            fetchPatientData(oauthData.user_id, oauthData.access_token);
        } else {
            console.log("OAuth data not found in settingsStorage");
        }
    }
});

/**
 * Handles user settings changes and fetches patient data when OAuth settings change.
 */
settingsStorage.onchange = (evt) => {
    if (evt.key === "oauth") {
        const data = JSON.parse(evt.newValue);
        fetchPatientData(data.user_id, data.access_token);
    }
};

/**
 * Restores previously saved settings and sends the patient data to the device.
 */
function restoreSettings() {
    for (let index = 0; index < settingsStorage.length; index++) {
        const key = settingsStorage.key(index);
        if (key && key === "oauth") {
            const data = JSON.parse(settingsStorage.getItem(key));
            // fetchPatientData(data.user_id, data.access_token);
        }
    }
}

// Invoke restoreSettings to apply saved settings
restoreSettings();