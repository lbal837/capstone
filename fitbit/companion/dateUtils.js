/**
 * Determines if the given date is within New Zealand Daylight Saving Time (NZDST).
 *
 * @param {Date} date - The date to check.
 * @returns {boolean} True if the date is within NZDST, false otherwise.
 */
function isNZDST(date) {
    const lastSundayOfSeptember = new Date(date.getFullYear(), 8, 0).getLastSunday();
    const firstSundayOfApril = new Date(date.getFullYear(), 3, 1).getFirstSunday();

    return date >= lastSundayOfSeptember && date < firstSundayOfApril;
}

/**
 * Gets the last Sunday of the current month for the Date object.
 *
 * @returns {Date} The last Sunday of the month.
 */
Date.prototype.getLastSunday = function () {
    const lastDayOfMonth = new Date(this.getFullYear(), this.getMonth() + 1, 0);
    const day = lastDayOfMonth.getDay();
    return new Date(lastDayOfMonth.setDate(lastDayOfMonth.getDate() - day));
};

/**
 * Gets the first Sunday of the current month for the Date object.
 *
 * @returns {Date} The first Sunday of the month.
 */
Date.prototype.getFirstSunday = function () {
    const firstDayOfMonth = new Date(this.getFullYear(), this.getMonth(), 1);
    const day = firstDayOfMonth.getDay();
    return new Date(firstDayOfMonth.setDate(firstDayOfMonth.getDate() + (7 - day) % 7));
};

/**
 * Gets the current date and time in New Zealand Standard Time (NZST) format.
 *
 * @returns {string} The formatted date and time string in NZST.
 */
function getCurrentDateInNZST(date) {
    const nzOffset = 12 * 60;
    const nzdtOffset = 13 * 60;

    const isDaylightSaving = isNZDST(date);
    const nzCurrentOffset = isDaylightSaving ? nzdtOffset : nzOffset;

    const nzMilliseconds = date.getTime() + (nzCurrentOffset * 60 * 1000);
    const nzDate = new Date(nzMilliseconds);

    let currentDate = nzDate.toLocaleString('en-NZ', {
        timeZone: 'UTC',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
    return currentDate.replace(/[\u00A0\u202F]/g, ' ');
}

module.exports = {
    getCurrentDateInNZST,
    isNZDST,
};