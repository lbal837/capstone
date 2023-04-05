import clock from "clock";
import * as document from "document";
import * as messaging from "messaging";

function zeroPad(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

// Update the clock every minute
clock.granularity = "minutes";

// Get a handle on the <text> element
const testText = document.getElementById("testText");

// Message is received from companion
messaging.peerSocket.onmessage = evt => {
    // Am I Tired?
    if (evt.data.totalMinutesAsleep >= 300) {
        // Had at least 5 hours sleep
        testText.text = "Awake!";
    } else {
        // Had less than 5 hours sleep
        testText.text = "Sleepy...";
    }
};