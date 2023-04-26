const ENDPOINT = "https://sog1p6r867.execute-api.ap-southeast-2.amazonaws.com/Production/SendPatientData";
const APIKEY = "6iARIh8AkjalWSdsCbX084r9wJtq2Sd93MlLy3NX";

/**
 * Sends patient data to the specified endpoint.
 *
 * @param {object} data - The patient data object to send.
 * @param {string} [endpoint=ENDPOINT] - Optional API endpoint URL.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 */
export async function sendDataToEndpoint(data, endpoint = ENDPOINT, fetchFn = fetch) {
    await fetchFn(endpoint, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "x-api-key": APIKEY
        },
        body: JSON.stringify(data),
    });
}
