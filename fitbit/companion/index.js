/**
 * Code related to the logic of the companion app.
 */

// Import necessary modules
import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";
import {fetchUserProfile} from "./fetchUserProfile";
import {sendDataToEndpoint} from "./sendDataToEndpoint";
import {geolocation} from "geolocation";

// Initialize the latestHeartRate and latestSleepStatus variables
let latestHeartRate = null;
let latestSleepStatus = null;
let latestSteps = null;

/**
 * Fetches patient data and sends it to the device and endpoint.
 *
 * @param {string} userId - The user ID.
 * @param {string} accessToken - The Fitbit API access token.
 */
async function fetchPatientData(userId, accessToken) {
    const date = new Date();
    const currentDateInNZST = getCurrentDateInNZST(date);

    const responseData = {
        UserId: userId,
        AvatarImage: "",
        FullName: "",
        DateTime: currentDateInNZST,
        HeartRate: latestHeartRate,
        SleepStatus: latestSleepStatus,
        Latitude: null,
        Longitude: null,
    };

    try {
        const userProfile = await fetchUserProfile(accessToken);
        responseData.FullName = userProfile.user.fullName;
        responseData.AvatarImage = userProfile.user.avatar640;

        geolocation.getCurrentPosition(function (position) {
            responseData.Latitude = position.coords.latitude;
            responseData.Longitude = position.coords.longitude;
        })

        console.log(responseData);

        // Send data to device if the connection is open
        if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
            messaging.peerSocket.send(responseData);
        }

        // Send data to endpoint
        await sendDataToEndpoint(responseData);
    } catch (err) {
        console.log("[REQUEST FAILED]: " + err);
    }
}

// Listen for messages from the device and handle "combined_data" messages
messaging.peerSocket.addEventListener("message", (event) => {

    // Check if the message is of type "combined_data"
    if (event.data.type === "combined_data") {
        latestHeartRate = event.data.heartRate;
        latestSleepStatus = event.data.sleep;
        latestSteps = event.data.steps;

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
