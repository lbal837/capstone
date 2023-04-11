// Import necessary modules
import clock from "clock";
import * as document from "document";
import {HeartRateSensor} from "heart-rate";
import {me as appbit} from "appbit";
import * as messaging from "messaging";
import sleep from "sleep";

// Set the granularity to update the clock every minute
clock.granularity = "minutes";

// Get a reference to the text element in the document
const testText = document.getElementById("testText");

// Initialize the count variable
let count = 0;

/**
 * Handler for messages from the companion app.
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
 * Sends a message to the companion app.
 *
 * @param {Object} heartRateData - The heart rate data to be sent to the companion app.
 */
function sendMessageToCompanion(data) {
    if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
        messaging.peerSocket.send({
            type: "combined_data",
            heartRate: data.heartRate,
            sleep: data.sleep
        });
    } else {
        console.log("Error: Connection is not open");
    }
}

function getAndSendPatientData(hrm, sleep) {
    if (appbit.permissions.granted("access_heart_rate") && appbit.permissions.granted("access_sleep")) {
        console.log(`Current heart rate: ${hrm.heartRate}, Current sleep state: ${sleep.state}`);
        sendMessageToCompanion({type: "combined_data", heartRate: hrm.heartRate, sleep: sleep.state});
    } else {
        console.log("No permission to access the heart rate API");
    }
}

// Start heart rate monitoring if the sensor is available and permission is granted
if (HeartRateSensor && sleep) {
    const hrm = new HeartRateSensor();
    hrm.start();

    // Get heart rate every 60 seconds
    setInterval(() => {
        getAndSendPatientData(hrm, sleep);
    }, 15 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;