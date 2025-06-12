require("dotenv").config();

const DatabaseConfig = {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  dialect: "postgres",
};

const AppConfig = {
  jwtAccessSecret: process.env.JWT_ACCESS_SECRET,
  jwtRefreshSecret: process.env.JWT_REFRESH_SECRET,
  jwtAccessExpiry: process.env.JWT_ACCESS_EXPIRY || "1h",
  jwtRefreshExpiry: process.env.JWT_REFRESH_EXPIRY || "7d",
  frontendUrl: process.env.FRONTEND_URL || "http://localhost:3000",
  port: process.env.PORT || 9005,
  host: process.env.HOST || "127.0.0.1",
};

const EmailConfig = {
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  secure: false,
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD,
  },
  from: {
    email: process.env.FROM_EMAIL,
    name: process.env.FROM_NAME,
  },
};

module.exports = {
  DatabaseConfig,
  AppConfig,
  EmailConfig,
};
