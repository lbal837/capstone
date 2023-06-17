import {ENDPOINT} from "../constants";

/**
 * Sends patient data to the specified endpoint.
 *
 * @param {object} data - The patient data object to send.
 * @param {string} [endpoint=ENDPOINT] - Optional API endpoint URL.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 */
export async function sendDataToEndpoint(data, endpoint = {ENDPOINT}, fetchFn = fetch) {
    await fetchFn(endpoint, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "x-api-key": {APIKEY}
        },
        body: JSON.stringify(data),
    });
}
