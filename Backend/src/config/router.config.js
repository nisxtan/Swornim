const router = require("express").Router();
const authRoutes = require("../modules/auth/auth.router"); // adjust path as needed
const photographerRoutes = require("../modules/photographer/photographer.router");
const userRouter = require("../modules/user/user.router");

router.use("/auth", authRoutes);
router.use("/photographers", photographerRoutes);
router.use("/users", userRouter);
module.exports = router;
