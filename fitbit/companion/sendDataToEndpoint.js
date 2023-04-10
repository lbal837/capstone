const ENDPOINT = "https://sog1p6r867.execute-api.ap-southeast-2.amazonaws.com/Production/SendPatientData";

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
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(data),
    });
}