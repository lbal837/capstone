import clock from "clock";
import * as document from "document";
import {preferences} from "user-settings";
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
const myLabel = document.getElementById("myLabel");
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
    myLabel.text = `${hours}:${mins}`;
}