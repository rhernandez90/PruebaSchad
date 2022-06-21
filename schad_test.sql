USE [master]
GO
/****** Object:  Database [Test_Invoice]    Script Date: 6/21/2022 12:10:11 PM ******/
CREATE DATABASE [Test_Invoice]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Test_Invoice', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test_Invoice.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Test_Invoice_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test_Invoice_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Test_Invoice] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Test_Invoice].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Test_Invoice] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Test_Invoice] SET ARITHABORT OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Test_Invoice] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Test_Invoice] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Test_Invoice] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Test_Invoice] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Test_Invoice] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Test_Invoice] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Test_Invoice] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Test_Invoice] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Test_Invoice] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Test_Invoice] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Test_Invoice] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Test_Invoice] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Test_Invoice] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Test_Invoice] SET RECOVERY FULL 
GO
ALTER DATABASE [Test_Invoice] SET  MULTI_USER 
GO
ALTER DATABASE [Test_Invoice] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Test_Invoice] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Test_Invoice] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Test_Invoice] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Test_Invoice] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Test_Invoice', N'ON'
GO
ALTER DATABASE [Test_Invoice] SET QUERY_STORE = OFF
GO
USE [Test_Invoice]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 6/21/2022 12:10:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustName] [nvarchar](70) NOT NULL,
	[Adress] [nvarchar](120) NOT NULL,
	[Status] [bit] NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerTypes]    Script Date: 6/21/2022 12:10:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_CustomerType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 6/21/2022 12:10:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TotalItbis] [money] NOT NULL,
	[SubTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetail]    Script Date: 6/21/2022 12:10:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[TotalItbis] [money] NULL,
	[SubTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_InvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (1, N'ATECHS', N'SPS, HND', 1, 1)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (2, N'Arturo', N'SPS', 1, 1)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (3, N'SCHAD', N'RD', 1, 2)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerTypes] ON 

INSERT [dbo].[CustomerTypes] ([Id], [Description]) VALUES (1, N'Minoritario')
INSERT [dbo].[CustomerTypes] ([Id], [Description]) VALUES (2, N'Mayoritario')
INSERT [dbo].[CustomerTypes] ([Id], [Description]) VALUES (8, N'xxxxxx')
SET IDENTITY_INSERT [dbo].[CustomerTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (2, 1, 0.0000, 0.0000, 1937.0000)
INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (3, 1, 0.0000, 0.0000, 4800.0000)
INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (4, 3, 0.0000, 0.0000, 7200.0000)
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO
SET IDENTITY_INSERT [dbo].[InvoiceDetail] ON 

INSERT [dbo].[InvoiceDetail] ([Id], [CustomerId], [Qty], [Price], [TotalItbis], [SubTotal], [Total], [InvoiceId], [Description]) VALUES (3, 0, 12, 65.0000, NULL, 0.0000, 780.0000, 2, N'xxxxx')
INSERT [dbo].[InvoiceDetail] ([Id], [CustomerId], [Qty], [Price], [TotalItbis], [SubTotal], [Total], [InvoiceId], [Description]) VALUES (4, 0, 13, 89.0000, NULL, 0.0000, 1157.0000, 2, N'xxxx 2.1')
INSERT [dbo].[InvoiceDetail] ([Id], [CustomerId], [Qty], [Price], [TotalItbis], [SubTotal], [Total], [InvoiceId], [Description]) VALUES (5, 0, 3, 1600.0000, NULL, 0.0000, 4800.0000, 3, N'Servicio de aduana ')
INSERT [dbo].[InvoiceDetail] ([Id], [CustomerId], [Qty], [Price], [TotalItbis], [SubTotal], [Total], [InvoiceId], [Description]) VALUES (6, 0, 2, 3600.0000, NULL, 0.0000, 7200.0000, 4, N'Servicio de aduanaje y bodega')
SET IDENTITY_INSERT [dbo].[InvoiceDetail] OFF
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_CustomerType]  DEFAULT ((1)) FOR [CustomerTypeId]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TotalItbis]  DEFAULT ((0)) FOR [TotalItbis]
GO
ALTER TABLE [dbo].[InvoiceDetail] ADD  CONSTRAINT [DF_InvoiceDetail_TotalItbis1]  DEFAULT ((0)) FOR [Qty]
GO
ALTER TABLE [dbo].[InvoiceDetail] ADD  CONSTRAINT [DF_InvoiceDetail_TotalItbis]  DEFAULT ((0)) FOR [TotalItbis]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerTypes] FOREIGN KEY([CustomerTypeId])
REFERENCES [dbo].[CustomerTypes] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_CustomerTypes]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customers]
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetail_InvoiceDetail] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoice] ([Id])
GO
ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_InvoiceDetail]
GO
USE [master]
GO
ALTER DATABASE [Test_Invoice] SET  READ_WRITE 
GO
