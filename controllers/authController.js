// controllers/authController.js
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

exports.login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await User.findByUsername(username);
    if (!user) {
      return res
        .status(405)
        .json({ message: "Tên người dùng hoặc mật khẩu không đúng." });
    }

    const isMatch = await bcrypt.compare(password, user.matKhau);
    if (!isMatch) {
      return res
        .status(405)
        .json({ message: "Tên người dùng hoặc mật khẩu không đúng." });
    }

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    res.json({ message: "Đăng nhập thành công", token, user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi hệ thống." });
  }
};
