import * as messaging from "messaging";
import {settingsStorage} from "settings";

function fetchSleepData(accessToken) {
    // Initialise variables
    let date = new Date();
    let todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; //YYYY-MM-DD

    let responseData = {
        totalMinutesAsleep : 0
    }

    // Fetch Sleep Data from Fitbit Web API
    fetch(`https://api.fitbit.com/1.2/user/-/sleep/date/${todayDate}.json`, {
        method: "GET",
        headers: {
            "Authorization": `Bearer ${accessToken}`
        }
    })
        .then(response => response.json())
        .then(data => {
            responseData.totalMinutesAsleep = data.summary.totalMinutesAsleep;
            if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
                messaging.peerSocket.send(responseData);
            }
        })
        .catch(err => console.log('[FETCH]: ' + err));
}

// A user changes Settings
settingsStorage.onchange = evt => {
    if (evt.key === "oauth") {
        // Settings page sent us an oAuth token
        let data = JSON.parse(evt.newValue);

        console.log(data.user_id);

        // Sends data to the watch every 15 seconds
        setInterval(() => fetchSleepData(data.access_token), 15 * 1000);
    }
};

// Restore previously saved settings and send to the device
function restoreSettings() {
    for (let index = 0; index < settingsStorage.length; index++) {
        let key = settingsStorage.key(index);
        if (key && key === "oauth") {
            // We already have an oauth token
            let data = JSON.parse(settingsStorage.getItem(key));

            // Sends data to the watch every 15 seconds
            setInterval(() => fetchSleepData(data.access_token), 15 * 1000);
        }
    }
}

// Message socket opens
messaging.peerSocket.onopen = () => {
    restoreSettings();
};