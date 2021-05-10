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

ALTER TABLE dbo.Bill
ADD discount int

update dbo.Bill set discount=0

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
--=================================================================INSERT DATA====================================================================-------

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
-------------------------------------------------------------------------------------------------
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
--UPDATE trạng thái bàn
UPDATE DBO.TableFood SET status = N'Có người' WHERE id=9
EXEC dbo.USP_GetTableList

--Thêm Category(Loại)--
INSERT DBO.FoodCategory
		(name)
VALUES	(N'Trà')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Cafe')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Sinh Tố')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Đồ ăn nhẹ')

INSERT DBO.FoodCategory
		(name)
VALUES	(N'Nước')
--Thêm món ăn--
INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Trà Đào Cam Sả',6,120000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Trà chanh đặc biệt',6,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Trà quất nha đam',6,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Nâu Đá',7,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Bạc xỉu',7,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Cafe Sữa',7,50000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Sinh tố Bơ',8,75000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Sinh tố xoài',8,99000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Gà khô lá chanh',9,12000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Heo khô cháy tỏi',9,12000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'7 UP',10,12000)

INSERT DBO.Food(name,idCategory,price)
VALUES	(N'Bò Húc',10,12000)

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
--DELETE
delete from BillInfo
delete from Bill

SELECT * FROM DBO.Bill WHERE idTable =3 AND status = 1 ;

SELECT f.name,bi.count,f.price,f.price*bi.count AS totalPrice
FROM BillInfo AS bi,Bill AS b,Food AS f
WHERE bi.idBill=b.id AND bi.idFood=f.id AND b.idTable=3

SELECT * FROM DBO.Bill
SELECT * FROM DBO.BillInfo
SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory

--Insert BILL
create proc USP_InsertBill
@idTable int
as
begin
insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status,discount)
values(GETDATE(),null,@idTable,0,0)
end
drop proc USP_InsertBill
--insert BillInfor
create proc USP_insertBillInfo
@idBill int,@idFood int,@count int
as
begin
	declare @isExitsBillInfo int
	declare @foodCount int=1

	select @isExitsBillInfo =id,@foodCount=b.count
	from dbo.BillInfo as b
	where idBill=@idBill and idFood=@idFood

	if(@isExitsBillInfo>0)
	begin
		declare @newcount int=@foodCount+@count
		if(@newcount>0)
			update dbo.BillInfo set count =@foodCount+@count where idFood=@idFood
		else
			delete dbo.BillInfo where idBill=@idBill and idFood=@idFood
	end
	else
		begin
			insert dbo.BillInfo(idBill,idFood,count)
			values(@idBill,@idFood,@count)
		end
end
drop proc USP_insertBillInfo

--SELECT MAX ID
select Max(id) from dbo.Bill

--Thay đổi trạng thái BillInfor
CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = idBill FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0
	
	UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable
END
GO

--Update Bill
CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = id FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO
Drop trigger UTG_UpdateBill
update dbo.Bill set status = 1 where id= 1

select * from dbo.Bill

create proc USP_SwitchTabel @idTable1 int,@idTable2 int
as
begin
	declare @idFirstBill int
	declare @idSecordBill int

	declare @isFirstTableEmty int = 1
	declare @isSecondTableEmty int = 1

	select @idSecordBill=id from dbo.Bill where idTable=@idTable2 and status=0
	select @idFirstBill=id from dbo.Bill where idTable=@idTable1 and status=0

	if(@idFirstBill is Null) 
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status)
		values(GETDATE(),null,@idTable1,0)
		select @idFirstBill=MAX(id) from dbo.Bill where idTable=@idTable1 and status=0
		
	end
		select @isFirstTableEmty=count(*) from BillInfo where idBill=@idFirstBill

	if(@idSecordBill is Null)
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status)
		values(GETDATE(),null,@idTable2,0)
		select @idFirstBill=MAX(id) from dbo.Bill where idTable=@idTable2 and status=0
		
	end

		select @isSecondTableEmty=count(*) from BillInfo where idBill=@idSecordBill

	select id into IDBillInfoTable from dbo.BillInfo where idBill=@idSecordBill
	update dbo.BillInfo set idBill =@idSecordBill where idBill=@idFirstBill
	update dbo.BillInfo set idBill=@idFirstBill where id in(select* from IDBillInfoTable)

	drop table IDBillInfoTable

	if(@isFirstTableEmty=0)
		update dbo.TableFood set status = N'Trống' where id =@idTable2
	if(@isSecondTableEmty=0)
		update dbo.TableFood set status = N'Trống' where id =@idTable1
end
go

drop proc USP_SwitchTabel

update TableFood set status=N'Trống'

delete dbo.BillInfo
delete dbo.Bill


--Thong ke danh sach doanh thu trong phan Admin
create proc USP_GetListBillByDate @checkIn date,@checkOut date 
as
begin
select t.name as [Tên bàn],b.totalPrice as [Tổng tiền],DateCheckIn as [Ngày vào],DateCheckOut as [Ngày ra],discount as [Giảm giá]
from dbo.Bill as b,dbo.TableFood as t
where DateCheckIn >=@checkIn and DateCheckOut<=@checkOut and b.status=1
and t.id=b.idTable
end
go

--Cập nhật lại tài khoản
create proc USP_UpdateAccount @userName nvarchar(100),@displayName nvarchar(100),@password nvarchar(100),@newPassword nvarchar(100)
as
begin
	declare @isRightPass int=0
	select @isRightPass = count(*) from dbo.Account where UserName =@userName and PassWord=@password
	if(@isRightPass=1)
	begin
		if(@newPassword=null or @newPassword='')
			begin
				update dbo.Account set DisplayName =@displayName where UserName=@userName
			end
		else
				update dbo.Account set DisplayName =@displayName,PassWord=@newPassword where UserName=@userName
	end
end
go

--Xóa Bill Info
create trigger UTG_DeleteBillInfo on dbo.BillInfo for delete
as
begin
	declare @idBillInfo int
	declare @idBill int
	select @idBillInfo = id, @idBill = deleted.idBill from deleted

	declare @idTable int
	select @idTable=idTable from dbo.Bill where id=@idBill

	declare @count int =0
	select @count=count(*) from dbo.BillInfo as bi, dbo.Bill as b where b.id =bi.idBill and b.id =@idBill and b.status=0

	if(@count = 0)
		update dbo.TableFood set status = N'Trống' where id=@idTable
end
go
--Ham tim kiem 
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000)
AS
BEGIN 
	IF @strInput IS NULL RETURN @strInput 
	IF @strInput = '' RETURN @strInput 
	DECLARE @RT NVARCHAR(4000) 
	DECLARE @SIGN_CHARS NCHAR(136) 
	DECLARE @UNSIGN_CHARS NCHAR (136) 
	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
	DECLARE @COUNTER int 
	DECLARE @COUNTER1 int 
	SET @COUNTER = 1 
	WHILE (@COUNTER <=LEN(@strInput)) 
	BEGIN 
		SET @COUNTER1 = 1 
			WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
				BEGIN 
					IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
						BEGIN 
							IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)
							ELSE 
								SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK 
						END
						SET @COUNTER1 = @COUNTER1 +1 END 
						SET @COUNTER = @COUNTER +1 END 
						SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
go

create proc USP_GetListBillByDateAndPage @checkIn date,@checkOut date ,@page int
as
begin
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)

end
go
drop proc USP_GetListBillByDateAndPage



create proc USP_GetNumBillByDate @checkIn date,@checkOut date 
as
begin
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
end
go

drop proc USP_GetNumBillByDate

