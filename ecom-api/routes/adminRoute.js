const express  = require("express");
const { getAllAdmins } = require("../controllers/adminController");
const adminMiddleware = require("../middlewares/adminMiddleware");
const authMiddleware = require("../middlewares/authMiddleware");
const router =  express.Router();


router.get("/",authMiddleware, adminMiddleware, getAllAdmins);
module.exports=router;