// Corresponds to the "AddCaregiverToRDS lambda function"

import AWS from "aws-sdk";
import pgp from "pg-promise";

const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME;

const pgpInstance = pgp();
const db = pgpInstance({
    host: dbHost,
    user: dbUser,
    password: dbPassword,
    database: dbName,
});

export const handler = async (event) => {
    // Debugging logs
    console.log("event");
    console.log(event);
    console.log("***********");

    // Extract the new user's username and email from the event
    const username = event.userName;
    const email = event.request.userAttributes.email;

    // Check if user already exists in the RDS instance
    const checkUserQuery = `
    SELECT username FROM users WHERE username = $1;
  `;

    const userExists = await db.oneOrNone(checkUserQuery, [username]);

    // If the user doesn't exist, insert into the database
    if (!userExists) {
        const insertQuery = `
      INSERT INTO users (username, email, patient_ids)
      VALUES ($1, $2, $3);
    `;
        await db.none(insertQuery, [username, email, []]);
    } else {
        console.log(`User with username ${username} already exists.`);
    }

    // Return the event object as required by the Post Confirmation trigger
    return event;
};
