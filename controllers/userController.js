const User = require("../models/User");
const Account = require("../models/Account");
const hashPassword = require("../utils/hashPassword");
const fs = require("fs");
const baseURL = "http://localhost:2004/";

exports.getAllUser = async (req, res) => {
  try {
    const users = await User.getAllNguoiDung();
    if (!users || users.length === 0) {
      return res.status(404).json({ message: "Không có người dùng nào." });
    }

    // Đảm bảo chỉ gán `baseURL` khi `imageUrl` chưa có `baseURL`
    const usersWithFullPath = users.map((user) => ({
      ...user,
      imageUrl:
        user.imageUrl && !user.imageUrl.startsWith(baseURL)
          ? `${baseURL}${user.imageUrl}`
          : user.imageUrl,
    }));

    res.json({ users: usersWithFullPath });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi hệ thống." });
  }
};

exports.getUserByMaNguoiDung = async (req, res) => {
  const { maNguoiDung } = req.params;

  try {
    const user = await User.findUserByMaNguoiDung(maNguoiDung);

    if (!user) {
      return res.status(404).json({ message: "Không tìm thấy người dùng." });
    }

    // Đảm bảo rằng đường dẫn hình ảnh bao gồm `baseURL` nếu cần
    if (user.imageUrl && !user.imageUrl.startsWith(baseURL)) {
      user.imageUrl = `${baseURL}${user.imageUrl}`;
    }

    res.json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi hệ thống.", error: error.message });
  }
};

exports.addUser = async (req, res) => {
  const {
    maNguoiDung,
    idPhanQuyen,
    tenNguoiDung,
    phone,
    ngaySinh,
    queQuan,
    diaChi,
    email,
    ghiChu,
    taiKhoan,
    matKhau,
    trangThai,
  } = req.body;

  // Đảm bảo chỉ gán `baseURL` khi `req.file` có tồn tại và `imageUrl` chưa có `baseURL`
  const imageUrl = req.file
    ? req.file.filename.startsWith(baseURL)
      ? req.file.filename
      : `${baseURL}uploads/${req.file.filename}`
    : null;

  const userData = {
    maNguoiDung,
    tenNguoiDung,
    phone,
    ngaySinh,
    queQuan,
    diaChi,
    email,
    imageUrl,
    ghiChu: ghiChu || null,
    eventType: "CREATE",
  };

  try {
    const userResult = await User.createUser(userData);
    if (!userResult || !userResult.insertId) {
      return res.status(500).json({ message: "Failed to create user." });
    }

    const hashedPassword = await hashPassword(matKhau);
    const accountData = {
      idPhanQuyen,
      idNguoiDung: userResult.insertId,
      taiKhoan,
      matKhau: hashedPassword,
      trangThai: trangThai !== undefined ? trangThai : true,
      eventType: "CREATE",
    };

    const accountResult = Account.createAccount(accountData);
    if (accountResult) {
      return res.status(201).json({
        message: "Chúc mừng, Bạn đã tạo người dùng và tài khoản thành công!",
      });
    } else {
      return res.status(500).json({ message: "Failed to create account." });
    }
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ message: "Error processing request", error: error.message });
  }
};

exports.updateUser = async (req, res) => {
  const {
    id,
    maNguoiDung,
    tenNguoiDung,
    phone,
    ngaySinh,
    queQuan,
    diaChi,
    email,
    ghiChu,
    taiKhoan,
    matKhau,
    idPhanQuyen,
    trangThai,
  } = req.body;

  let imageUrl = req.file ? `${baseURL}uploads/${req.file.filename}` : null;

  // Kiểm tra `imageUrl` có phải là Base64 không và chỉ lưu khi đúng định dạng
  if (req.body.imageUrl && req.body.imageUrl.startsWith("data:image")) {
    try {
      imageUrl = await saveBase64Image(req.body.imageUrl);
    } catch (err) {
      return res
        .status(500)
        .json({ message: "Error saving base64 image", error: err.message });
    }
  }

  const userData = {
    maNguoiDung,
    tenNguoiDung,
    phone,
    ngaySinh,
    queQuan,
    diaChi,
    email,
    imageUrl:
      imageUrl && !imageUrl.startsWith(baseURL)
        ? `${baseURL}${imageUrl}`
        : imageUrl,
    ghiChu,
    eventType: "UPDATE",
  };

  try {
    const userResult = await User.updateUser(id, userData);
    if (!userResult) {
      return res
        .status(404)
        .json({ message: "User not found or update failed." });
    }

    if (matKhau) {
      const hashedPassword = await hashPassword(matKhau);
      const accountData = {
        idPhanQuyen,
        idNguoiDung: id,
        taiKhoan,
        matKhau: hashedPassword,
        trangThai,
        eventType: "UPDATE",
      };

      const accountResult = Account.updateAccount(id, accountData);
      if (!accountResult) {
        return res.status(500).json({ message: "Failed to update account." });
      }
    }

    res.status(200).json({ message: "User updated successfully!" });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ message: "Error processing request", error: error.message });
  }
};

// Hàm lưu ảnh Base64
const saveBase64Image = (base64String) => {
  const matches = base64String.match(
    /^data:image\/([a-zA-Z]*);base64,([^\"]*)$/
  );
  const extension = matches[1];
  const base64Data = matches[2];
  const filePath = `uploads/${Date.now()}.${extension}`;

  return new Promise((resolve, reject) => {
    fs.writeFile(filePath, base64Data, "base64", (err) => {
      if (err) {
        reject(err);
      } else {
        resolve(`${baseURL}${filePath}`);
      }
    });
  });
};

exports.deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    // Kiểm tra xem người dùng có tồn tại không
    const user = User.findUserByMaNguoiDung(id);
    if (!user) {
      return res.status(404).json({ message: "Không tìm thấy người dùng." });
    }

    // Xóa tài khoản liên quan đến người dùng trong bảng tb_tai_khoan
    Account.deleteAccountByUserId(id);

    // Xóa người dùng trong bảng tb_nguoi_dung
    const deleteResult = User.deleteUser(id);
    if (deleteResult.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Xóa người dùng không thành công." });
    }

    res.status(200).json({ message: "Người dùng đã được xóa thành công." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi hệ thống.", error: error.message });
  }
};
