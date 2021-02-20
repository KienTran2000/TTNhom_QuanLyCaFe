USE QuanLyQuanCaFe
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
--Thêm bàn--
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
--Thêm Category--
INSERT DBO.FoodCategory
		(name)
VALUES	(N'Hải sản')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Nông sản')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Lâm sản')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Quý hiếm')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Nước')
--Thêm món ăn--
INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Mực một nắng nướng sa tế',1,120000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Nghêu hấp xả',1,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Lầm dê nướng sữa',2,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Mực một nắng nướng sa tế',3,75000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Cơm chiên mushi',4,99000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Seven Up',5,12000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Cafe Nâu Đá',5,12000)

--thêm bill--
INSERT dbo.Bill (DateCheckIn,DateCheckOut,idTable,status)
VALUES (GETDATE(),NULL,1,0)

INSERT dbo.Bill (DateCheckIn,DateCheckOut,idTable,status)
VALUES (GETDATE(),NULL,2,0)

INSERT dbo.Bill (DateCheckIn,DateCheckOut,idTable,status)
VALUES (GETDATE(),GETDATE(),3,1)
SELECT * FROM DBO.TableFood
--THÊM BILL INFOR---
INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (1,1,2)

INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (1,3,4)

INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (1,5,1)

INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (2,1,2)

INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (2,6,2)

INSERT dbo.BillInfo(idBill,idFood,count)
VALUES (3,5,2)
GO

SELECT * FROM DBO.Bill WHERE idTable =3 AND status = 1 ;

SELECT f.name,bi.count,f.price,f.price*bi.count AS totalPrice
FROM BillInfo AS bi,Bill AS b,Food AS f
WHERE bi.idBill=b.id AND bi.idFood=f.id AND b.idTable=3

SELECT * FROM DBO.Bill
SELECT * FROM DBO.BillInfo
SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory



