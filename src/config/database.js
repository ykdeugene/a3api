const mysql = require("mysql")

const connectDatabase = mysql.createPool({
  connectionLimit: 100,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PW,
  database: process.env.DB_NAME,
  debug: process.env.DB_NAME === "true",
})

module.exports = connectDatabase
