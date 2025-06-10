require("./database");
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

//?mounting / loading
app.use("/api/v1", router); //versioning

//!error
app.use((req, res, next) => {
  next({
    detail: "value",
    message: "Resource not found.",
    code: 404,
    status: "RESOURCE_NOT_FOUND",
    options: null,
  });
  console.log("I am here");
});

app.use((error, req, res, next) => {
  console.log(error);
  let code = error.code || 500;
  let detail = error.detail || null;
  let message = error.message || "Internal Server Error";
  let status = error.status || "";
  //unique validation

  //?generic middleware
  res.status(code).json({
    error: detail,
    message: message,
    status: code,
    options: null,
  });
});

module.exports = app;
