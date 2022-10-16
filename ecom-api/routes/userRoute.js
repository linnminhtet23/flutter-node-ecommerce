const express = require("express");
const {
  getAllUsers,
  userSignUp,
  userSignIn,
  getUser,
  getUserProfile,
  userSignOut,
} = require("../controllers/userController");
const adminAuthMiddleware = require("../middlewares/adminAuthMiddleware");
const adminMiddleware = require("../middlewares/adminMiddleware");
const authMiddleware = require("../middlewares/authMiddleware");
const signInSchema = require("../schema/User/signInSchema");
const signUpSchema = require("../schema/User/signUpSchema");
const router = express.Router();

router.get("/", adminAuthMiddleware, adminMiddleware, getAllUsers);
router.get("/:id", adminAuthMiddleware, adminMiddleware, getUser);
router.get("/profile", authMiddleware, getUserProfile);
router.post("/io-register", signUpSchema, userSignUp);
router.post("/io-login", signInSchema, userSignIn);
router.post("/logout", authMiddleware, userSignOut);

module.exports = router;
