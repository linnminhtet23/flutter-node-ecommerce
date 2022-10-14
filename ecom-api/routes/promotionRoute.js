const express  = require("express");
const {getAllItems, getItem, createItem, updateItem, deletePromotionItem} = require("../controllers/promotionController");
const authMiddleware = require("../middlewares/authMiddleware");
const fileUpload = require("../middlewares/fileUploadMiddleware");
const router =  express.Router();

router.get("/", authMiddleware, getAllItems);
router.get("/:id", authMiddleware, getItem);
router.post("/create", authMiddleware, fileUpload.single('image'),createItem);
router.put("/edit/:id", authMiddleware, fileUpload.single('image'),updateItem)
router.delete("/delete/:id", authMiddleware, deletePromotionItem)

module.exports= router;