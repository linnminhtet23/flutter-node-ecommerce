const express = require("express");
const {
  getAllAdmins,
  adminCreate,
  adminSignIn,
  getAdmin,
  getAdminProfile,
} = require("../controllers/adminController");
const adminAuthMiddleware = require("../middlewares/adminAuthMiddleware");
const adminMiddleware = require("../middlewares/adminMiddleware");
const adminSignUpSchema = require("../schema/Admin/adminSignUpSchema");
const adminSignInSchema = require("../schema/Admin/adminSignInSchema");

const router = express.Router();

router.get("/", adminAuthMiddleware, adminMiddleware, getAllAdmins);
router.get("/:id", adminAuthMiddleware, adminMiddleware, getAdmin);
router.get("/profile",adminAuthMiddleware, getAdminProfile);
router.post("/create", adminSignUpSchema, adminCreate);
router.post("/sign-in", adminSignInSchema, adminSignIn);

module.exports = router;
