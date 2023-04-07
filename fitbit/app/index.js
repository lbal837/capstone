// Import necessary modules
import clock from "clock";
import * as document from "document";
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

// Listen for messages from the companion app
messaging.peerSocket.onmessage = handleMessage;