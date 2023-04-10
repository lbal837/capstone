// Import necessary modules
import clock from "clock";
import * as document from "document";
import { HeartRateSensor } from "heart-rate";
import { me as appbit } from "appbit";
import * as messaging from "messaging";

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
 * @param {Object} data - The data to be sent to the companion app.
 */
function sendMessageToCompanion(data) {
    if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
        messaging.peerSocket.send(data);
    } else {
        console.log("Error: Connection is not open");
    }
}

/**
 * Gets and sends the heart rate to the companion app.
 *
 * @param {HeartRateSensor} hrm - The HeartRateSensor instance.
 */
function getHeartRate(hrm) {
    if (appbit.permissions.granted("access_heart_rate")) {
        console.log(`Current heart rate: ${hrm.heartRate}`);
        sendMessageToCompanion({ type: "heart_rate", value: hrm.heartRate });
    } else {
        console.log("No permission to access the heart rate API");
    }
}

// Start heart rate monitoring if the sensor is available and permission is granted
if (HeartRateSensor && appbit.permissions.granted("access_heart_rate")) {
    const hrm = new HeartRateSensor();
    hrm.start();

    // Get the initial heart rate
    getHeartRate(hrm);

    // Get heart rate every 60 seconds
    setInterval(() => {
        getHeartRate(hrm);
    }, 60 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;