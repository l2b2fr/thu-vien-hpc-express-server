CREATE TABLE `tb_phan_quyen` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`loaiPhanQuyen` VARCHAR(50),
	`tenPhanQuyen` VARCHAR(50),
	`ghiChu` TEXT,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tb_nguoi_dung` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`maNguoiDung` VARCHAR(20) NOT NULL UNIQUE,
	`tenNguoiDung` VARCHAR(50),
	`phone` VARCHAR(15),
	`ngaySinh` DATE,
	`queQuan` VARCHAR(100),
	`diaChi` VARCHAR(255),
	`email` VARCHAR(100),
	`imageUrl` VARCHAR(255),
	`ghiChu` TEXT,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tb_tai_khoan` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`idPhanQuyen` INT,
	`idNguoiDung` INT,
	`taiKhoan` VARCHAR(50) NOT NULL,
	`matKhau` VARCHAR(255) NOT NULL,
	`trangThai` BOOLEAN DEFAULT TRUE,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`idPhanQuyen`) REFERENCES `tb_phan_quyen`(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (`idNguoiDung`) REFERENCES `tb_nguoi_dung`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `tb_the_loai` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`tenTheLoai` VARCHAR(50),
	`moTa` TEXT,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tb_viTri` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`tenViTri` VARCHAR(50),
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tb_sach` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`idTheLoai` INT,
	`maISBN` VARCHAR(50),
	`idViTri` INT,
	`tieuDe` VARCHAR(255),
	`tacGia` VARCHAR(100),
	`nhaXuatBan` VARCHAR(100),
	`namXuatBan` YEAR,
	`soLuong` INT DEFAULT 1,
	`imageUrl` VARCHAR(255),
	`tinhTrangSach` VARCHAR(50),
	`trangThai` BOOLEAN DEFAULT TRUE,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`idTheLoai`) REFERENCES `tb_the_loai`(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (`idViTri`) REFERENCES `tb_viTri`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `tb_muon_sach` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`idNguoiDung` INT,
	`idSach` JSON,
	`ngayMuon` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`ngayTraDuKien` DATE,
	`ngayTraThucTe` DATE,
	`phiTreHan` DECIMAL(18, 2) DEFAULT 0.0,
	`daThanhToan` DECIMAL(18, 2) DEFAULT 0.0,
	`tongNo` DECIMAL(18, 2) DEFAULT 0.0,
	`trangThai` VARCHAR(50),
	`ghiChu` TEXT,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`idNguoiDung`) REFERENCES `tb_nguoi_dung`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `tb_dat_truoc_sach` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`idNguoiDung` INT,
	`idSach` JSON,
	`ngayDat` DATE,
	`trangThai` BOOLEAN DEFAULT TRUE,
	`ghiChu` TEXT,
	`eventType` VARCHAR(50),
	`updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`idNguoiDung`) REFERENCES `tb_nguoi_dung`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO
	`tb_phan_quyen` (
		`loaiPhanQuyen`,
		`tenPhanQuyen`,
		`ghiChu`,
		`eventType`
	)
VALUES
	(
		'Admin',
		'Quản trị viên',
		'Có quyền truy cập toàn bộ hệ thống và quản lý tất cả các mục.',
		'CREATE'
	),
	(
		'Librarian',
		'Thủ thư',
		'Quản lý sách, hồ sơ mượn/trả sách và các hoạt động liên quan đến thư viện.',
		'CREATE'
	),
	(
		'Reader',
		'Độc giả',
		'Chỉ có quyền tìm kiếm và đặt sách trước, không có quyền quản lý.',
		'CREATE'
	);

INSERT INTO
	`tb_nguoi_dung` (
		`maNguoiDung`,
		`tenNguoiDung`,
		`phone`,
		`ngaySinh`,
		`queQuan`,
		`diaChi`,
		`email`,
		`imageUrl`,
		`ghiChu`,
		`eventType`
	)
VALUES
	(
		'ND001',
		'Nguyen Van A',
		'0912345678',
		'1990-01-15',
		'Ha Noi',
		'123 Pho Hue, Hoan Kiem, Ha Noi',
		'nguyenvana@gmail.com',
		'images/nd001.jpg',
		'Nguoi dung thu A',
		'CREATE'
	),
	(
		'ND002',
		'Tran Thi B',
		'0912345679',
		'1992-02-20',
		'Hai Phong',
		'456 Tran Phu, Ngo Quyen, Hai Phong',
		'tranthib@gmail.com',
		'images/nd002.jpg',
		'Nguoi dung thu B',
		'CREATE'
	),
	(
		'ND003',
		'Le Van C',
		'0912345680',
		'1985-03-25',
		'Da Nang',
		'789 Le Loi, Hai Chau, Da Nang',
		'levanc@gmail.com',
		'images/nd003.jpg',
		'Nguoi dung thu C',
		'CREATE'
	),
	(
		'ND004',
		'Pham Thi D',
		'0912345681',
		'1991-04-18',
		'Ho Chi Minh',
		'123 Vo Thi Sau, Quan 3, Ho Chi Minh',
		'phamthid@gmail.com',
		'images/nd004.jpg',
		'Nguoi dung thu D',
		'CREATE'
	),
	(
		'ND005',
		'Vu Van E',
		'0912345682',
		'1994-05-30',
		'Can Tho',
		'456 Nguyen Trai, Ninh Kieu, Can Tho',
		'vuvane@gmail.com',
		'images/nd005.jpg',
		'Nguoi dung thu E',
		'CREATE'
	),
	(
		'ND006',
		'Do Thi F',
		'0912345683',
		'1988-06-12',
		'Hue',
		'789 Le Duan, Phu Hoi, Hue',
		'dothif@gmail.com',
		'images/nd006.jpg',
		'Nguoi dung thu F',
		'CREATE'
	),
	(
		'ND007',
		'Hoang Van G',
		'0912345684',
		'1989-07-22',
		'Nha Trang',
		'123 Tran Phu, Loc Tho, Nha Trang',
		'hoangvang@gmail.com',
		'images/nd007.jpg',
		'Nguoi dung thu G',
		'CREATE'
	),
	(
		'ND008',
		'Bui Thi H',
		'0912345685',
		'1993-08-05',
		'Vinh',
		'456 Nguyen Van Cu, Quan 9, Vinh',
		'buithih@gmail.com',
		'images/nd008.jpg',
		'Nguoi dung thu H',
		'CREATE'
	),
	(
		'ND009',
		'Ngo Van I',
		'0912345686',
		'1995-09-17',
		'Phu Tho',
		'789 Bach Dang, Hung Vuong, Phu Tho',
		'ngovani@gmail.com',
		'images/nd009.jpg',
		'Nguoi dung thu I',
		'CREATE'
	),
	(
		'ND010',
		'Cao Thi J',
		'0912345687',
		'1990-10-22',
		'Thai Binh',
		'123 Hai Ba Trung, Thai Binh',
		'caothij@gmail.com',
		'images/nd010.jpg',
		'Nguoi dung thu J',
		'CREATE'
	),
	(
		'ND011',
		'Tran Van K',
		'0912345688',
		'1991-11-13',
		'Ha Nam',
		'456 Minh Khai, Ha Nam',
		'tranvank@gmail.com',
		'images/nd011.jpg',
		'Nguoi dung thu K',
		'CREATE'
	),
	(
		'ND012',
		'Pham Thi L',
		'0912345689',
		'1987-12-24',
		'Quang Ninh',
		'789 Phan Dinh Phung, Quang Ninh',
		'phamthil@gmail.com',
		'images/nd012.jpg',
		'Nguoi dung thu L',
		'CREATE'
	),
	(
		'ND013',
		'Dang Van M',
		'0912345690',
		'1992-01-05',
		'Lao Cai',
		'123 Ngo Quyen, Lao Cai',
		'dangvanm@gmail.com',
		'images/nd013.jpg',
		'Nguoi dung thu M',
		'CREATE'
	),
	(
		'ND014',
		'Nguyen Thi N',
		'0912345691',
		'1993-02-16',
		'Lang Son',
		'456 Tran Hung Dao, Lang Son',
		'nguyenthih@gmail.com',
		'images/nd014.jpg',
		'Nguoi dung thu N',
		'CREATE'
	),
	(
		'ND015',
		'Vo Van O',
		'0912345692',
		'1995-03-30',
		'Nghe An',
		'789 Le Thanh Ton, Nghe An',
		'vovano@gmail.com',
		'images/nd015.jpg',
		'Nguoi dung thu O',
		'CREATE'
	),
	(
		'ND016',
		'Huynh Thi P',
		'0912345693',
		'1989-04-18',
		'Quang Tri',
		'123 Bui Thi Xuan, Quang Tri',
		'huynhthip@gmail.com',
		'images/nd016.jpg',
		'Nguoi dung thu P',
		'CREATE'
	),
	(
		'ND017',
		'Le Van Q',
		'0912345694',
		'1994-05-11',
		'Binh Dinh',
		'456 Ly Tu Trong, Binh Dinh',
		'levanq@gmail.com',
		'images/nd017.jpg',
		'Nguoi dung thu Q',
		'CREATE'
	),
	(
		'ND018',
		'Dinh Thi R',
		'0912345695',
		'1990-06-15',
		'Quang Binh',
		'789 Vo Nguyen Giap, Quang Binh',
		'dinhthir@gmail.com',
		'images/nd018.jpg',
		'Nguoi dung thu R',
		'CREATE'
	),
	(
		'ND019',
		'Pham Van S',
		'0912345696',
		'1991-07-20',
		'Bac Ninh',
		'123 Phan Chau Trinh, Bac Ninh',
		'phamvans@gmail.com',
		'images/nd019.jpg',
		'Nguoi dung thu S',
		'CREATE'
	),
	(
		'ND020',
		'Nguyen Thi T',
		'0912345697',
		'1988-08-23',
		'Ha Tinh',
		'456 Hung Vuong, Ha Tinh',
		'nguyenthit@gmail.com',
		'images/nd020.jpg',
		'Nguoi dung thu T',
		'CREATE'
	),
	(
		'ND021',
		'Nguyen Van U',
		'0912345698',
		'1992-09-29',
		'Hoa Binh',
		'789 Dien Bien Phu, Hoa Binh',
		'nguyenvanu@gmail.com',
		'images/nd021.jpg',
		'Nguoi dung thu U',
		'CREATE'
	),
	(
		'ND022',
		'Le Thi V',
		'0912345699',
		'1993-10-04',
		'Thanh Hoa',
		'123 Dong Da, Thanh Hoa',
		'lethiv@gmail.com',
		'images/nd022.jpg',
		'Nguoi dung thu V',
		'CREATE'
	),
	(
		'ND023',
		'Hoang Van W',
		'0912345700',
		'1995-11-18',
		'Quang Ngai',
		'456 Cong Hoa, Quang Ngai',
		'hoangvanw@gmail.com',
		'images/nd023.jpg',
		'Nguoi dung thu W',
		'CREATE'
	),
	(
		'ND024',
		'Bui Thi X',
		'0912345701',
		'1989-12-30',
		'Ben Tre',
		'789 Hai Ba Trung, Ben Tre',
		'buithix@gmail.com',
		'images/nd024.jpg',
		'Nguoi dung thu X',
		'CREATE'
	),
	(
		'ND025',
		'Ngo Van Y',
		'0912345702',
		'1994-01-11',
		'Tay Ninh',
		'123 Quang Trung, Tay Ninh',
		'ngovany@gmail.com',
		'images/nd025.jpg',
		'Nguoi dung thu Y',
		'CREATE'
	),
	(
		'ND026',
		'Vu Thi Z',
		'0912345703',
		'1990-02-25',
		'An Giang',
		'456 Ba Trieu, An Giang',
		'vuthiz@gmail.com',
		'images/nd026.jpg',
		'Nguoi dung thu Z',
		'CREATE'
	),
	(
		'ND027',
		'Tran Van AA',
		'0912345704',
		'1992-03-10',
		'Tien Giang',
		'789 Ly Thuong Kiet, Tien Giang',
		'tranvana@gmail.com',
		'images/nd027.jpg',
		'Nguoi dung thu AA',
		'CREATE'
	),
	(
		'ND028',
		'Le Thi BB',
		'0912345705',
		'1987-04-08',
		'Long An',
		'123 Phan Chu Trinh, Long An',
		'lethibb@gmail.com',
		'images/nd028.jpg',
		'Nguoi dung thu BB',
		'CREATE'
	),
	(
		'ND029',
		'Pham Van CC',
		'0912345706',
		'1993-05-15',
		'Dong Nai',
		'456 Le Hong Phong, Dong Nai',
		'phamvancc@gmail.com',
		'images/nd029.jpg',
		'Nguoi dung thu CC',
		'CREATE'
	),
	(
		'ND030',
		'Nguyen Thi DD',
		'0912345707',
		'1994-06-25',
		'Soc Trang',
		'789 Tran Quoc Toan, Soc Trang',
		'nguyenthidd@gmail.com',
		'images/nd030.jpg',
		'Nguoi dung thu DD',
		'CREATE'
	);

INSERT INTO
	`tb_tai_khoan` (
		`idPhanQuyen`,
		`idNguoiDung`,
		`taiKhoan`,
		`matKhau`,
		`trangThai`,
		`eventType`
	)
VALUES
	(1, 1, 'user001', 'password123', TRUE, 'CREATE'),
	(2, 2, 'user002', 'password123', TRUE, 'CREATE'),
	(3, 3, 'user003', 'password123', TRUE, 'CREATE'),
	(1, 4, 'user004', 'password123', TRUE, 'CREATE'),
	(2, 5, 'user005', 'password123', TRUE, 'CREATE'),
	(3, 6, 'user006', 'password123', TRUE, 'CREATE'),
	(1, 7, 'user007', 'password123', TRUE, 'CREATE'),
	(2, 8, 'user008', 'password123', TRUE, 'CREATE'),
	(3, 9, 'user009', 'password123', TRUE, 'CREATE'),
	(1, 10, 'user010', 'password123', TRUE, 'CREATE'),
	(2, 11, 'user011', 'password123', TRUE, 'CREATE'),
	(3, 12, 'user012', 'password123', TRUE, 'CREATE'),
	(1, 13, 'user013', 'password123', TRUE, 'CREATE'),
	(2, 14, 'user014', 'password123', TRUE, 'CREATE'),
	(3, 15, 'user015', 'password123', TRUE, 'CREATE'),
	(1, 16, 'user016', 'password123', TRUE, 'CREATE'),
	(2, 17, 'user017', 'password123', TRUE, 'CREATE'),
	(3, 18, 'user018', 'password123', TRUE, 'CREATE'),
	(1, 19, 'user019', 'password123', TRUE, 'CREATE'),
	(2, 20, 'user020', 'password123', TRUE, 'CREATE'),
	(3, 21, 'user021', 'password123', TRUE, 'CREATE'),
	(1, 22, 'user022', 'password123', TRUE, 'CREATE'),
	(2, 23, 'user023', 'password123', TRUE, 'CREATE'),
	(3, 24, 'user024', 'password123', TRUE, 'CREATE'),
	(1, 25, 'user025', 'password123', TRUE, 'CREATE'),
	(2, 26, 'user026', 'password123', TRUE, 'CREATE'),
	(3, 27, 'user027', 'password123', TRUE, 'CREATE'),
	(1, 28, 'user028', 'password123', TRUE, 'CREATE'),
	(2, 29, 'user029', 'password123', TRUE, 'CREATE'),
	(3, 30, 'user030', 'password123', TRUE, 'CREATE');

INSERT INTO
	`tb_the_loai` (`tenTheLoai`, `moTa`, `eventType`)
VALUES
	(
		'Văn học Việt Nam',
		'Các tác phẩm văn học nổi tiếng của Việt Nam',
		'CREATE'
	),
	(
		'Văn học nước ngoài',
		'Các tác phẩm văn học nổi tiếng từ các tác giả nước ngoài',
		'CREATE'
	),
	(
		'Khoa học',
		'Sách về các lĩnh vực khoa học như vật lý, hóa học, sinh học',
		'CREATE'
	),
	(
		'Kinh tế',
		'Sách về kinh tế, tài chính và quản trị kinh doanh',
		'CREATE'
	),
	(
		'Tâm lý học',
		'Sách về tâm lý học và các lĩnh vực liên quan',
		'CREATE'
	),
	(
		'Kỹ năng sống',
		'Sách về phát triển kỹ năng sống và kỹ năng mềm',
		'CREATE'
	),
	(
		'Giáo dục',
		'Sách về phương pháp giảng dạy và nghiên cứu giáo dục',
		'CREATE'
	),
	(
		'Công nghệ thông tin',
		'Sách về lập trình, AI, và các công nghệ mới',
		'CREATE'
	),
	(
		'Y học',
		'Sách về các lĩnh vực y học và sức khỏe',
		'CREATE'
	),
	(
		'Lịch sử',
		'Sách về lịch sử Việt Nam và thế giới',
		'CREATE'
	);

INSERT INTO
	`tb_viTri` (`tenViTri`, `eventType`)
VALUES
	('Kệ A1', 'CREATE'),
	('Kệ A2', 'CREATE'),
	('Kệ B1', 'CREATE'),
	('Kệ B2', 'CREATE'),
	('Kệ C1', 'CREATE'),
	('Kệ C2', 'CREATE'),
	('Kệ D1', 'CREATE'),
	('Kệ D2', 'CREATE'),
	('Kệ E1', 'CREATE'),
	('Kệ E2', 'CREATE');

INSERT INTO
	`tb_sach` (
		`idTheLoai`,
		`maISBN`,
		`idViTri`,
		`tieuDe`,
		`tacGia`,
		`nhaXuatBan`,
		`namXuatBan`,
		`soLuong`,
		`imageUrl`,
		`tinhTrangSach`,
		`trangThai`,
		`eventType`
	)
VALUES
	(
		1,
		'9786041123456',
		1,
		'Chí Phèo',
		'Nam Cao',
		'NXB Văn Học',
		2015,
		5,
		'images/chi_pheo.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		2,
		'9786041134567',
		2,
		'Thép Đã Tôi Thế Đấy',
		'Nikolai Ostrovsky',
		'NXB Kim Đồng',
		2018,
		3,
		'images/thep_da_toi.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		3,
		'9786041145678',
		3,
		'Khám Phá Khoa Học',
		'John Doe',
		'NXB Khoa Học',
		2020,
		10,
		'images/kham_pha_khoa_hoc.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		4,
		'9786041156789',
		4,
		'Tư Duy Nhanh Và Chậm',
		'Daniel Kahneman',
		'NXB Trẻ',
		2017,
		7,
		'images/tu_duy_nhanh_va_cham.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		5,
		'9786041167890',
		5,
		'Sức Mạnh Của Thói Quen',
		'Charles Duhigg',
		'NXB Lao Động',
		2019,
		4,
		'images/suc_manh_thoi_quen.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		6,
		'9786041178901',
		6,
		'Kỹ Năng Sống Cho Trẻ',
		'Nguyễn Văn A',
		'NXB Giáo Dục',
		2021,
		6,
		'images/ky_nang_song_cho_tre.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		7,
		'9786041189012',
		7,
		'Phương Pháp Dạy Con Kiểu Nhật',
		'Toshio Suzuki',
		'NXB Trẻ',
		2018,
		2,
		'images/day_con_kieu_nhat.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		8,
		'9786041190123',
		8,
		'Lập Trình Python',
		'Mark Lutz',
		'NXB Công Nghệ',
		2020,
		9,
		'images/lap_trinh_python.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		9,
		'9786041201234',
		9,
		'Giải Phẫu Cơ Thể Người',
		'Nguyễn Văn B',
		'NXB Y Học',
		2016,
		4,
		'images/giai_phau.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		10,
		'9786041212345',
		10,
		'Lịch Sử Việt Nam',
		'Trần Quốc Vượng',
		'NXB Văn Hóa',
		2019,
		3,
		'images/lich_su_vn.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		1,
		'9786041223456',
		1,
		'Lão Hạc',
		'Nam Cao',
		'NXB Văn Học',
		2015,
		5,
		'images/lao_hac.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		2,
		'9786041234567',
		2,
		'Cuộc Sống và Nghệ Thuật',
		'Erich Fromm',
		'NXB Kim Đồng',
		2020,
		2,
		'images/cuoc_song_va_nghe_thuat.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		3,
		'9786041245678',
		3,
		'Bí Ẩn Thiên Nhiên',
		'Richard Dawkins',
		'NXB Khoa Học',
		2018,
		5,
		'images/bi_an_thien_nhien.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		4,
		'9786041256789',
		4,
		'Cách Sống',
		'Inamori Kazuo',
		'NXB Trẻ',
		2017,
		1,
		'images/cach_song.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		5,
		'9786041267890',
		5,
		'Đắc Nhân Tâm',
		'Dale Carnegie',
		'NXB Lao Động',
		2019,
		3,
		'images/dac_nhan_tam.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		6,
		'9786041278901',
		6,
		'Nuôi Con Không Phải Là Cuộc Chiến',
		'Mẹ Ong Bông',
		'NXB Giáo Dục',
		2016,
		8,
		'images/nuoi_con.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		7,
		'9786041289012',
		7,
		'Dạy Con Tài Chính',
		'Neale S. Godfrey',
		'NXB Trẻ',
		2021,
		2,
		'images/day_con_tai_chinh.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		8,
		'9786041290123',
		8,
		'Lập Trình C++',
		'Bjarne Stroustrup',
		'NXB Công Nghệ',
		2020,
		6,
		'images/lap_trinh_cpp.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		9,
		'9786041301234',
		9,
		'Dinh Dưỡng Học Đường',
		'Bùi Thị H',
		'NXB Y Học',
		2017,
		4,
		'images/dinh_duong_hoc_duong.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		10,
		'9786041312345',
		10,
		'Chiến Tranh và Hòa Bình',
		'Lev Tolstoy',
		'NXB Văn Hóa',
		2018,
		3,
		'images/chien_tranh_va_hoa_binh.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		1,
		'9786041323456',
		1,
		'Vợ Nhặt',
		'Kim Lân',
		'NXB Văn Học',
		2016,
		5,
		'images/vo_nhat.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		2,
		'9786041334567',
		2,
		'Mẹ Teresa',
		'Mother Teresa',
		'NXB Kim Đồng',
		2019,
		3,
		'images/me_teresa.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		3,
		'9786041345678',
		3,
		'Bí Mật Vũ Trụ',
		'Stephen Hawking',
		'NXB Khoa Học',
		2018,
		6,
		'images/bi_mat_vu_tru.jpg',
		'Mới',
		TRUE,
		'CREATE'
	),
	(
		4,
		'9786041356789',
		4,
		'Sức Mạnh Tình Yêu',
		'Erich Fromm',
		'NXB Trẻ',
		2017,
		2,
		'images/suc_manh_tinh_yeu.jpg',
		'Tốt',
		TRUE,
		'CREATE'
	),
	(
		5,
		'9786041367890',
		5,
		'Quẳng Gánh Lo Đi',
		'Dale Carnegie',
		'NXB Lao Động',
		2019,
		4,
		'images/quang_ganh_lo_di.jpg',
		'Mới',
		TRUE,
		'CREATE'
	);

INSERT INTO
	`tb_muon_sach` (
		`idNguoiDung`,
		`idSach`,
		`ngayMuon`,
		`ngayTraDuKien`,
		`ngayTraThucTe`,
		`phiTreHan`,
		`daThanhToan`,
		`tongNo`,
		`trangThai`,
		`ghiChu`,
		`eventType`
	)
VALUES
	(
		1,
		'[{"idSach": 1}, {"idSach": 5}]',
		'2024-10-01 09:00:00',
		'2024-10-10',
		'2024-10-08',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		1,
		'[{"idSach": 3}, {"idSach": 8}]',
		'2024-09-15 10:00:00',
		'2024-09-25',
		'2024-09-27',
		5.00,
		5.00,
		0.00,
		'Đã trả',
		'Trả muộn',
		'CREATE'
	),
	(
		1,
		'[{"idSach": 2}, {"idSach": 4}]',
		'2024-10-20 14:30:00',
		'2024-10-30',
		NULL,
		10.00,
		0.00,
		10.00,
		'Chưa trả',
		'Chưa trả sách',
		'CREATE'
	),
	(
		2,
		'[{"idSach": 6}, {"idSach": 7}]',
		'2024-08-05 13:00:00',
		'2024-08-15',
		'2024-08-14',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		2,
		'[{"idSach": 9}]',
		'2024-08-20 15:20:00',
		'2024-08-30',
		'2024-08-29',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		2,
		'[{"idSach": 10}, {"idSach": 12}]',
		'2024-09-10 08:00:00',
		'2024-09-20',
		'2024-09-22',
		5.00,
		5.00,
		0.00,
		'Đã trả',
		'Trả muộn',
		'CREATE'
	),
	(
		3,
		'[{"idSach": 13}, {"idSach": 15}]',
		'2024-07-15 10:00:00',
		'2024-07-25',
		'2024-07-26',
		5.00,
		5.00,
		0.00,
		'Đã trả',
		'Trả muộn',
		'CREATE'
	),
	(
		3,
		'[{"idSach": 11}]',
		'2024-07-30 09:15:00',
		'2024-08-09',
		'2024-08-08',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		3,
		'[{"idSach": 17}, {"idSach": 18}]',
		'2024-09-01 14:45:00',
		'2024-09-11',
		NULL,
		15.00,
		0.00,
		15.00,
		'Chưa trả',
		'Chưa trả sách',
		'CREATE'
	),
	(
		4,
		'[{"idSach": 19}, {"idSach": 20}]',
		'2024-08-01 09:45:00',
		'2024-08-11',
		'2024-08-12',
		5.00,
		5.00,
		0.00,
		'Đã trả',
		'Trả muộn',
		'CREATE'
	),
	(
		4,
		'[{"idSach": 14}]',
		'2024-08-10 11:30:00',
		'2024-08-20',
		'2024-08-18',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		4,
		'[{"idSach": 21}, {"idSach": 22}]',
		'2024-09-12 10:30:00',
		'2024-09-22',
		NULL,
		10.00,
		0.00,
		10.00,
		'Chưa trả',
		'Chưa trả sách',
		'CREATE'
	),
	(
		5,
		'[{"idSach": 23}, {"idSach": 24}]',
		'2024-09-01 16:10:00',
		'2024-09-11',
		'2024-09-10',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		5,
		'[{"idSach": 25}]',
		'2024-08-15 12:00:00',
		'2024-08-25',
		'2024-08-24',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	),
	(
		5,
		'[{"idSach": 1}, {"idSach": 3}]',
		'2024-07-20 13:45:00',
		'2024-07-30',
		'2024-07-29',
		0.00,
		0.00,
		0.00,
		'Đã trả',
		'Trả đúng hạn',
		'CREATE'
	);