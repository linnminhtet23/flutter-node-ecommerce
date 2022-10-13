const express = require("express");
const {
  getAllUsers,
  userSignUp,
  userSignIn,
  getUser,
  getUserProfile,
} = require("../controllers/userController");
const authMiddleware = require("../middlewares/authMiddleware");
const signInSchema = require("../schema/User/signInSchema");
const signUpSchema = require("../schema/User/signUpSchema");
const router = express.Router();

router.get("/", authMiddleware, getAllUsers);
router.get("/:id", authMiddleware, getUser);
router.get("/profile", authMiddleware, getUserProfile);
router.post("/io-register", signUpSchema, userSignUp);
router.post("/io-login", signInSchema, userSignIn);

module.exports = router;
