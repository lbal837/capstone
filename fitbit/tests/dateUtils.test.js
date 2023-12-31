import getCurrentDateInNZST from '../companion/dateUtils.js';

describe('New Zealand Daylight Saving Time utilities', () => {
    describe('getCurrentDateInNZST', () => {
        test('returns a formatted NZST date string', () => {
            // Arrange
            const sut = new Date('2021-09-30T10:00:00Z');

            // Act
            const result = getCurrentDateInNZST(sut);

            // Assert
            expect(result).toBe("2021-09-30T22:00:00.000Z");
        });

    });
});