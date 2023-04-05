import * as messaging from "messaging";
import {settingsStorage} from "settings";

// Fetch Sleep Data from Fitbit Web API
async function fetchSleepData(accessToken) {
    try {
        let date = new Date();
        let todayDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`; //YYYY-MM-DD

        // Sleep API docs - https://dev.fitbit.com/reference/web-api/sleep/
        const response = await fetch(`https://api.fitbit.com/1.2/user/-/sleep/date/${todayDate}.json`, {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${accessToken}`
            }
        });

        const data = await response.json();
        let myData = {
            totalMinutesAsleep: data.summary.totalMinutesAsleep
        };

        if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
            messaging.peerSocket.send(myData);
        }
    } catch (err) {
        console.log('[FETCH]: ' + err);
    }
}

// Fetch User Data from Fitbit Web API
async function fetchUserProfile(accessToken) {
    try {
        // Sleep API docs - https://dev.fitbit.com/reference/web-api/sleep/
        const response = await fetch(`https://api.fitbit.com/1.2/user/-/profile.json`, {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${accessToken}`
            }
        });

        const data = await response.json();
        console.log(data);

    } catch (err) {
        console.log('[FETCH]: ' + err);
    }
}

// A user changes Settings
settingsStorage.onchange = evt => {
    if (evt.key === "oauth") {
        // Settings page sent us an oAuth token
        let data = JSON.parse(evt.newValue);
        console.log(data.user_id);
        fetchSleepData(data.access_token);
        fetchUserProfile(data.access_token);
    }
};

// Restore previously saved settings and send to the device
async function restoreSettings() {
    for (let index = 0; index < settingsStorage.length; index++) {
        let key = settingsStorage.key(index);
        if (key && key === "oauth") {
            // We already have an oauth token
            let data = JSON.parse(settingsStorage.getItem(key));
            await fetchSleepData(data.access_token);
        }
    }
}

// Message socket opens
messaging.peerSocket.onopen = () => {
    restoreSettings();
};