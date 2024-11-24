// routes/authRoutes.js
const express = require("express");
const router = express.Router();
const upload = require("../middlewares/upload");
const userController = require("../controllers/userController");

router.get("/getAllUser", userController.getAllUser);
// Add a user (with file upload)
router.post("/add", upload.single("imageUrl"), userController.addUser);
router.put("/update", upload.single("imageUrl"), userController.updateUser);
router.delete("/delete/:id", userController.deleteUser);
router.get("/getUserByMaNguoiDung/:maNguoiDung", userController.getUserByMaNguoiDung);
module.exports = router;
