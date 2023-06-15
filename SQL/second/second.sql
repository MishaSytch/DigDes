USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Address]    Script Date: 15.06.2023 15:08:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Address](
	[Адрес] [int] NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[Дом] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Адрес] PRIMARY KEY CLUSTERED 
(
	[Адрес] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[OrderHistory]    Script Date: 15.06.2023 15:08:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderHistory](
	[id] [int] NOT NULL,
	[Покупатель] [nvarchar](50) NOT NULL,
	[Дата] [date] NOT NULL,
	[Товар] [nvarchar](50) NOT NULL,
	[Количество] [int] NOT NULL,
 CONSTRAINT [PK_OrderHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[PlaceOfResidence]    Script Date: 15.06.2023 15:08:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PlaceOfResidence](
	[Полкупатель] [nvarchar](50) NOT NULL,
	[Адрес] [int] NOT NULL,
 CONSTRAINT [PK_Место жительства] PRIMARY KEY CLUSTERED 
(
	[Полкупатель] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Sex]    Script Date: 15.06.2023 15:09:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sex](
	[Покупатель] [nvarchar](50) NOT NULL,
	[Пол] [nchar](2) NULL,
 CONSTRAINT [PK_Пол] PRIMARY KEY CLUSTERED 
(
	[Покупатель] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[TotalInADay]    Script Date: 15.06.2023 15:09:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TotalInADay](
	[id] [int] NOT NULL,
	[Покупатель] [nvarchar](50) NOT NULL,
	[Дата] [date] NOT NULL,
	[Всего] [money] NOT NULL,
 CONSTRAINT [PK_Total in a day] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[UnitPrice]    Script Date: 15.06.2023 15:09:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UnitPrice](
	[Товар] [nvarchar](50) NOT NULL,
	[Цена] [money] NOT NULL,
 CONSTRAINT [PK_Цена за единицу товара] PRIMARY KEY CLUSTERED 
(
	[Товар] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


------------------------------------------------------------
USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[UnitsOfMeasurement]    Script Date: 15.06.2023 15:09:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UnitsOfMeasurement](
	[Товар] [nvarchar](50) NOT NULL,
	[ед.] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Единицы измерения] PRIMARY KEY CLUSTERED 
(
	[Товар] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

