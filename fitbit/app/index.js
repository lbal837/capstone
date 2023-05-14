// Import necessary modules
import clock from "clock";
import * as document from "document";
import {preferences} from "user-settings";
import {HeartRateSensor} from "heart-rate";
import {Accelerometer} from "accelerometer";
import {me as appbit} from "appbit";
import * as messaging from "messaging";
import {minuteHistory} from "user-activity";
import {BodyPresenceSensor} from "body-presence";

function zeroPad(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

// Set the granularity to update the clock every minute
clock.granularity = "minutes";

// Get a reference to the text element in the document
const testText = document.getElementById("testText");
const timeLabel = document.getElementById("timeLabel");
const patientLabel = document.getElementById("patientLabel");

// Update the <text> element every tick with the current time
clock.ontick = (evt) => {
    let today = evt.date;
    let hours = today.getHours();
    if (preferences.clockDisplay === "12h") {
        // 12h format
        hours = hours % 12 || 12;
    } else {
        // 24h format
        hours = zeroPad(hours);
    }
    let mins = zeroPad(today.getMinutes());
    timeLabel.text = `${hours}:${mins}`;
}


// Initialize the count variable for number of info sent to db
let count = 0;
let userId = '';
let sleepStatus = '';

/**
 * Handles incoming messages from the companion app.
 * Updates the text element based on the total sleep time received.
 *
 * @param {Object} evt - The event object containing the data sent from the companion app.
 */
function handleMessage(evt) {
    count += 1;
    //display userID
    userId = evt.data.UserId;
    patientLabel.text = `${userId}`;
    testText.text = `${count}`;
}

function processSensorData(heartRate, x, y, z) {
    const heartRateThreshold = 60; // Example threshold for heart rate
    const accelerometerThreshold = 0.01; // Example threshold for accelerometer activity

    const accelerometerMagnitude = Math.sqrt(x * x + y * y + z * z);

    if (heartRate <= heartRateThreshold && accelerometerMagnitude <= accelerometerThreshold) {
        // The user might be asleep
        sleepStatus = "Asleep";
    } else {
        // The user is probably awake
        sleepStatus = "Awake";
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
 * @param {Object} accel - The accelerometer data object.
 * @param {Object} bodyPresence - The body presence data object.
 */
function getAndSendPatientData(hrm, accel, bodyPresence) {
    if (bodyPresence.present === false) {
        console.log("The watch is not being worn.");
        return;
    }

    if (appbit.permissions.granted("access_heart_rate") === false && appbit.permissions.granted("access_activity") === false) {
        console.log("No permission to access the heart rate API and activity API");
        return;
    }

    const minuteRecords = minuteHistory.query({limit: 1});
    sendMessageToCompanion({
        type: "combined_data",
        heartRate: hrm.heartRate,
        steps: minuteRecords[0].steps || 0,
        sleepStatus: sleepStatus
    });

    // Call processSensorData function with heart rate and accelerometer data
    processSensorData(hrm.heartRate, accel.x, accel.y, accel.z);
}

// Start heart rate monitoring if the sensor is available and permission is granted
if (HeartRateSensor) {
    const hrm = new HeartRateSensor({frequency: 1});
    const accel = new Accelerometer({frequency: 1});
    const bodyPresence = new BodyPresenceSensor();

    hrm.start();
    accel.start();
    bodyPresence.start();

    // Get heart rate and sleep data every 60 seconds
    setInterval(() => {
        getAndSendPatientData(hrm, accel, bodyPresence);
    }, 60 * 1000);
} else {
    console.log("No permission to access the heart rate API or heart rate sensor is not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;