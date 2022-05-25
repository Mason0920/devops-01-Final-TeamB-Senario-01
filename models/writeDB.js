const mysql = require('mysql');
const dotenv = require('dotenv');
dotenv.config();

const con = mysql.createConnection({
  host: process.env.WRITE_DATABASE_HOST,
  user: process.env.WRITE_DATABASE_USER,
  password: process.env.WRITE_DATABASE_PASSWORD,
  port: process.env.WRITE_DATABASE_PORT
});

con.connect(err => { 
  if (err) console.log("write_DB_MySQL 연결 실패 : ", err); 
  console.log("write_DB_MySQL Connected!!!"); 
})

module.exports = con;
