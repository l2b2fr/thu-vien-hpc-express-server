const db = require("../config/db");

const createAccount = (accountData) => {
  const query = `
    INSERT INTO tb_tai_khoan (idPhanQuyen, idNguoiDung, taiKhoan, matKhau, trangThai, eventType)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  return new Promise((resolve, reject) => {
    db.execute(
      query,
      [
        accountData.idPhanQuyen || null,
        accountData.idNguoiDung || null,
        accountData.taiKhoan || null,
        accountData.matKhau || null,
        accountData.trangThai || null,
        accountData.eventType || null,
      ],
      (err, result) => {
        if (err) {
          console.error(err); // Log l��i vào console
          reject(err); // Nếu có lỗi, trả về lỗi
        } else {
          console.log(result);
          resolve(result); // Nếu thành công, trả về kết quả
        }
      }
    );
  });
};

const updateAccount = (idNguoiDung, accountData) => {
  const query = `
    UPDATE tb_tai_khoan
    SET idPhanQuyen = ?, taiKhoan = ?, matKhau = ?, trangThai = ?, eventType = ?
    WHERE idNguoiDung = ?
  `;

  return new Promise((resolve, reject) => {
    db.execute(
      query,
      [
        accountData.idPhanQuyen,
        accountData.taiKhoan,
        accountData.matKhau,
        accountData.trangThai,
        accountData.eventType,
        idNguoiDung,
      ],
      (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
      }
    );
  });
};

const deleteAccountByUserId = async (idNguoiDung) => {
  const query = `DELETE FROM tb_tai_khoan WHERE idNguoiDung = ?`;

  try {
    const [result] = await db.execute(query, [idNguoiDung]);
    return result;
  } catch (err) {
    throw err;
  }
};

// Export all functions
module.exports = { createAccount, updateAccount, deleteAccountByUserId };
