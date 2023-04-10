/**
 * Fetches user profile data using the provided access token.
 *
 * @param {string} accessToken - The Fitbit API access token.
 * @param {function} [fetchFn=fetch] - Optional fetch function (useful for testing).
 * @returns {Promise<object>} - The user profile data response as a JSON object.
 */
export async function fetchUserProfile(accessToken, fetchFn = fetch) {
    const response = await fetchFn(`https://api.fitbit.com/1/user/-/profile.json`, {
        method: "GET",
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    });

    return response.json();
}