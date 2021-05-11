USE [master]
GO
/****** Object:  Database [QuanLyQuanCaFe]    Script Date: 5/11/2021 10:07:10 AM ******/
CREATE DATABASE [QuanLyQuanCaFe1]
GO
USE [QuanLyQuanCaFe1]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](100) NOT NULL,
	[TYPE] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 5/11/2021 10:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [TYPE]) VALUES (N'ADMIN', N'ADMIN123', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [TYPE]) VALUES (N'ADMIN1', N'ADMIN312', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [TYPE]) VALUES (N'STAFF', N'STAFF', N'1962026656160185351301320480154111117132155', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2021-04-16' AS Date), CAST(N'2021-04-16' AS Date), 4, 1, 0, 132000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (51, CAST(N'2021-04-19' AS Date), CAST(N'2021-04-19' AS Date), 4, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (52, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 2, 1, 0, 480000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 3, 1, 0, 580000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 4, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 8, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 7, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 6, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 5, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 1, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 10, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 9, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 1, 1, 0, 124000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 2, 1, 0, 24000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 3, 1, 0, 24000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 7, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 8, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 5, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 6, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (69, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 10, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (70, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 9, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (71, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 4, 1, 0, 12000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (72, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 10, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (73, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 9, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (74, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 5, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (75, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 6, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (76, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 7, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (77, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 8, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (78, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 4, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (79, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 2, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (80, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 3, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (81, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-20' AS Date), 1, 1, 0, 240000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (82, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-27' AS Date), 6, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (83, CAST(N'2021-04-20' AS Date), CAST(N'2021-04-27' AS Date), 7, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1062, CAST(N'2021-04-27' AS Date), CAST(N'2021-04-28' AS Date), 7, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1063, CAST(N'2021-04-28' AS Date), CAST(N'2021-04-29' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1064, CAST(N'2021-04-28' AS Date), CAST(N'2021-04-29' AS Date), 8, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1065, CAST(N'2021-04-28' AS Date), CAST(N'2021-05-10' AS Date), 2, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1066, CAST(N'2021-04-28' AS Date), NULL, 7, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1067, CAST(N'2021-04-29' AS Date), CAST(N'2021-04-29' AS Date), 3, 1, 0, 360000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1068, CAST(N'2021-05-10' AS Date), CAST(N'2021-05-10' AS Date), 4, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1069, CAST(N'2021-05-10' AS Date), CAST(N'2021-05-10' AS Date), 4, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1070, CAST(N'2021-05-10' AS Date), CAST(N'2021-05-10' AS Date), 12, 1, 0, 100000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (53, 50, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (57, 53, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (58, 54, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (59, 55, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (60, 56, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (61, 57, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (62, 58, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (63, 59, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (64, 60, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (65, 61, 16, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (66, 62, 15, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (67, 62, 24, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (68, 63, 24, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (69, 64, 23, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (70, 64, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (71, 65, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (72, 66, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (73, 67, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (74, 68, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (75, 69, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (76, 70, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (77, 71, 22, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1066, 1062, 26, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1070, 1068, 15, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1071, 1069, 15, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1072, 1065, 15, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1073, 1070, 15, 2)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Trà chanh đặc biệt', 6, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Trà quất nha đam', 6, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Nâu Đá', 7, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Bạc xỉu', 7, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Cafe Sữa', 7, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Sinh tố Bơ', 8, 75000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Sinh tố xoài', 8, 99000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (22, N'Gà khô lá chanh', 9, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (23, N'Heo khô cháy tỏi', 9, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (24, N'7 Seven', 10, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (25, N'Bò Húc', 10, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'Trà Mít', 15, 120000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Tràbb')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Cafe')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'Sinh Tố')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (9, N'Đồ ăn nhẹ')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (10, N'Nước')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (15, N'Tràabc')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 0d', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 9aa', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'ADMINTRATOR') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [TYPE]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'TRỐNG') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName] @userName nvarchar(100)
AS
BEGIN
	SELECT * FROM DBO.Account WHERE UserName=@userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate] @checkIn date,@checkOut date 
as
begin
select t.name as [Tên bàn],b.totalPrice as [Tổng tiền],DateCheckIn as [Ngày vào],DateCheckOut as [Ngày ra],discount as [Giảm giá]
from dbo.Bill as b,dbo.TableFood as t
where DateCheckIn >=@checkIn and DateCheckOut<=@checkOut and b.status=1
and t.id=b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDateAndPage] @checkIn date,@checkOut date ,@page int
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
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetNumBillByDate] @checkIn date,@checkOut date 
as
begin
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBill]
@idTable int
as
begin
insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status,discount)
values(GETDATE(),null,@idTable,0,0)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_insertBillInfo]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_insertBillInfo]
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
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login] @userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName=@userName AND PassWord=@passWord
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTabel]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_SwitchTabel] @idTable1 int,@idTable2 int
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
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 5/11/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateAccount] @userName nvarchar(100),@displayName nvarchar(100),@password nvarchar(100),@newPassword nvarchar(100)
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
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCaFe] SET  READ_WRITE 
GO
