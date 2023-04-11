// Import necessary modules
import clock from "clock";
import * as document from "document";
import {HeartRateSensor} from "heart-rate";
import {me as appbit} from "appbit";
import * as messaging from "messaging";
import sleep from "sleep";
import {minuteHistory} from "user-activity";

// Set the granularity to update the clock every minute
clock.granularity = "minutes";

// Get a reference to the text element in the document
const testText = document.getElementById("testText");

// Initialize the count variable
let count = 0;

/**
 * Handles incoming messages from the companion app.
 * Updates the text element based on the total sleep time received.
 *
 * @param {Object} evt - The event object containing the data sent from the companion app.
 */
function handleMessage(evt) {
    const totalUserSleep = evt.data.TotalMinutesAsleep;
    count += 1;

    // Check if the user had enough sleep (at least 5 hours)
    if (totalUserSleep && totalUserSleep >= 300) {
        testText.text = `Awake! ${totalUserSleep}`;
    } else {
        testText.text = `${count}`;
    }
}

/**
 * Sends heart rate and sleep data to the companion app.
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
 * Retrieves heart rate and sleep data and sends it to the companion app.
 *
 * @param {HeartRateSensor} hrm - The HeartRateSensor instance.
 * @param {Object} sleep - The sleep object containing sleep data.
 */
function getAndSendPatientData(hrm, sleep) {
    if (appbit.permissions.granted("access_heart_rate") && appbit.permissions.granted("access_sleep") && appbit.permissions.granted("access_activity")) {
        const minuteRecords = minuteHistory.query({limit: 1});
        sendMessageToCompanion({
            type: "combined_data",
            heartRate: hrm.heartRate,
            sleep: sleep.state,
            steps: minuteRecords[0].steps || 0
        });
    } else {
        console.log("No permission to access the heart rate API");
    }
}

// Start heart rate monitoring if the sensor is available and permission is granted
if (HeartRateSensor && sleep) {
    const hrm = new HeartRateSensor();
    hrm.start();

    // Get heart rate and sleep data every 60 seconds
    setInterval(() => {
        getAndSendPatientData(hrm, sleep);
    }, 15 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;
