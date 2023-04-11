// Import necessary modules
import clock from "clock";
import * as document from "document";
import {HeartRateSensor} from "heart-rate";
import {me as appbit} from "appbit";
import * as messaging from "messaging";
import sleep from "sleep";
import {geolocation} from "geolocation";

// Set the granularity to update the clock every minute
clock.granularity = "minutes";

// Get a reference to the text element in the document
const testText = document.getElementById("testText");

// Global variables to be passed to the companion app
let latestLatitude = null;
let latestLongitude = null;

// Initialize the count variable
let count = 0;

/**
 * Handles incoming messages from the companion app.
 * Updates the text element based on the total sleep time received.
 *
 * @param {Object} evt - The event object containing the data sent from the companion app.
 */
function handleMessage(evt) {
    // Extract total sleep time from the event data
    const totalUserSleep = evt.data.TotalMinutesAsleep;
    count += 1;

    // Update the text element based on the user's total sleep time
    testText.text = totalUserSleep && totalUserSleep >= 300
        ? `Awake! ${totalUserSleep}`
        : `${count}`;
}

/**
 * Sends combined data (heart rate, sleep, location) to the companion app
 *
 * @param {Object} data - The combined heart rate and sleep data to be sent to the companion app.
 */
function sendMessageToCompanion(data) {
    if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
        messaging.peerSocket.send(data);
    } else {
        console.log("Error: Connection is not open");
    }
}

/**
 * Retrieves heart rate, sleep data, and geolocation and sends it to the companion app.
 *
 * @param {HeartRateSensor} hrm - The HeartRateSensor instance.
 * @param {Object} sleep - The sleep object containing sleep data.
 */
function getAndSendPatientData(hrm, sleep) {
    if (appbit.permissions.granted("access_heart_rate") && appbit.permissions.granted("access_sleep")) {
        sendMessageToCompanion({
            type: "combined_data",
            heartRate: hrm.heartRate,
            sleep: sleep.state,
            positionLongitude: floatToDecimalString(latestLongitude, 6),
            positionLatitude: floatToDecimalString(latestLatitude, 6)
        });
    } else {
        console.log("No permission to access the heart rate API");
    }
}

/**
 * Converts a float value to a decimal string with a specified number of decimal places
 *
 * @param value - The float value to be converted to a decimal string
 * @param decimalPlaces - The number of decimal places to be included in the decimal string
 */
function floatToDecimalString(value, decimalPlaces) {
    if (value === null) {
        console.log("Geolocation data has not been initialised yet");
    } else {
        return value.toFixed(decimalPlaces);
    }
}

// Start heart rate monitoring if the sensor is available and permission is granted
if (HeartRateSensor && sleep) {
    const hrm = new HeartRateSensor();
    hrm.start();

    // Get heart rate and sleep data every 60 seconds
    setInterval(() => {
        geolocation.getCurrentPosition(locationSuccess, locationError, {timeout: 60 * 1000});
        getAndSendPatientData(hrm, sleep);
    }, 60 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

/**
 * Updates latestLatitude and latestLongitude on successful geolocation retrieval
 *
 * @param position - The position object containing the latitude and longitude.
 */
function locationSuccess(position) {
    latestLatitude = position.coords.latitude;
    latestLongitude = position.coords.longitude;
}

/**
 * Logs an error message if geolocation retrieval fails
 *
 * @param error - The error object containing the error code and message.
 */
function locationError(error) {
    console.log("Error: " + error.code, "Message: " + error.message);
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;
