import getCurrentDateInNZST from '../companion/dateUtils.js';

describe('New Zealand Daylight Saving Time utilities', () => {

    describe('Date prototype extensions', () => {
        test('returns the last Sunday of the month', () => {
            // Arrange
            const sut = new Date('2021-08-01');

            // Act
            const result = sut.getLastSunday(sut);

            // Assert
            expect(result.toISOString()).toBe('2021-08-28T12:00:00.000Z');
        });

        test('returns the first Sunday of the month', () => {
            // Arrange
            const sut = new Date('2021-08-01');

            // Act
            const result = sut.getFirstSunday(sut);

            // Assert
            expect(result.toISOString()).toBe('2021-07-31T12:00:00.000Z');
        });
    });

    describe('getCurrentDateInNZST', () => {
        test('returns a formatted NZST date string', () => {
            // Arrange
            const sut = new Date('2021-09-30T10:00:00Z');

            // Act
            const result = getCurrentDateInNZST(sut);

            // Assert
            expect(result).toBe("30 September 2021 at 10:00:00 pm");
        });

    });
});