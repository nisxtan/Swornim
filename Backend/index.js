const http = require("http");

const app = require("./config/express.config");

const httpServer = http.createServer(app);
const PORT = 9009;
const host = "127.0.0.1";
httpServer.listen(PORT, host, (err) => {
  console.log(`Server is running on port:${PORT}`);
  console.log(`URL: http://${host}:${PORT}`);
});
