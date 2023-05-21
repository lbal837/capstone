// Import necessary modules
import clock from "clock";
import * as document from "document";
import {preferences} from "user-settings";
import {HeartRateSensor} from "heart-rate";
import {Accelerometer} from "accelerometer";
import {Barometer} from "barometer";
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
const sendCount = document.getElementById("sendCount");
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
    sendCount.text = `${count}`;
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
 * Retrieves heart rate, sleep data, and barometer data and sends it to the companion app.
 *
 * @param {HeartRateSensor} hrm - The HeartRateSensor instance.
 * @param {Object} accel - The accelerometer data object.
 * @param {Object} bodyPresence - The body presence data object.
 * @param {Object} baro - The barometer data object.
 */
function getAndSendPatientData(hrm, accel, bodyPresence, baro) {
    if (bodyPresence.present === false) {
        console.log("The watch is not being worn.");
        return;
    }

    if (appbit.permissions.granted("access_heart_rate") === false && appbit.permissions.granted("access_activity") === false) {
        console.log("No permission to access the heart rate API and activity API");
        return;
    }

    processSensorData(hrm.heartRate, accel.x, accel.y, accel.z);

    const minuteRecords = minuteHistory.query({limit: 1});

    sendMessageToCompanion({
        type: "combined_data",
        heartRate: hrm.heartRate,
        steps: minuteRecords[0].steps || 0,
        sleepStatus: sleepStatus,
        pressure: baro.pressure
    });
}

// Start heart rate, accelerometer, and barometer monitoring if the sensor is available and permission is granted
if (HeartRateSensor && Accelerometer && Barometer) {
    const hrm = new HeartRateSensor({frequency: 1});
    const accel = new Accelerometer({frequency: 1});
    const bodyPresence = new BodyPresenceSensor();
    const baro = new Barometer({frequency: 1});

    hrm.start();
    accel.start();
    bodyPresence.start();
    baro.start();

    // Get heart rate, sleep data, and barometer data every 60 seconds
    setInterval(() => {
        getAndSendPatientData(hrm, accel, bodyPresence, baro);
    }, 60 * 1000);
} else {
    console.log("No permission to access the heart rate API, accelerometer API, or barometer API or the sensors are not available");
}

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;
