/**
 * Fetches sleep data for the given date using the provided access token.
 *
 * @param {string} date - The date to fetch sleep data for (YYYY-MM-DD).
 * @param {string} accessToken - The Fitbit API access token.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 * @returns {Promise<object>} - The sleep data response as a JSON object.
 */
export async function fetchSleepData(date, accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1.2/user/-/sleep/date/${date}.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}