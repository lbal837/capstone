/**
 * Code related to the logic of the companion app.
 */

// Import necessary modules
import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";
import {fetchSleepData} from "./fetchSleepData";
import {fetchUserProfile} from "./fetchUserProfile";
import {sendDataToEndpoint} from "./sendDataToEndpoint";

// Initialize the latestHeartRate variable
let latestHeartRate = null;

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
        HeartRate: latestHeartRate,
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

// Listen for messages from the device
messaging.peerSocket.addEventListener("message", (event) => {
    // Check if the message is of type "heart_rate"
    if (event.data.type === "heart_rate") {
        latestHeartRate = event.data.value;

        // Get OAuth data from settingsStorage
        const oauthData = JSON.parse(settingsStorage.getItem("oauth"));

        // Fetch and send patient data if OAuth data is available
        if (oauthData) {
            fetchPatientData(oauthData.user_id, oauthData.access_token);
        } else {
            console.log("OAuth data not found in settingsStorage");
        }
    }
});
