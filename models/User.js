// models/User.js
const db = require("../config/db");

class User {
  static async findByUsername(username) {
    const [rows] = await db.execute(
      "SELECT * FROM tb_tai_khoan WHERE taiKhoan = ?",
      [username]
    );
    return rows[0];
  }

  static async findUserByMaNguoiDung(maNguoiDung) {
    try {
      const [rows] = await db.execute(
        "SELECT * FROM tb_nguoi_dung WHERE maNguoiDung = ?",
        [maNguoiDung]
      );

      // Kiểm tra xem có dữ liệu không
      if (rows.length === 0) {
        return null; // Trả về null nếu không tìm thấy người dùng
      }

      return rows[0]; // Trả về người dùng đầu tiên
    } catch (error) {
      console.error("Error fetching user:", error);
      throw new Error("Lỗi khi lấy thông tin người dùng");
    }
  }

  static async getAllNguoiDung() {
    const query = `SELECT * FROM tb_nguoi_dung, tb_tai_khoan WHERE  tb_nguoi_dung.id = tb_tai_khoan.idNguoiDung`;

    try {
      // Use the promise-based API to execute the query
      const [results] = await db.execute(query);
      return results;
    } catch (err) {
      throw err; // Propagate the error to be handled in the controller
    }
  }

  static async createUser(userData) {
    const query = `
      INSERT INTO tb_nguoi_dung (maNguoiDung, tenNguoiDung, phone, ngaySinh, queQuan, diaChi, email, imageUrl, ghiChu, eventType)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    try {
      const [result] = await db.execute(query, [
        userData.maNguoiDung || null,
        userData.tenNguoiDung || null,
        userData.phone || null,
        userData.ngaySinh || null,
        userData.queQuan || null,
        userData.diaChi || null,
        userData.email || null,
        userData.imageUrl || null,
        userData.ghiChu || null,
        userData.eventType || null,
      ]);
      console.log(result);
      return result; // Trả về kết quả insert, bao gồm `insertId`
    } catch (err) {
      throw err; // Nếu có lỗi, ném ra
    }
  }

  static async updateUser(id, userData) {
    const query = `
      UPDATE tb_nguoi_dung
      SET maNguoiDung = ?, tenNguoiDung = ?, phone = ?, ngaySinh = ?, queQuan = ?, diaChi = ?, email = ?, imageUrl = ?, ghiChu = ?, eventType = ?
      WHERE id = ?
    `;

    try {
      const [result] = await db.execute(query, [
        userData.maNguoiDung,
        userData.tenNguoiDung,
        userData.phone,
        userData.ngaySinh,
        userData.queQuan,
        userData.diaChi,
        userData.email,
        userData.imageUrl,
        userData.ghiChu,
        userData.eventType,
        id, // Cập nhật theo id người dùng
      ]);
      return result;
    } catch (err) {
      throw err;
    }
  }
  static async deleteUser(id) {
    const query = `DELETE FROM tb_nguoi_dung WHERE id = ?`;

    try {
      const [result] = await db.execute(query, [id]);
      return result;
    } catch (err) {
      throw err;
    }
  }
}

module.exports = User;
