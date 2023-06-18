USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 18.06.2023 9:36:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers](
	[����������] [int] NOT NULL,
	[���] [nvarchar](50) NOT NULL,
	[�������] [nvarchar](50) NOT NULL,
	[���] [nchar](1) NOT NULL,
	[�����] [nvarchar](50) NOT NULL,
	[���] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Customers_1] PRIMARY KEY CLUSTERED 
(
	[����������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---------------------------------------

USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[OrderDetails]    Script Date: 18.06.2023 9:36:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderDetails](
	[id] [int] NOT NULL,
	[�����] [nvarchar](50) NOT NULL,
	[����������] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_id] FOREIGN KEY([id])
REFERENCES [dbo].[Orders] ([id])
GO

ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_id]
GO

ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_�����] FOREIGN KEY([�����])
REFERENCES [dbo].[Products] ([�����])
GO

ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_�����]
GO




---------------------------------------


USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 18.06.2023 9:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[id] [int] NOT NULL,
	[����������] [int] NOT NULL,
	[����] [date] NOT NULL,
	[�����] [money] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [PK_����������] FOREIGN KEY([����������])
REFERENCES [dbo].[Customers] ([����������])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [PK_����������]
GO





---------------------------------------


USE [Stylish-Fashionable-Youth]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 18.06.2023 9:36:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[�����] [nvarchar](50) NOT NULL,
	[����] [money] NOT NULL,
	[��.] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[�����] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


