require("dotenv").config();

// console.log("🔍 Debug - Environment variables:");
// console.log("DB_HOST:", process.env.DB_HOST);
// console.log("DB_USER:", process.env.DB_USER);
// console.log(
//   "DB_PASSWORD:",
//   process.env.DB_PASSWORD ? "***HIDDEN***" : "NOT SET"
// );
// console.log("DB_NAME:", process.env.DB_NAME);
// console.log("DB_PORT:", process.env.DB_PORT);
const DatabaseConfig = {
  host: process.env.DB_HOST || 'localhost',
  username: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
  database: process.env.DB_NAME || 'swornim',
  port: process.env.DB_PORT || 5432,
  dialect: "postgres",
  logging: process.env.NODE_ENV === "development" ? console.log : false,
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000,
  },
};

module.exports = { DatabaseConfig };
