// middlewares/authMiddleware.js
const jwt = require("jsonwebtoken");

exports.authenticateToken = (req, res, next) => {
  const token = req.header("Authorization")?.split(" ")[1];
  if (!token)
    return res
      .status(401)
      .json({ message: "Không có token, vui lòng đăng nhập." });

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: "Token không hợp lệ." });
    req.user = user;
    next();
  });
};
