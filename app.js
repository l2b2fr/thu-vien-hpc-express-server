// app.js
const express = require("express");
const dotenv = require("dotenv");
const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");
const cors = require("cors");
const path = require("path");
const { authenticateToken } = require("./middlewares/authMiddleware");

dotenv.config();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use(
  cors({
    origin: "http://localhost:3000", // Allow front-end at localhost:3000
    methods: "GET,POST,PUT,DELETE", // Allow only certain HTTP methods
    credentials: true, // Allow credentials (cookies, etc.) to be sent
  })
);

app.use("/api/auth", authRoutes);

app.use("/api/user", authenticateToken, userRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
