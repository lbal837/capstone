/**
 * Code related to the logic of the companion app.
 */

// Import necessary modules
import * as messaging from "messaging";
import {settingsStorage} from "settings";
import getCurrentDateInNZST from "./dateUtils";
import {fetchUserProfile} from "./fetchUserProfile";
import {sendDataToEndpoint} from "./sendDataToEndpoint";
import {fetchGeoLocationData} from "./fetchGeolocationData";
import {CLIENT_ID, CLIENT_SECRET} from "../common/constants";

// Getting and persisting the access token
settingsStorage.onchange = function (evt) {
    if (evt.key === "excode") {
        getToken(evt.newValue).then(function (result) {
            console.log('Result:\n' + JSON.stringify(result));
            if (result && result.access_token && result.user_id) {
                settingsStorage.setItem("access_token", result.access_token);
                settingsStorage.setItem("user_id", result.user_id);
            } else {
                console.log("Failed to obtain access token and user_id");
            }
        }).catch(function (err) {
            console.log('Err: ' + err);
        });
    }
}


async function getToken(exchangeCode) {
    const urlEncodePost = function (object) {
        let fBody = [];
        for (let prop in object) {
            let key = encodeURIComponent(prop);
            let value = encodeURIComponent(object[prop]);
            fBody.push(key + "=" + value);
        }
        fBody = fBody.join("&");
        return fBody;
    };

    const base64Credentials = btoa(CLIENT_ID + ":" + CLIENT_SECRET);

    const Token_Body = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Basic ' + base64Credentials,
        },
        body: urlEncodePost({
            grant_type: 'authorization_code',
            code: exchangeCode,
            redirect_uri: 'https://app-settings.fitbitdevelopercontent.com/simple-redirect.html',
        })
    };

    return await fetch('https://api.fitbit.com/oauth2/token', Token_Body)
        .then(function (data) {
            return data.json();
        }).catch(function (err) {
            console.log('Error on token gen: ' + err);
        });
}


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
        Steps: latestSteps
    };

    try {
        const userProfile = await fetchUserProfile(accessToken);
        responseData.FullName = userProfile.user.fullName;
        responseData.AvatarImage = userProfile.user.avatar640;

        const geoData = await fetchGeoLocationData();
        responseData.Latitude = geoData.latitude;
        responseData.Longitude = geoData.longitude;

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
        latestSleepStatus = event.data.sleepStatus;
        latestSteps = event.data.steps;

        // Get OAuth data from settingsStorage
        const access_token = settingsStorage.getItem("access_token");
        const user_id = settingsStorage.getItem("user_id");
        
        // Fetch and send patient data if OAuth data is available
        if (access_token && user_id) {
            fetchPatientData(user_id, access_token);
        } else {
            console.log("OAuth data not found in settingsStorage");
        }
    }
});