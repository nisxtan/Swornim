const router = require("express").Router();
const authRoutes = require("../modules/auth/auth.router"); // adjust path as needed
const photographerRoutes = require("../modules/photographer/photographer.router");

router.use("/auth", authRoutes);
router.use("/photographers", photographerRoutes);

module.exports = router;
