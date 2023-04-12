create database QLPhongBan
go

use QLPhongBan
go

CREATE TABLE PhongBan (
  MaPHG int PRIMARY KEY Identity,
  TenPHG nvarchar(50) UNIQUE
);

INSERT INTO PhongBan (TenPHG)
VALUES (N'Phòng kế toán'),
       (N'Phòng kinh doanh'),
       (N'Phòng nhân sự'),
       (N'Phòng marketing'),
       (N'Phòng sản xuất');

CREATE TABLE NhanVien (
  MaNV int PRIMARY KEY Identity,
  HoTen nvarchar(50),
  Phai nvarchar(3),
  NgaySinh datetime,
  DiaChi nvarchar(100),
  Luong float,
  MaPHG int,
  TrangThai bit
);

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_PhongBan FOREIGN KEY (MaPHG)
REFERENCES PhongBan(MaPHG);

INSERT INTO NhanVien (HoTen, Phai, NgaySinh, DiaChi, Luong, MaPHG, TrangThai)
VALUES 
  ('Nam A', N'Nam', '1995-01-01', '123 Nguyen Hue, Quan 1, TP. HCM', 10000000, 1, 1),
  ('Nu B', N'Nữ', '2000-02-02', '20 Tran Phu, Quan 2, TP. HCM', 8000000, 1, 1),
  ('Nam C', N'Nam', '1998-03-03', '50 Ngoc Lam, Quan 3, TP. HCM', 12000000, 2, 1),
  ('Nu D', N'Nữ', '1997-04-04', '8 Vo Van Ngan, Quan 4, TP. HCM', 11000000, 2, 1),
  ('Nu E', N'Nữ', '1996-05-05', '10 Nguyen Thi Minh Khai, Quan 5, TP. HCM', 9500000, 1, 0);

create proc sp_deletePhongBan @maPB int
as
begin
	if exists (select * from NhanVien where MaPHG = @maPB)
	begin
		update NhanVien set MaPHG = null where MaPHG = @maPB
	end
	delete PhongBan where MaPHG = @maPB
end

--exec dbo.sp_deletePhongBan @maPB=1

--select nv.MaNV, nv.HoTen, nv.Phai, nv.NgaySinh, nv.DiaChi, nv.Luong, pb.TenPHG, nv.TrangThai from NhanVien nv, PhongBan pb where pb.MaPHG = nv.MaPHG