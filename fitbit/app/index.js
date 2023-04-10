// Import necessary modules
import clock from "clock";
import * as document from "document";
import {HeartRateSensor} from "heart-rate";
import {me as appbit} from "appbit";
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
    const totalUserSleep = evt.data.totalMinutesAsleep;
    count += 1;

    // Check if the user had enough sleep (at least 5 hours)
    if (totalUserSleep && totalUserSleep >= 300) { // 5 hours * 60 minutes = 300 minutes
        testText.text = `Awake! ${totalUserSleep}`;
    } else {
        testText.text = `${count}`;
    }
}

function sendMessageToCompanion(data) {
    if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
        messaging.peerSocket.send(data);
    } else {
        console.log("Error: Connection is not open");
    }
}

function getHeartRate(hrm) {
    if (appbit.permissions.granted("access_heart_rate")) {
        console.log(`Current heart rate: ${hrm.heartRate}`);
        sendMessageToCompanion({type: "heart_rate", value: hrm.heartRate});
    } else {
        console.log("No permission to access the heart rate API");
    }
}

if (HeartRateSensor && appbit.permissions.granted("access_heart_rate")) {
    const hrm = new HeartRateSensor();
    hrm.start();

    // Get the initial heart rate
    getHeartRate(hrm);

    // Get heart rate every 15 seconds
    setInterval(() => {
        getHeartRate(hrm);
    }, 15 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;