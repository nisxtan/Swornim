const router = require("express").Router();
const authRoutes = require("../modules/auth/auth.router"); // adjust path as needed
const catererRouter = require("../modules/caterer/caterer.router");
const decoratorRouter = require("../modules/decorator/decorator.router");
const makeupArtistRouter = require("../modules/makeupartist/makeupartist.router");
const photographerRoutes = require("../modules/photographer/photographer.router");
const userRouter = require("../modules/user/user.router");

router.use("/auth", authRoutes);
router.use("/photographers", photographerRoutes);
router.use("/users", userRouter);
router.use("/makeup-artists", makeupArtistRouter);
router.use('/caterers',catererRouter)
router.use('/decorators',decoratorRouter)
module.exports = router;
