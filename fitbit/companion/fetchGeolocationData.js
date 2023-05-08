import {geolocation} from "geolocation";

export async function getGeoLocationData() {
    return new Promise((resolve, reject) => {
        geolocation.getCurrentPosition(
            (position) => {
                const latitude = position.coords.latitude.toFixed(6);
                const longitude = position.coords.longitude.toFixed(6);
                resolve({latitude, longitude});
            },
            (error) => {
                reject(error);
            }
        );
    });
}