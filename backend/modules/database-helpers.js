const mysql = require('mysql');
const util = require('util');
const pool = require('../db.js');

const DBQuery = util.promisify(pool.query).bind(pool);

const DBConnection = pool.getConnection( async (err, connection) => {
    if(err) {
        //await connection.release();
        console.error('DB connection issue', err);
        return;
    }
    connectionSuccessHandler();
    constructDB();
});

const connectionSuccessHandler = () => {
    console.log('Successful DB connection');
}

const constructDB = async () => {
    try {
        DBConfirmConnect = util.promisify(pool.connectToDatabase).bind(DBConnection);
        await DBConfirmConnect();

        const find = await DBQuery('CREATE DATABASE IF NOT EXISTS mainData');
        console.log('Successfully found or create user table');
    } catch(err) {
        console.log('Failed to find or create user table');
    }

    try {
        const userCheck = 'CREATE TABLE IF NOT EXISTS mainData.user (\
            id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,\
            firstName VARCHAR(30) NOT NULL,\
            lastName VARCHAR(30),\
            age INTEGER NOT NULL,\
            desiredRoommates INTEGER,\
            city VARCHAR(30) NOT NULL,\
            bio VARCHAR(300),\
            gender VARCHAR(7),\
            CONSTRAINT chkGender CHECK (gender IN (\'male\', \'female\')),\
            CONSTRAINT checkAge CHECK (age > 0 and age < 100))';
        const preferenceCheck = 'CREATE TABLE IF NOT EXISTS mainData.prefferences (\
            id INTEGER NOT NULL PRIMARY KEY,\
            housingPref JSON,\
            lifestylePref JSON)';
        await Promise.all(
            [
              DBQuery(userCheck),
              DBQuery(preferenceCheck)
            ]
          );
    } catch(err) {
        console.error('Failed to find or create tables');
    }
       // We return two things: a function that lets us run queries, and another to
       // disconnect from the DB at the end of a route
};
module.exports = DBQuery, constructDB;