﻿USE QuanLyQuanCaFe
GO

--FOOD
--TABLE(BAN AN)
--FOODCATEGORY(DANH MUC)
--ACCOUNT
--BILL
--BILLINFOR(CHI TIET HOA DON)
-----------------------------------------------------
--TABLE(BAN AN)
CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name  NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'TRỐNG', --TRONG HOAC DA CO NGUOI
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'ADMINTRATOR',
	PassWord NVARCHAR(100) NOT NULL DEFAULT 0,
	TYPE INT NOT NULL DEFAULT 0 --1 la admin hay 0 LA NHAN VIEN
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name  NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name  NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES  dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 --1:DA THANH TOAN,0:CHUA THANH TOAN

	FOREIGN KEY (idTable) REFERENCES  dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES  dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES  dbo.Food(id)
)
GO
-------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Account
(
	UserName,
	DisplayName,
	PassWord,
	TYPE
)
VALUES (
	N'ADMIN',  --USERNAME-NVARCHAR(100)
	N'ADMIN', --DISPLAYNAME-NVARCHAR(100)
	N'1',	--PASSWWORLD-NVARCHAR(100)
	1	--TYPE INT
)

INSERT INTO dbo.Account
(
	UserName,
	DisplayName,
	PassWord,
	TYPE
)
VALUES (
	N'STAFF',  --USERNAME-NVARCHAR(100)
	N'STAFF', --DISPLAYNAME-NVARCHAR(100)
	N'0',	--PASSWWORLD-NVARCHAR(100)
	0	--TYPE INT
)
GO 
-------------------USER LOGIN----------------
CREATE PROC USP_GetAccountByUserName @userName nvarchar(100)
AS
BEGIN
	SELECT * FROM DBO.Account WHERE UserName=@userName
END
GO
EXEC USP_GetAccountByUserName N'admin'

SELECT * FROM DBO.Account WHERE UserName = N'ADMIN' AND PassWord =N'1'

CREATE PROC USP_Login @userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName=@userName AND PassWord=@passWord
END
GO

----------------TABLE FOOD---------------------------------------------------------------------------------
DECLARE @i INT =0
WHILE @i<10
BEGIN
	INSERT dbo.TableFood (name) VALUES (N'Bàn '+ CAST(@i AS NVARCHAR(100)))--CAST LÀ ÉP KIỂU TỪ INT VỀ STRING
	SET @i =@i+1
END

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE DBO.TableFood SET status = N'Có người' WHERE id=9
EXEC dbo.USP_GetTableList