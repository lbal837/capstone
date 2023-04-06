function isNZDST(date) {
    const lastSundayOfSeptember = new Date(date.getFullYear(), 8, -0).getLastSunday();
    const firstSundayOfApril = new Date(date.getFullYear(), 3, 1).getFirstSunday();

    return date >= lastSundayOfSeptember && date < firstSundayOfApril;
}

Date.prototype.getLastSunday = function () {
    const lastDayOfMonth = new Date(this.getFullYear(), this.getMonth() + 1, 0);
    const day = lastDayOfMonth.getDay();
    return new Date(lastDayOfMonth.setDate(lastDayOfMonth.getDate() - day));
};

Date.prototype.getFirstSunday = function () {
    const firstDayOfMonth = new Date(this.getFullYear(), this.getMonth(), 1);
    const day = firstDayOfMonth.getDay();
    return new Date(firstDayOfMonth.setDate(firstDayOfMonth.getDate() + (7 - day) % 7));
};

function getCurrentDateInNZST() {
    const now = new Date();

    const nzOffset = 12 * 60;
    const nzdtOffset = 13 * 60;

    const isDaylightSaving = isNZDST(now);
    const nzCurrentOffset = isDaylightSaving ? nzdtOffset : nzOffset;

    const nzMilliseconds = now.getTime() + (nzCurrentOffset * 60 * 1000);
    const nzDate = new Date(nzMilliseconds);

    return nzDate.toLocaleString('en-NZ', {
        timeZone: 'UTC',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
}

export default getCurrentDateInNZST;