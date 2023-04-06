import clock from "clock";
import * as document from "document";
import * as messaging from "messaging";

// Update the clock every minute
clock.granularity = "minutes";

// Get a handle on the <text> element
const testText = document.getElementById("testText");
let count = 0;

// Message is received from companion
messaging.peerSocket.onmessage = evt => {
    const totalUserSleep = evt.data.totalMinutesAsleep;
    count += 1
    // Am I Tired?
    if (totalUserSleep) {
        // Had at least 5 hours sleep
        testText.text = `Awake! ${totalUserSleep}`;
    } else {
        // Had less than 5 hours sleep
        testText.text = `${count}`;
    }
};