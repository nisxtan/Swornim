require("./database.config.js");
const express = require("express");
const router = require("./router.config.js");
const app = express();

app.use(
  express.json({
    limit: "10mb",
  })
);

app.use(
  express.urlencoded({
    extended: true,
  })
);

//? Mounting / loading
app.use("/api/v1", router); // versioning

//! 404 handler - resource not found
app.use((req, res, next) => {
  next({
    detail: "value",
    message: "Resource not found.",
    code: 404,
    status: "RESOURCE_NOT_FOUND",
    options: null,
  });
});

//! Error handling middleware
app.use((error, req, res, next) => {
  console.log(error);

  // Ensure code is a valid HTTP status code number
  let code = parseInt(error.code, 10);
  if (isNaN(code) || code < 100 || code > 599) {
    code = 500;
  }

  let detail = error.detail || null;
  let message = error.message || "Internal Server Error";
  let status = error.status || "";

  res.status(code).json({
    error: detail,
    message: message,
    status: code,
    options: null,
  });
});

module.exports = app;
