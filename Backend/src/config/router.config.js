const router = require("express").Router();
const authRoutes = require("../modules/auth/auth.router"); // adjust path as needed

router.use("/auth", authRoutes);

module.exports = router;
