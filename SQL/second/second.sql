USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 17.06.2023 19:56:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers](
	[Покупатель] [int] NOT NULL,
	[Имя] [nvarchar](50) NOT NULL,
	[Фамилия] [nvarchar](50) NOT NULL,
	[Пол] [nchar](1) NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[Дом] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Customers_1] PRIMARY KEY CLUSTERED 
(
	[Покупатель] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---------------------------------------

USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[OrderDetails]    Script Date: 17.06.2023 19:56:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderDetails](
	[id] [int] NOT NULL,
	[Товар] [nvarchar](50) NOT NULL,
	[Количество] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_id] FOREIGN KEY([id])
REFERENCES [dbo].[Orders] ([id])
GO

ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_id]
GO

ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_Товар] FOREIGN KEY([Товар])
REFERENCES [dbo].[Products] ([Товар])
GO

ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_Товар]
GO




---------------------------------------


USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 17.06.2023 19:56:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[id] [int] NOT NULL,
	[Покупатель] [int] NOT NULL,
	[Дата] [date] NOT NULL,
	[Всего] [money] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [PK_Покупатель] FOREIGN KEY([Покупатель])
REFERENCES [dbo].[Customers] ([Покупатель])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [PK_Покупатель]
GO





---------------------------------------


USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 17.06.2023 19:56:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[Товар] [nvarchar](50) NOT NULL,
	[Цена] [money] NOT NULL,
	[Ед.] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Товар] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


