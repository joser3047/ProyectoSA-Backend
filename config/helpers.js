const Mysqli = require('mysqli');
const jwt = require('jsonwebtoken');
//const bcrypt = require('bcrypt');

let conn = new Mysqli({
    Host: '35.226.125.64', // IP/domain name 
    post: 3306, // port, default 3306 
    user: 'root', // username 
    passwd: '1234', // password 
    db: 'proyectosa'
});

let db = conn.emit(false, '');

const secret = "1SBz93MsqTs7KgwARcB0I0ihpILIjk3w";

module.exports = {
    database: db
};
