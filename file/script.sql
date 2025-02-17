USE [master]
GO
/****** Object:  Database [KLTN]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE DATABASE [KLTN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KLTN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\KLTN.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KLTN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\KLTN_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [KLTN] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KLTN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KLTN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KLTN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KLTN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KLTN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KLTN] SET ARITHABORT OFF 
GO
ALTER DATABASE [KLTN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KLTN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KLTN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KLTN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KLTN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KLTN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KLTN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KLTN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KLTN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KLTN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KLTN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KLTN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KLTN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KLTN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KLTN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KLTN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KLTN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KLTN] SET RECOVERY FULL 
GO
ALTER DATABASE [KLTN] SET  MULTI_USER 
GO
ALTER DATABASE [KLTN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KLTN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KLTN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KLTN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KLTN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KLTN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'KLTN', N'ON'
GO
ALTER DATABASE [KLTN] SET QUERY_STORE = ON
GO
ALTER DATABASE [KLTN] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [KLTN]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbAddress]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbAddress](
	[IdAddress] [int] IDENTITY(1,1) NOT NULL,
	[IdKh] [int] NOT NULL,
	[TenNguoiNhan] [nvarchar](25) NOT NULL,
	[Sdt] [nvarchar](15) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[City] [nvarchar](25) NOT NULL,
	[QuanHuyen] [nvarchar](25) NOT NULL,
	[PhuongXa] [nvarchar](25) NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
	[Idefault] [bit] NOT NULL,
 CONSTRAINT [PK_DbAddress] PRIMARY KEY CLUSTERED 
(
	[IdAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbAdmin]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbAdmin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaAdmin] [nvarchar](5) NOT NULL,
	[EmailDn] [nvarchar](15) NOT NULL,
	[NameDn] [nvarchar](25) NULL,
	[PasswordDn] [nvarchar](10) NOT NULL,
	[ChucVu] [nvarchar](10) NOT NULL,
	[Quyen] [nvarchar](10) NULL,
	[IsExternalAccount] [bit] NOT NULL,
 CONSTRAINT [PK_DbAdmin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbAds]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbAds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaAds] [nvarchar](10) NOT NULL,
	[Img] [nvarchar](250) NULL,
	[Place] [nvarchar](10) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_DbAds] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbCart]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbCart](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSp] [int] NOT NULL,
	[IdKh] [int] NOT NULL,
	[ProductQuantity] [int] NOT NULL,
	[ColorId] [int] NOT NULL,
	[SizeId] [int] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbCart] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbCategory]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbCategory](
	[IdDm] [int] IDENTITY(1,1) NOT NULL,
	[MaDm] [nvarchar](10) NULL,
	[TenDm] [nvarchar](10) NOT NULL,
	[AnhDaiDien] [nvarchar](250) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbCategory] PRIMARY KEY CLUSTERED 
(
	[IdDm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbColor]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbColor](
	[ColorId] [int] IDENTITY(1,1) NOT NULL,
	[MaColor] [nvarchar](10) NULL,
	[NameColor] [nvarchar](50) NOT NULL,
	[Img] [nvarchar](250) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
	[MaHex] [nvarchar](20) NULL,
 CONSTRAINT [PK_DbColor] PRIMARY KEY CLUSTERED 
(
	[ColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbCustomer]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbCustomer](
	[IdKh] [int] IDENTITY(1,1) NOT NULL,
	[MaKh] [nvarchar](20) NULL,
	[TenKh] [nvarchar](25) NOT NULL,
	[Img] [nvarchar](250) NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[Sdt] [nvarchar](15) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Passwords] [nvarchar](25) NULL,
	[ConfirmPasswords] [nvarchar](25) NULL,
	[IsExternalAccount] [bit] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
	[Birth] [datetime2](7) NULL,
 CONSTRAINT [PK_DbCustomer] PRIMARY KEY CLUSTERED 
(
	[IdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbFavoriteProduct]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbFavoriteProduct](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdSp] [int] NOT NULL,
	[IdKh] [int] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbFavoriteProduct] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbGroup]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbGroup](
	[IdNhom] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [nvarchar](10) NOT NULL,
	[GroupName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_DbGroup] PRIMARY KEY CLUSTERED 
(
	[IdNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbImg]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbImg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSp] [int] NOT NULL,
	[Img] [nvarchar](250) NULL,
	[Place] [nvarchar](10) NULL,
 CONSTRAINT [PK_DbImg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbInforShop]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbInforShop](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sdt] [nvarchar](15) NULL,
	[Email] [nvarchar](25) NULL,
	[Addres] [nvarchar](250) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbInforShop] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbOrder]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbOrder](
	[IdDh] [int] IDENTITY(1,1) NOT NULL,
	[MaDh] [nvarchar](500) NULL,
	[IdKh] [int] NOT NULL,
	[NguoiNhan] [nvarchar](30) NOT NULL,
	[EmailKh] [nvarchar](25) NOT NULL,
	[Sdt] [nvarchar](15) NOT NULL,
	[City] [nvarchar](10) NOT NULL,
	[District] [nvarchar](10) NOT NULL,
	[Ward] [nvarchar](10) NOT NULL,
	[DiaChi] [nvarchar](500) NOT NULL,
	[TongTien] [decimal](18, 2) NOT NULL,
	[TongTienThanhToan] [decimal](18, 2) NOT NULL,
	[soluong] [int] NOT NULL,
	[PaymentId] [int] NOT NULL,
	[PaymentName] [nvarchar](50) NOT NULL,
	[IdVoucher] [int] NULL,
	[ValueVoucher] [int] NULL,
	[Giamgia] [decimal](18, 2) NULL,
	[Ship] [decimal](18, 2) NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
	[ODSuccess] [bit] NOT NULL,
	[ODReadly] [bit] NOT NULL,
	[ODTransported] [bit] NOT NULL,
	[Complete] [bit] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
	[ODHuy] [bit] NOT NULL,
 CONSTRAINT [PK_DbOrder] PRIMARY KEY CLUSTERED 
(
	[IdDh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbOrderDetail]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbOrderDetail](
	[IdCTDH] [int] IDENTITY(1,1) NOT NULL,
	[IdDh] [int] NOT NULL,
	[MaDh] [nvarchar](500) NOT NULL,
	[IdSp] [int] NOT NULL,
	[MaSp] [nvarchar](10) NOT NULL,
	[IdColor] [int] NOT NULL,
	[IdSize] [int] NOT NULL,
	[SoLuongSp] [int] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
	[PriceBy] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_DbOrderDetail] PRIMARY KEY CLUSTERED 
(
	[IdCTDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbPayment]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbPayment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentName] [nvarchar](50) NOT NULL,
	[Icon] [nvarchar](250) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbPayment] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbProduct]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbProduct](
	[IdSp] [int] IDENTITY(1,1) NOT NULL,
	[MaSp] [nvarchar](10) NULL,
	[IdDm] [int] NOT NULL,
	[TenSp] [nvarchar](250) NOT NULL,
	[SaoDanhGia] [int] NULL,
	[NhomId] [int] NOT NULL,
	[AnhSp] [nvarchar](250) NULL,
	[PriceMax] [decimal](18, 2) NOT NULL,
	[GiamGia] [int] NULL,
	[PriceMin] [decimal](18, 2) NULL,
	[LuotXem] [int] NULL,
	[LuotSold] [int] NULL,
	[MotaSp] [nvarchar](max) NOT NULL,
	[IActive] [bit] NOT NULL,
	[IFavorite] [bit] NOT NULL,
	[IFeature] [bit] NOT NULL,
	[IHot] [bit] NOT NULL,
	[ISale] [bit] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbProduct] PRIMARY KEY CLUSTERED 
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbProductDetail]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbProductDetail](
	[IdCTSP] [int] IDENTITY(1,1) NOT NULL,
	[IdSp] [int] NOT NULL,
	[SizeId] [int] NOT NULL,
	[NameSize] [nvarchar](50) NOT NULL,
	[ColorId] [int] NOT NULL,
	[NameColor] [nvarchar](50) NOT NULL,
	[SoLuongBan] [int] NULL,
	[GiaLoai] [decimal](18, 2) NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_DbProductDetail] PRIMARY KEY CLUSTERED 
(
	[IdCTSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbRating]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbRating](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdKh] [int] NOT NULL,
	[IdSp] [int] NOT NULL,
	[DanhGia] [nvarchar](max) NOT NULL,
	[Rate] [int] NOT NULL,
	[customerIdKh] [int] NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbRating] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbSize]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbSize](
	[SizeId] [int] IDENTITY(1,1) NOT NULL,
	[MaSize] [nvarchar](5) NOT NULL,
	[NameSize] [nvarchar](5) NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbSize] PRIMARY KEY CLUSTERED 
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbUser_Voucher]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbUser_Voucher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdKh] [int] NOT NULL,
	[IdVoucher] [int] NOT NULL,
	[UsedDate] [datetime2](7) NOT NULL,
	[customerIdKh] [int] NOT NULL,
	[voucherIdVoucher] [int] NOT NULL,
 CONSTRAINT [PK_DbUser_Voucher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbVoucher]    Script Date: 1/10/2025 4:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbVoucher](
	[IdVoucher] [int] IDENTITY(1,1) NOT NULL,
	[MaVoucher] [nvarchar](25) NOT NULL,
	[IconVoucher] [nvarchar](250) NOT NULL,
	[valueVoucher] [int] NOT NULL,
	[valueMax] [int] NULL,
	[MotaVoucher] [nvarchar](500) NOT NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [nvarchar](25) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](25) NULL,
 CONSTRAINT [PK_DbVoucher] PRIMARY KEY CLUSTERED 
(
	[IdVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241226131825_new-database', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241227093926_27-12-24', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241228092040_28-12-24', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241230125355_30-12-24', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250101065431_1-1-25', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250103123640_3-1-25', N'7.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250110072248_10-1-25', N'7.0.20')
GO
SET IDENTITY_INSERT [dbo].[DbAddress] ON 

INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (1, 26, N'đặng minh bảo', N'0916649300', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liê', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (2, 26, N'đặng minh bảo', N'0916649302', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêm', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (3, 26, N'đặng minh bảo', N'0916649300', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêm', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (4, 26, N'Hoành nhan bóc', N'0775368054', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêmm', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (5, 26, N'đặng minh bảo', N'0916649300', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêmm', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (6, 26, N'đặng minh bảo', N'0916649300', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêm', N'không ghi chú', 1)
INSERT [dbo].[DbAddress] ([IdAddress], [IdKh], [TenNguoiNhan], [Sdt], [Address], [City], [QuanHuyen], [PhuongXa], [GhiChu], [Idefault]) VALUES (7, 26, N'đặng minh bảo', N'0916649300', N' phương thông xã phương chiểu', N'Hà Nội', N'cổ nhuế', N'bắc từ liêm', N'không ghi chú', 1)
SET IDENTITY_INSERT [dbo].[DbAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[DbAds] ON 

INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (1, N'ads', N'1cbafa89-51aa-4076-be06-467ea7d64c2f.jpeg', N'ads', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (2, N'ads', N'9f727be4-ce72-47c5-846e-b6abd66f253d.jpeg', N'ads', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (4, N'ads', N'4f9030fd-a04f-43ca-b6ac-dd691cc5733c.jpeg', N'ads', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (5, N'Quần dài', N'9c2e212d-a217-4343-8191-a44ccd4dff6a.png', N'page1', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (6, N'quần short', N'fb7b37f2-64be-49d3-b5f6-d0fe1513c68c.jpeg', N'page2', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (7, N'Áo Phông', N'b38c8281-6bb3-40a4-95ec-a9e681300c61.jpeg', N'page3', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (8, N'áo khoác', N'1b60d01f-bebf-4d5f-b9e1-7c2f4f4bada5.jpeg', N'page4', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (9, N'all', N'523fe003-575b-4d9d-8b33-6aa9fcab6930.jpeg', N'All', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (10, N'hot', N'f731652d-78aa-40a4-be1f-175a2fc76342.png', N'Hot', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (11, N'new', N'a077d1e0-a608-4515-9c4a-ea8e7aa5a5ba.png', N'New', 1)
INSERT [dbo].[DbAds] ([Id], [MaAds], [Img], [Place], [IsActive]) VALUES (12, N'sale', N'0f0b63a5-07c5-4d62-9879-c556e1c20493.jpeg', N'Sale', 1)
SET IDENTITY_INSERT [dbo].[DbAds] OFF
GO
SET IDENTITY_INSERT [dbo].[DbCart] ON 

INSERT [dbo].[DbCart] ([Id], [IdSp], [IdKh], [ProductQuantity], [ColorId], [SizeId], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (4, 12, 24, 1, 2, 4, CAST(N'2025-01-01T18:12:24.9800000' AS DateTime2), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbCart] OFF
GO
SET IDENTITY_INSERT [dbo].[DbCategory] ON 

INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'DM0001', N'Quần Dài', N'2f3da891-9080-4cf0-8ec2-32c0f8960a1f.png', NULL, NULL, CAST(N'2024-12-28T23:48:08.3800000' AS DateTime2), N'bao2')
INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'DM0002', N'Áo Dài Tay', N'f78f26e2-ea81-405e-9d85-2e66d5bc6e47.png', NULL, NULL, CAST(N'2024-12-28T12:48:21.0000000' AS DateTime2), N'bao2')
INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'DM0003', N'Áo Cộc Tay', N'3585d63e-589a-4f01-85b1-2b1b52b0b331.png', NULL, NULL, CAST(N'2024-12-28T12:48:33.3866667' AS DateTime2), N'bao2')
INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'DM7', N'Áo Khoác', N'69872b23-90ee-4b7f-9b8e-af2487422e06.png', CAST(N'2024-12-28T12:48:55.1100000' AS DateTime2), N'Bao', NULL, NULL)
INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'DM8', N'Quần short', N'95dd6b9c-1ad1-4f98-bd86-c81f8066578f.png', CAST(N'2024-12-28T21:21:02.2500000' AS DateTime2), N'Bao', NULL, NULL)
INSERT [dbo].[DbCategory] ([IdDm], [MaDm], [TenDm], [AnhDaiDien], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (9, N'DM9', N'Áo 3 lỗ', N'a5801837-b332-4200-aa65-200b66cb43f6.png', CAST(N'2024-12-28T23:54:49.9300000' AS DateTime2), N'Bao', NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[DbColor] ON 

INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (2, N'CL2', N'Trắng', N'', CAST(N'2024-12-28T13:54:46.4233333' AS DateTime2), N'bao', CAST(N'2024-12-28T19:47:06.5100000' AS DateTime2), N'Bao2', N'#fff')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (3, N'CL3', N'Đen', N'', CAST(N'2024-12-28T19:50:27.0866667' AS DateTime2), N'bao', NULL, NULL, N'#000')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (4, N'CL4', N'Xanh Dương', N'', CAST(N'2024-12-28T22:14:28.4966667' AS DateTime2), N'bao', NULL, NULL, N'#24458A')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (5, N'CL5', N'Be', N'', CAST(N'2024-12-28T22:15:01.1133333' AS DateTime2), N'bao', CAST(N'2024-12-28T22:15:44.8600000' AS DateTime2), N'Bao2', N'#B7A88B')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (6, N'CL6', N'Be Nhạt', N'', CAST(N'2024-12-28T22:16:28.7766667' AS DateTime2), N'bao', NULL, NULL, N'#D1C9BD')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (7, N'CL7', N'Nâu cà Phê', N'', CAST(N'2024-12-28T22:16:58.9100000' AS DateTime2), N'bao', NULL, NULL, N'#362720')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (8, N'CL8', N'Xám Xi Măng', N'', CAST(N'2024-12-28T22:17:38.1533333' AS DateTime2), N'bao', NULL, NULL, N'#313A43')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (9, N'CL9', N'Xanh Xám', N'', CAST(N'2024-12-28T22:18:06.1833333' AS DateTime2), N'bao', NULL, NULL, N'#4A4B47')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (10, N'CL10', N'Nâu Nhạt', N'', CAST(N'2024-12-28T22:18:56.6966667' AS DateTime2), N'bao', CAST(N'2024-12-28T22:19:14.4300000' AS DateTime2), N'Bao2', N'#5C3729')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (11, N'CL11', N'Xanh Rêu đậm', N'', CAST(N'2024-12-29T14:09:02.8400000' AS DateTime2), N'bao', NULL, NULL, N'#292A15')
INSERT [dbo].[DbColor] ([ColorId], [MaColor], [NameColor], [Img], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [MaHex]) VALUES (12, N'CL12', N'Xanh Lavi', N'', CAST(N'2024-12-29T14:12:35.8900000' AS DateTime2), N'bao', NULL, NULL, N'#232E43')
SET IDENTITY_INSERT [dbo].[DbColor] OFF
GO
SET IDENTITY_INSERT [dbo].[DbCustomer] ON 

INSERT [dbo].[DbCustomer] ([IdKh], [MaKh], [TenKh], [Img], [GioiTinh], [Sdt], [Email], [Passwords], [ConfirmPasswords], [IsExternalAccount], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Birth]) VALUES (21, N'KH21', N'Đặng Minh Bảo', NULL, NULL, N'0916649300', N'test@gmail.com', N'thanhmi@123', N'thanhmi@123', 0, CAST(N'2024-12-30T20:01:58.8066667' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[DbCustomer] ([IdKh], [MaKh], [TenKh], [Img], [GioiTinh], [Sdt], [Email], [Passwords], [ConfirmPasswords], [IsExternalAccount], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Birth]) VALUES (24, N'KH24', N'Đặng Minh Bảo', NULL, NULL, N'0916649302', N'bobi72876@gmail.com', N'thanhmi@123', N'thanhmi@123', 0, CAST(N'2024-12-31T23:57:06.5766667' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[DbCustomer] ([IdKh], [MaKh], [TenKh], [Img], [GioiTinh], [Sdt], [Email], [Passwords], [ConfirmPasswords], [IsExternalAccount], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Birth]) VALUES (26, N'KH26', N'Minh Bảo Đặng', N'a413322a-7c18-4e84-b091-384636bf17b3.jpg', N'Nam', N'0988480163', N'baokun959@gmail.com', N'', NULL, 1, CAST(N'2025-01-01T01:48:01.2840364' AS DateTime2), NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbCustomer] OFF
GO
SET IDENTITY_INSERT [dbo].[DbFavoriteProduct] ON 

INSERT [dbo].[DbFavoriteProduct] ([id], [IdSp], [IdKh], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (44, 8, 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[DbFavoriteProduct] ([id], [IdSp], [IdKh], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (48, 9, 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[DbFavoriteProduct] ([id], [IdSp], [IdKh], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (49, 15, 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[DbFavoriteProduct] ([id], [IdSp], [IdKh], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (50, 11, 26, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbFavoriteProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[DbGroup] ON 

INSERT [dbo].[DbGroup] ([IdNhom], [MaNhom], [GroupName]) VALUES (1, N'GR01', N'Nam')
INSERT [dbo].[DbGroup] ([IdNhom], [MaNhom], [GroupName]) VALUES (2, N'GR02', N'Nữ')
INSERT [dbo].[DbGroup] ([IdNhom], [MaNhom], [GroupName]) VALUES (3, N'GR03', N'Nam/Nữ')
SET IDENTITY_INSERT [dbo].[DbGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[DbImg] ON 

INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (6, 9, N'/img/ccbbbf6a-0aff-4c94-933b-279ff486272b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (7, 9, N'/img/906fe2d4-f783-45ab-82ee-fc38b0b8866a.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (10, 11, N'/img/0978a771-077f-48eb-83f9-53d8fe89de44.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (11, 11, N'/img/28e1c781-2e6d-4a66-9eaf-3cf0f28e9e4b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (12, 11, N'/img/76a68c52-afe5-4428-8a33-517462ae9680.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (13, 12, N'/img/4c5abdec-7978-4f24-b01d-ad262159b2ea.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (14, 12, N'/img/dd6d6938-ad02-4567-8e7d-7760fa6f01df.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (15, 13, N'/img/60598322-ccf1-4f53-9b9c-68108bb8b873.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (16, 8, N'/img/e1770da2-368f-49d2-8a5b-7c872c3bcd7b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (17, 8, N'/img/db6e1e65-026b-43fb-86d7-6be7390f4f66.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (18, 10, N'/img/81a93c7c-c6cf-47a6-b2e9-18a00c9e62d3.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (19, 10, N'/img/bc116af0-22f4-4d6d-8209-0cdb9923121a.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (20, 10, N'/img/33321b9b-19a5-4f2f-b1b4-02d4493e0b0f.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (21, 14, N'/img/4a75d543-cac9-4f2d-b82f-3c8f868e5e08.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (22, 15, N'/img/19ff6f92-a688-4502-a345-fb03eb9c841b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (23, 15, N'/img/3a7ec0d6-478a-4ac4-b6f3-83b72c51c0c2.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (24, 16, N'/img/9a47dcd3-106e-4edf-9eb5-afa87ceee707.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (25, 17, N'/img/c5713aac-d593-48b1-9192-87a5d372a38c.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (26, 17, N'/img/e43be29e-b7a6-4464-9834-20ee0c22b8fd.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (27, 18, N'/img/10ebe7a3-e1af-47e9-a5b7-d9f9e1109467.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (28, 19, N'/img/3405bb6d-4185-4ff5-9582-8b040f29c01b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (29, 19, N'/img/a2f8fd79-494c-4ef3-8efa-d569997c5bbc.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (30, 19, N'/img/294d2d85-e84f-4386-bc3b-a768b11bca49.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (31, 20, N'/img/6c141dbc-3255-4fd9-9f9b-4a9162619acf.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (32, 20, N'/img/9cf1842f-1ce3-4431-a915-6d6e190e71b0.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (33, 21, N'/img/46923113-e3c2-458c-a129-d250b19e354b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (34, 21, N'/img/a8170872-cab0-4f15-ace9-d5ffd4e19eb6.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (35, 21, N'/img/05606f67-7087-4ca9-aa85-5e049ade8ef4.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (36, 22, N'/img/bc137529-9dac-471d-bc2c-313e9527564f.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (37, 22, N'/img/69e0f5ef-9be7-43b6-97dc-7b1e4631c245.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (38, 22, N'/img/a8d38e50-3f4f-4a31-a31c-3391896baa53.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (39, 23, N'/img/b5397fc8-4f60-4d2c-8ecb-c6c8f8970a26.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (40, 23, N'/img/2b8e907e-e10c-4680-8c03-131f310c3114.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (41, 23, N'/img/3a2f565a-b801-4d31-aa0b-93d6a5cb7110.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (42, 24, N'/img/5a2b6480-2627-49f3-9a4e-8345d6f440c3.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (43, 24, N'/img/f350bed7-728e-4b57-a96f-257600ddf792.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (44, 25, N'/img/ab212b78-c2c1-4b30-886b-f5550f7baac4.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (45, 25, N'/img/cfd5a2a7-1073-404e-9d8f-b3dc36ebaecd.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (46, 26, N'/img/b0f19e1d-feab-4f10-9487-a4af5c67c899.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (47, 26, N'/img/c0fc65e8-35f7-4bb8-b566-67c1df2eacf2.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (48, 27, N'/img/cefe581a-7301-4381-88a4-882290becfa2.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (49, 27, N'/img/a988c455-8515-43e4-8514-f1269b2540c7.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (50, 27, N'/img/4f538f9d-0ebc-4eaf-8190-c317e9c9964b.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (51, 27, N'/img/ae40ba1a-0ada-48fc-a33d-307266682671.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (52, 28, N'/img/f628cd86-958a-49c7-aa3e-664bc22cf9ae.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (53, 29, N'/img/53393ed3-f547-41c8-8a22-0ee685626347.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (54, 29, N'/img/f460437a-682c-4d3f-a7af-48e3d62b8f9a.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (55, 30, N'/img/57173d47-85d2-44be-b725-a938b5dab3a2.png', NULL)
INSERT [dbo].[DbImg] ([Id], [IdSp], [Img], [Place]) VALUES (56, 30, N'/img/79b62f4e-c5df-4984-95e9-5ce415ee078c.png', NULL)
SET IDENTITY_INSERT [dbo].[DbImg] OFF
GO
SET IDENTITY_INSERT [dbo].[DbOrder] ON 

INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (10, N'DH10', 26, N'Đặng Minh Bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'Trâu Quỳ', N'Gia Lâm', N'55 ngõ 62 trâu quỳ gia lâm hà nội', CAST(810000.00 AS Decimal(18, 2)), CAST(749000.00 AS Decimal(18, 2)), 3, 1, N'OCD-Thanh ', 1, 10, CAST(81000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-01T17:37:48.1233333' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (11, N'DH11', 26, N'Đặng Minh Bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'Trâu Quỳ', N'Gia Lâm', N'55 ngõ 62 trâu quỳ gia lâm hà nội', CAST(1050000.00 AS Decimal(18, 2)), CAST(965000.00 AS Decimal(18, 2)), 3, 1, N'OCD-Thanh ', 1, 10, CAST(105000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-01T18:08:27.4166667' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (12, N'DH12', 24, N'bùi thị khuyên', N'bobi72876@gmail.com', N'0916649300', N'Hà Nội', N'Trâu Quỳ', N'Gia Lâm', N'55 ngõ 62 trâu quỳ gia lâm hà nội', CAST(675000.00 AS Decimal(18, 2)), CAST(627500.00 AS Decimal(18, 2)), 2, 1, N'OCD-Thanh ', 1, 10, CAST(67500.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-01T18:13:03.0200000' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (13, N'DH13', 26, N'Đặng Minh Bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'Trâu Quỳ', N'Gia Lâm', N'55 ngõ 62 trâu quỳ gia lâm hà nội', CAST(700000.00 AS Decimal(18, 2)), CAST(650000.00 AS Decimal(18, 2)), 2, 1, N'OCD-Thanh ', 1, 10, CAST(70000.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-02T20:28:58.7566667' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (14, N'DH14', 26, N'Đặng Minh Bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'Trâu Quỳ', N'Gia Lâm', N'55 ngõ 62 trâu quỳ gia lâm hà nội', CAST(1428000.00 AS Decimal(18, 2)), CAST(1305200.00 AS Decimal(18, 2)), 4, 1, N'OCD-Thanh ', 1, 10, CAST(142800.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-02T23:10:36.5800000' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (15, N'DH15', 26, N'đặng minh bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'cổ nhuế', N'bắc từ liê', N' phương thông xã phương chiểu', CAST(288000.00 AS Decimal(18, 2)), CAST(279200.00 AS Decimal(18, 2)), 1, 1, N'OCD-Thanh ', 1, 10, CAST(28800.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-08T17:49:45.1466667' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (16, N'DH16', 26, N'đặng minh bảo', N'baokun959@gmail.com', N'0916649300', N'Hà Nội', N'cổ nhuế', N'bắc từ liê', N' phương thông xã phương chiểu', CAST(288000.00 AS Decimal(18, 2)), CAST(279200.00 AS Decimal(18, 2)), 1, 1, N'OCD-Thanh ', 1, 10, CAST(28800.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-08T19:26:14.6066667' AS DateTime2), NULL, NULL, NULL, 0)
INSERT [dbo].[DbOrder] ([IdDh], [MaDh], [IdKh], [NguoiNhan], [EmailKh], [Sdt], [City], [District], [Ward], [DiaChi], [TongTien], [TongTienThanhToan], [soluong], [PaymentId], [PaymentName], [IdVoucher], [ValueVoucher], [Giamgia], [Ship], [GhiChu], [ODSuccess], [ODReadly], [ODTransported], [Complete], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [ODHuy]) VALUES (28, N'DH28', 26, N'Hoành nhan bóc', N'baokun959@gmail.com', N'0775368054', N'Hà Nội', N'cổ nhuế', N'bắc từ liê', N' phương thông xã phương chiểu', CAST(510000.00 AS Decimal(18, 2)), CAST(530000.00 AS Decimal(18, 2)), 2, 1, N'OCD-Thanh ', NULL, 0, CAST(0.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'không ghi chú', 1, 0, 0, 0, CAST(N'2025-01-08T21:07:07.6766667' AS DateTime2), NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[DbOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[DbOrderDetail] ON 

INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (1, 10, N'DH10', 9, N'SP9', 3, 3, 2, CAST(N'2025-01-01T17:37:48.1400000' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (2, 10, N'DH10', 9, N'SP9', 10, 3, 1, CAST(N'2025-01-01T17:37:48.2333333' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (3, 11, N'DH11', 11, N'SP11', 3, 3, 3, CAST(N'2025-01-01T18:08:27.4266667' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (4, 12, N'DH12', 9, N'SP9', 3, 3, 1, CAST(N'2025-01-01T18:13:03.0300000' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (5, 12, N'DH12', 12, N'SP12', 3, 4, 1, CAST(N'2025-01-01T18:13:03.0400000' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (6, 13, N'DH13', 11, N'SP11', 3, 3, 2, CAST(N'2025-01-02T20:28:59.3300000' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (7, 14, N'DH14', 12, N'SP12', 2, 4, 3, CAST(N'2025-01-02T23:10:36.6100000' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (8, 14, N'DH14', 12, N'SP12', 3, 4, 1, CAST(N'2025-01-02T23:10:36.6833333' AS DateTime2), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (9, 15, N'DH15', 8, N'SP8', 5, 3, 1, CAST(N'2025-01-08T17:49:45.9966667' AS DateTime2), NULL, NULL, NULL, CAST(288000.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (10, 16, N'DH16', 8, N'SP8', 5, 3, 1, CAST(N'2025-01-08T19:26:15.0566667' AS DateTime2), NULL, NULL, NULL, CAST(288000.00 AS Decimal(18, 2)))
INSERT [dbo].[DbOrderDetail] ([IdCTDH], [IdDh], [MaDh], [IdSp], [MaSp], [IdColor], [IdSize], [SoLuongSp], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [PriceBy]) VALUES (11, 28, N'DH28', 9, N'SP9', 3, 3, 2, CAST(N'2025-01-08T21:07:07.7000000' AS DateTime2), NULL, NULL, NULL, CAST(255000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[DbOrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[DbPayment] ON 

INSERT [dbo].[DbPayment] ([PaymentId], [PaymentName], [Icon], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'OCD-Thanh Toán Khi Nhận Hàng', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[DbPayment] ([PaymentId], [PaymentName], [Icon], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'ZaloPay', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[DbPayment] ([PaymentId], [PaymentName], [Icon], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'MoMo', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbPayment] OFF
GO
SET IDENTITY_INSERT [dbo].[DbProduct] ON 

INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'SP8', 7, N'Áo khoác nhung tăm cổ bẻ kiểu trơn 1 lớp dày dặn chuẩn form thời trang', NULL, 1, N'2ee05e7a-09a6-41fb-89c5-d85678f1f7df.png', CAST(320000.00 AS Decimal(18, 2)), 10, CAST(288000.00 AS Decimal(18, 2)), NULL, NULL, N'Không mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-28T22:21:49.8666667' AS DateTime2), N'bao', CAST(N'2024-12-28T23:05:15.2633333' AS DateTime2), N'bao2')
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (9, N'SP9', 7, N'Áo khoác Nam có mũ DailyWear', NULL, 1, N'd2e64d7a-269a-42b1-be6b-1c5107c89dcb.png', CAST(300000.00 AS Decimal(18, 2)), 15, CAST(255000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-28T22:29:20.8866667' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'SP10', 7, N'Áo khoác hoodies Fast and cool', NULL, 1, N'60207b99-7867-4dbe-8ce4-08a3b13ad9d0.png', CAST(256000.00 AS Decimal(18, 2)), 0, CAST(256000.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 0, 0, 0, 0, CAST(N'2024-12-28T22:32:36.3100000' AS DateTime2), N'bao', CAST(N'2024-12-28T23:24:26.7966667' AS DateTime2), N'bao2')
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (11, N'SP11', 7, N'Áo khoác jean denim caro nam unisex form rộng basic, áo khoát jacket jean nam nữ caro phong cách đườ', NULL, 1, N'b6aa6845-62d5-4c0e-a052-5eb4a5eba6cf.png', CAST(350000.00 AS Decimal(18, 2)), 10, CAST(315000.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-28T22:36:07.2733333' AS DateTime2), N'bao', CAST(N'2024-12-28T22:39:01.8800000' AS DateTime2), N'bao2')
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'SP12', 7, N'Áo Khoác cá tính phong cách hiện đại', NULL, 1, N'c5924775-5c09-4a17-88a5-06837a6cac34.png', CAST(420000.00 AS Decimal(18, 2)), 20, CAST(336000.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-28T22:38:47.5200000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'SP13', 7, N'Áo Khoác cá tính phong cách hiện đại', NULL, 1, N'8cc272ad-63c4-4a43-970d-618b84eadeb1.png', CAST(320000.00 AS Decimal(18, 2)), 0, CAST(320000.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 1, 1, 0, 0, CAST(N'2024-12-28T23:03:53.3833333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (14, N'SP14', 2, N'áo dài tay thời trang cho nam', NULL, 2, N'955d21f0-e0ed-4bb3-9949-788363afc855.png', CAST(205000.00 AS Decimal(18, 2)), 0, CAST(205000.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 1, 1, 0, 0, CAST(N'2024-12-28T23:26:09.2900000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'SP15', 3, N'Áo phông Nam hoạt họa cute phong cách nhí nhảnh', NULL, 3, N'0993a1fb-2fa4-455f-9f7a-463f9cb25fa5.png', CAST(156000.00 AS Decimal(18, 2)), 10, CAST(140400.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 1, 1, 0, CAST(N'2024-12-28T23:30:41.6400000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'SP16', 3, N'Áo phông Nam shin cute phong cách nhí nhảnh', NULL, 3, N'c3b29cf9-65ee-400b-9fc2-d13c513ae96e.png', CAST(163000.00 AS Decimal(18, 2)), 10, CAST(146700.00 AS Decimal(18, 2)), NULL, NULL, N'không mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-28T23:33:20.5600000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'SP17', 3, N'Áo phông Nam hoạt họa mặt cười phong cách đơn  giản', NULL, 3, N'6029f87e-2345-4b8d-b55b-34e1736dc5e8.png', CAST(142000.00 AS Decimal(18, 2)), 0, CAST(142000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 1, 0, 0, CAST(N'2024-12-28T23:39:49.9466667' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'SP18', 3, N'Áo thun nam dáng thể thao chạy bộ', NULL, 1, N'8b383010-5e3c-415b-9758-4a5e24faab81.png', CAST(174000.00 AS Decimal(18, 2)), 10, CAST(156600.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-28T23:42:28.8366667' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'SP19', 3, N'Áo thun nam dáng thanh lịch ,lịch sự ,tối giản', NULL, 1, N'0ff94664-961b-41b8-8cbb-e8465159c311.png', CAST(192000.00 AS Decimal(18, 2)), 10, CAST(172800.00 AS Decimal(18, 2)), NULL, NULL, N'không trống', 1, 0, 1, 0, 1, CAST(N'2024-12-28T23:46:50.1300000' AS DateTime2), N'bao', CAST(N'2024-12-28T23:47:02.3166667' AS DateTime2), N'bao2')
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'SP20', 8, N'Quần SHORT BASI Nam nữ Unisex eo co giãn 2 màu kem/đen - quần đùi ngắn form OVERSIZE', NULL, 2, N'0cbdc90e-1e41-4a43-b744-c7b1da5a19a6.png', CAST(256000.00 AS Decimal(18, 2)), 10, CAST(230400.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 1, 1, 0, CAST(N'2024-12-29T13:18:13.4933333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'SP21', 8, N'Quần short kaki nam basic form rộng thể thao phong cách Retro K2181', NULL, 2, N'33d9254f-1fad-4b56-b2ea-d81ec92557f8.png', CAST(239000.00 AS Decimal(18, 2)), 0, CAST(239000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 0, 0, CAST(N'2024-12-29T13:22:05.6833333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'SP22', 8, N'Quần short unisex Dây+Túi bên ngoài, chất mát mền và không nhắn, phong cách ulzang', NULL, 3, N'77c82ca9-3603-400c-b062-362b0fec6313.png', CAST(256000.00 AS Decimal(18, 2)), 15, CAST(217600.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-29T13:25:39.6500000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'SP23', 8, N'Quần short túi hộp kaki dành cho nam nữ QN5 45-85kg năng động thời trang', NULL, 3, N'41a32b3e-3fdc-46f9-b914-94b8e184e4cb.png', CAST(230000.00 AS Decimal(18, 2)), 10, CAST(207000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-29T13:29:40.1800000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (24, N'SP24', 1, N'Quần Jogger Nam UT đa năng ống xuông', NULL, 3, N'2642c4d1-67eb-479e-8966-966c6b34df19.png', CAST(300000.00 AS Decimal(18, 2)), 10, CAST(270000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa có ', 1, 0, 1, 1, 0, CAST(N'2024-12-29T13:58:05.3033333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (25, N'SP25', 1, N'Quần Jogger Nam Kiểu Dáng Thời Trang Tinh Tế Bo Chun Ống Chân Zenkocs3 MEN QUAN 068', NULL, 3, N'01287aac-07f6-4ab9-a38b-999a2a77c7e3.png', CAST(230000.00 AS Decimal(18, 2)), 10, CAST(207000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-29T14:00:47.2000000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (26, N'SP26', 1, N'Quần Jogger Nam UT đa năng', NULL, 1, N'42e5b810-5001-4b2d-8b07-93c1a31f7c8d.png', CAST(200000.00 AS Decimal(18, 2)), 10, CAST(180000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 0, 1, 0, CAST(N'2024-12-29T14:03:37.7133333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (27, N'SP27', 1, N'Quần Jogger PAUL FITZGERALD Thời Trang Năng Động Cho Nam', NULL, 1, N'73221843-b39b-4178-93de-1e5d045a441a.png', CAST(320000.00 AS Decimal(18, 2)), 10, CAST(288000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-29T14:11:40.7300000' AS DateTime2), N'bao', CAST(N'2024-12-29T14:13:08.4633333' AS DateTime2), N'bao2')
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (28, N'SP28', 1, N'Quần jean nam dáng vừa Basics', NULL, 1, N'1c750f60-cc24-4a13-9ef3-1fef2bc7e25a.png', CAST(250000.00 AS Decimal(18, 2)), 12, CAST(220000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-29T14:16:17.3800000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (29, N'SP29', 1, N'Quần Jogger Nam Kiểu Dáng Thời Trang Tinh Tế Bo Chun Ống Chân Zenkocs3 MEN QUAN 068', NULL, 1, N'7f605b5b-86f7-46b3-b49d-c9a75172a529.png', CAST(190000.00 AS Decimal(18, 2)), 0, CAST(190000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 0, 0, CAST(N'2024-12-29T14:18:27.0600000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (30, N'SP30', 9, N'áo  3 lỗ thể thao mát mẻ,thoáng mát thoải mái', NULL, 1, N'7e5507d2-5bc3-4a3d-b139-d1a8c33ae0bc.png', CAST(159000.00 AS Decimal(18, 2)), 10, CAST(143100.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-29T14:22:02.7533333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (31, N'SP31', 9, N'áo 3 lỗ nam', NULL, 1, N'2943f6f4-26d6-4f9b-b965-f472e34ceec3.png', CAST(159000.00 AS Decimal(18, 2)), 0, CAST(159000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 0, 0, 0, CAST(N'2024-12-29T14:23:55.0100000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (32, N'SP32', 9, N'Áo phông 3 lỗ ', NULL, 1, N'8c06c947-2290-45b4-9e02-fc339ad1dab7.png', CAST(209000.00 AS Decimal(18, 2)), 10, CAST(188100.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 0, 1, 1, 0, CAST(N'2024-12-29T14:25:49.9100000' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbProduct] ([IdSp], [MaSp], [IdDm], [TenSp], [SaoDanhGia], [NhomId], [AnhSp], [PriceMax], [GiamGia], [PriceMin], [LuotXem], [LuotSold], [MotaSp], [IActive], [IFavorite], [IFeature], [IHot], [ISale], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (33, N'SP33', 3, N'Áo phông nam/nữ trẻ trung phong cách', NULL, 3, N'cb123aad-ee39-41d4-8ce7-0790e1be919b.png', CAST(200000.00 AS Decimal(18, 2)), 10, CAST(180000.00 AS Decimal(18, 2)), NULL, NULL, N'chưa mô tả', 1, 1, 0, 1, 0, CAST(N'2024-12-29T14:27:34.0866667' AS DateTime2), N'bao', NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[DbProductDetail] ON 

INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (9, 9, 3, N'L', 3, N'Đen', 2, CAST(255000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (10, 9, 4, N'XL', 5, N'Be', 0, CAST(300000.00 AS Decimal(18, 2)), 75)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (11, 9, 3, N'L', 10, N'Nâu Nhạt', 0, CAST(300000.00 AS Decimal(18, 2)), 199)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (12, 9, 4, N'XL', 10, N'Nâu Nhạt', 0, CAST(255000.00 AS Decimal(18, 2)), 150)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (19, 12, 4, N'XL', 2, N'Trắng', 0, CAST(336000.00 AS Decimal(18, 2)), 247)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (20, 12, 4, N'XL', 3, N'Đen', 0, CAST(420000.00 AS Decimal(18, 2)), 298)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (21, 11, 3, N'L', 3, N'Đen', 0, CAST(350000.00 AS Decimal(18, 2)), 245)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (22, 11, 4, N'XL', 3, N'Đen', 0, CAST(315000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (27, 13, 2, N'M', 2, N'Trắng', 0, CAST(320000.00 AS Decimal(18, 2)), 126)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (28, 13, 3, N'L', 2, N'Trắng', 0, CAST(320000.00 AS Decimal(18, 2)), 124)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (29, 13, 2, N'M', 3, N'Đen', 0, CAST(320000.00 AS Decimal(18, 2)), 150)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (30, 13, 4, N'XL', 3, N'Đen', 0, CAST(320000.00 AS Decimal(18, 2)), 150)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (31, 8, 3, N'L', 3, N'Đen', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (32, 8, 4, N'XL', 3, N'Đen', 0, CAST(288000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (33, 8, 3, N'L', 5, N'Be', 1, CAST(288000.00 AS Decimal(18, 2)), 78)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (34, 8, 4, N'XL', 5, N'Be', 0, CAST(320000.00 AS Decimal(18, 2)), 200)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (35, 8, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(320000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (36, 8, 4, N'XL', 8, N'Xám Xi Măng', 0, CAST(288000.00 AS Decimal(18, 2)), 80)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (37, 10, 3, N'L', 2, N'Trắng', 0, CAST(256000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (38, 10, 4, N'XL', 2, N'Trắng', 0, CAST(256000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (39, 10, 3, N'L', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (40, 10, 4, N'XL', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (41, 14, 1, N'S', 2, N'Trắng', 0, CAST(205000.00 AS Decimal(18, 2)), 164)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (42, 14, 3, N'L', 2, N'Trắng', 0, CAST(205000.00 AS Decimal(18, 2)), 136)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (43, 14, 2, N'M', 3, N'Đen', 0, CAST(205000.00 AS Decimal(18, 2)), 205)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (44, 14, 3, N'L', 3, N'Đen', 0, CAST(205000.00 AS Decimal(18, 2)), 95)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (45, 15, 1, N'S', 2, N'Trắng', 0, CAST(156000.00 AS Decimal(18, 2)), 155)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (46, 15, 3, N'L', 2, N'Trắng', 0, CAST(140400.00 AS Decimal(18, 2)), 145)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (47, 15, 1, N'S', 3, N'Đen', 0, CAST(140400.00 AS Decimal(18, 2)), 126)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (48, 15, 2, N'M', 3, N'Đen', 0, CAST(156000.00 AS Decimal(18, 2)), 74)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (49, 15, 1, N'S', 4, N'Xanh Dương', 0, CAST(140400.00 AS Decimal(18, 2)), 127)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (50, 15, 3, N'L', 4, N'Xanh Dương', 0, CAST(156000.00 AS Decimal(18, 2)), 163)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (51, 16, 1, N'S', 2, N'Trắng', 0, CAST(146700.00 AS Decimal(18, 2)), 155)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (52, 16, 2, N'M', 2, N'Trắng', 0, CAST(146700.00 AS Decimal(18, 2)), 45)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (53, 16, 3, N'L', 2, N'Trắng', 0, CAST(146700.00 AS Decimal(18, 2)), 95)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (54, 16, 2, N'M', 3, N'Đen', 0, CAST(163000.00 AS Decimal(18, 2)), 35)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (55, 16, 3, N'L', 3, N'Đen', 0, CAST(163000.00 AS Decimal(18, 2)), 70)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (56, 17, 1, N'S', 2, N'Trắng', 0, CAST(142000.00 AS Decimal(18, 2)), 252)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (57, 17, 3, N'L', 2, N'Trắng', 0, CAST(142000.00 AS Decimal(18, 2)), 45)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (58, 17, 2, N'M', 3, N'Đen', 0, CAST(142000.00 AS Decimal(18, 2)), 163)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (59, 17, 3, N'L', 3, N'Đen', 0, CAST(142000.00 AS Decimal(18, 2)), 25)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (60, 17, 2, N'M', 8, N'Xám Xi Măng', 0, CAST(142000.00 AS Decimal(18, 2)), 71)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (61, 17, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(142000.00 AS Decimal(18, 2)), 92)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (62, 18, 2, N'M', 3, N'Đen', 0, CAST(174000.00 AS Decimal(18, 2)), 45)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (63, 18, 3, N'L', 3, N'Đen', 0, CAST(174000.00 AS Decimal(18, 2)), 65)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (64, 18, 2, N'M', 8, N'Xám Xi Măng', 0, CAST(156600.00 AS Decimal(18, 2)), 90)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (65, 18, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(156600.00 AS Decimal(18, 2)), 94)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (74, 19, 2, N'M', 2, N'Trắng', 0, CAST(192000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (75, 19, 4, N'XL', 2, N'Trắng', 0, CAST(172800.00 AS Decimal(18, 2)), 37)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (76, 19, 2, N'M', 5, N'Be', 0, CAST(192000.00 AS Decimal(18, 2)), 43)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (77, 19, 3, N'L', 5, N'Be', 0, CAST(172800.00 AS Decimal(18, 2)), 63)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (78, 19, 2, N'M', 8, N'Xám Xi Măng', 0, CAST(192000.00 AS Decimal(18, 2)), 181)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (79, 19, 4, N'XL', 8, N'Xám Xi Măng', 0, CAST(172800.00 AS Decimal(18, 2)), 99)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (80, 19, 2, N'M', 9, N'Xanh Xám', 0, CAST(192000.00 AS Decimal(18, 2)), 53)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (81, 19, 3, N'L', 9, N'Xanh Xám', 0, CAST(172800.00 AS Decimal(18, 2)), 77)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (82, 20, 2, N'M', 2, N'Trắng', 0, CAST(256000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (83, 20, 2, N'M', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (84, 20, 3, N'L', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 135)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (85, 20, 2, N'M', 7, N'Nâu cà Phê', 0, CAST(256000.00 AS Decimal(18, 2)), 45)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (86, 20, 3, N'L', 7, N'Nâu cà Phê', 0, CAST(256000.00 AS Decimal(18, 2)), 55)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (87, 21, 2, N'M', 3, N'Đen', 0, CAST(239000.00 AS Decimal(18, 2)), 165)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (88, 21, 3, N'L', 3, N'Đen', 0, CAST(239000.00 AS Decimal(18, 2)), 125)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (89, 21, 4, N'XL', 3, N'Đen', 0, CAST(239000.00 AS Decimal(18, 2)), 178)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (90, 21, 2, N'M', 5, N'Be', 0, CAST(239000.00 AS Decimal(18, 2)), 389)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (91, 21, 3, N'L', 5, N'Be', 0, CAST(239000.00 AS Decimal(18, 2)), 435)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (92, 21, 4, N'XL', 5, N'Be', 0, CAST(239000.00 AS Decimal(18, 2)), 27)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (93, 22, 1, N'S', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 134)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (94, 22, 2, N'M', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 64)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (95, 22, 3, N'L', 3, N'Đen', 0, CAST(239000.00 AS Decimal(18, 2)), 72)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (96, 22, 4, N'XL', 3, N'Đen', 0, CAST(256000.00 AS Decimal(18, 2)), 88)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (97, 22, 2, N'M', 5, N'Be', 0, CAST(256000.00 AS Decimal(18, 2)), 126)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (98, 22, 3, N'L', 5, N'Be', 0, CAST(217600.00 AS Decimal(18, 2)), 173)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (99, 22, 4, N'XL', 5, N'Be', 0, CAST(256000.00 AS Decimal(18, 2)), 101)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (100, 22, 2, N'M', 7, N'Nâu cà Phê', 0, CAST(217600.00 AS Decimal(18, 2)), 81)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (101, 22, 3, N'L', 7, N'Nâu cà Phê', 0, CAST(256000.00 AS Decimal(18, 2)), 99)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (102, 22, 4, N'XL', 7, N'Nâu cà Phê', 0, CAST(217600.00 AS Decimal(18, 2)), 20)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (103, 23, 2, N'M', 3, N'Đen', 0, CAST(230000.00 AS Decimal(18, 2)), 200)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (104, 23, 3, N'L', 3, N'Đen', 0, CAST(230000.00 AS Decimal(18, 2)), 150)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (105, 23, 3, N'L', 9, N'Xanh Xám', 0, CAST(207000.00 AS Decimal(18, 2)), 150)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (106, 23, 4, N'XL', 9, N'Xanh Xám', 0, CAST(207000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (107, 24, 1, N'S', 2, N'Trắng', 0, CAST(300000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (108, 24, 2, N'M', 2, N'Trắng', 0, CAST(270000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (109, 24, 1, N'S', 3, N'Đen', 0, CAST(300000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (110, 24, 2, N'M', 3, N'Đen', 0, CAST(270000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (111, 24, 3, N'L', 3, N'Đen', 0, CAST(300000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (112, 24, 1, N'S', 5, N'Be', 0, CAST(270000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (113, 24, 3, N'L', 5, N'Be', 0, CAST(270000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (114, 25, 2, N'M', 3, N'Đen', 0, CAST(230000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (115, 25, 3, N'L', 3, N'Đen', 0, CAST(207000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (116, 25, 2, N'M', 5, N'Be', 0, CAST(230000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (117, 25, 2, N'M', 9, N'Xanh Xám', 0, CAST(207000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (118, 25, 3, N'L', 9, N'Xanh Xám', 0, CAST(207000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (119, 26, 1, N'S', 8, N'Xám Xi Măng', 0, CAST(200000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (120, 26, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (121, 26, 1, N'S', 9, N'Xanh Xám', 0, CAST(200000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (122, 26, 2, N'M', 9, N'Xanh Xám', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (123, 26, 3, N'L', 9, N'Xanh Xám', 0, CAST(200000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (124, 26, 1, N'S', 3, N'Đen', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (125, 26, 3, N'L', 3, N'Đen', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
GO
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (136, 27, 2, N'M', 8, N'Xám Xi Măng', 0, CAST(320000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (137, 27, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (138, 27, 2, N'M', 9, N'Xanh Xám', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (139, 27, 3, N'L', 9, N'Xanh Xám', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (140, 27, 2, N'M', 11, N'Xanh Rêu đậm', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (141, 27, 3, N'L', 11, N'Xanh Rêu đậm', 0, CAST(320000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (142, 27, 2, N'M', 12, N'Xanh Lavi', 0, CAST(288000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (143, 27, 3, N'L', 12, N'Xanh Lavi', 0, CAST(320000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (144, 28, 1, N'S', 3, N'Đen', 0, CAST(250000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (145, 28, 2, N'M', 3, N'Đen', 0, CAST(250000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (146, 28, 3, N'L', 3, N'Đen', 0, CAST(220000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (147, 28, 1, N'S', 8, N'Xám Xi Măng', 0, CAST(250000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (148, 28, 2, N'M', 8, N'Xám Xi Măng', 0, CAST(250000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (149, 28, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(220000.00 AS Decimal(18, 2)), 120)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (150, 29, 2, N'M', 3, N'Đen', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (151, 29, 3, N'L', 3, N'Đen', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (152, 29, 4, N'XL', 3, N'Đen', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (153, 29, 2, N'M', 4, N'Xanh Dương', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (154, 29, 4, N'XL', 4, N'Xanh Dương', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (155, 29, 2, N'M', 5, N'Be', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (156, 29, 3, N'L', 5, N'Be', 0, CAST(190000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (157, 30, 1, N'S', 2, N'Trắng', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (158, 30, 2, N'M', 2, N'Trắng', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (159, 30, 3, N'L', 2, N'Trắng', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (160, 30, 1, N'S', 3, N'Đen', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (161, 30, 2, N'M', 3, N'Đen', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (162, 30, 3, N'L', 3, N'Đen', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (163, 30, 4, N'XL', 3, N'Đen', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (164, 30, 1, N'S', 8, N'Xám Xi Măng', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (165, 30, 3, N'L', 8, N'Xám Xi Măng', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (166, 30, 4, N'XL', 8, N'Xám Xi Măng', 0, CAST(143100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (167, 31, 1, N'S', 3, N'Đen', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (168, 31, 2, N'M', 3, N'Đen', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (169, 31, 3, N'L', 3, N'Đen', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (170, 31, 4, N'XL', 3, N'Đen', 0, CAST(159000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (171, 32, 1, N'S', 2, N'Trắng', 0, CAST(209000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (172, 32, 2, N'M', 2, N'Trắng', 0, CAST(188100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (173, 32, 3, N'L', 2, N'Trắng', 0, CAST(209000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (174, 32, 1, N'S', 3, N'Đen', 0, CAST(188100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (175, 32, 2, N'M', 3, N'Đen', 0, CAST(209000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (176, 32, 3, N'L', 3, N'Đen', 0, CAST(188100.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (177, 33, 1, N'S', 3, N'Đen', 0, CAST(200000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (178, 33, 2, N'M', 3, N'Đen', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (179, 33, 3, N'L', 3, N'Đen', 0, CAST(200000.00 AS Decimal(18, 2)), 100)
INSERT [dbo].[DbProductDetail] ([IdCTSP], [IdSp], [SizeId], [NameSize], [ColorId], [NameColor], [SoLuongBan], [GiaLoai], [Quantity]) VALUES (180, 33, 4, N'XL', 3, N'Đen', 0, CAST(180000.00 AS Decimal(18, 2)), 100)
SET IDENTITY_INSERT [dbo].[DbProductDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[DbSize] ON 

INSERT [dbo].[DbSize] ([SizeId], [MaSize], [NameSize], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'S', N'S', CAST(N'2024-12-28T15:48:12.7633333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbSize] ([SizeId], [MaSize], [NameSize], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'M', N'M', CAST(N'2024-12-28T15:48:25.4866667' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbSize] ([SizeId], [MaSize], [NameSize], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'L', N'L', CAST(N'2024-12-28T15:48:30.5533333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbSize] ([SizeId], [MaSize], [NameSize], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'XL', N'XL', CAST(N'2024-12-28T15:48:39.6633333' AS DateTime2), N'bao', NULL, NULL)
INSERT [dbo].[DbSize] ([SizeId], [MaSize], [NameSize], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'XXL', N'XXL', CAST(N'2024-12-28T15:48:47.5200000' AS DateTime2), N'bao', NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbSize] OFF
GO
SET IDENTITY_INSERT [dbo].[DbVoucher] ON 

INSERT [dbo].[DbVoucher] ([IdVoucher], [MaVoucher], [IconVoucher], [valueVoucher], [valueMax], [MotaVoucher], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'VC001', N'hdcy', 10, NULL, N'mpvc', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DbVoucher] OFF
GO
/****** Object:  Index [IX_DbAddress_IdKh]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbAddress_IdKh] ON [dbo].[DbAddress]
(
	[IdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbCart_ColorId]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbCart_ColorId] ON [dbo].[DbCart]
(
	[ColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbCart_IdKh]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbCart_IdKh] ON [dbo].[DbCart]
(
	[IdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbCart_IdSp]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbCart_IdSp] ON [dbo].[DbCart]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbCart_SizeId]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbCart_SizeId] ON [dbo].[DbCart]
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbFavoriteProduct_IdKh]    Script Date: 1/10/2025 4:01:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbFavoriteProduct_IdKh] ON [dbo].[DbFavoriteProduct]
(
	[IdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbFavoriteProduct_IdSp]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbFavoriteProduct_IdSp] ON [dbo].[DbFavoriteProduct]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbImg_IdSp]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbImg_IdSp] ON [dbo].[DbImg]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbOrder_IdKh]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbOrder_IdKh] ON [dbo].[DbOrder]
(
	[IdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbOrder_IdVoucher]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbOrder_IdVoucher] ON [dbo].[DbOrder]
(
	[IdVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbOrder_PaymentId]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbOrder_PaymentId] ON [dbo].[DbOrder]
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbOrderDetail_IdDh]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbOrderDetail_IdDh] ON [dbo].[DbOrderDetail]
(
	[IdDh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbOrderDetail_IdSp]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbOrderDetail_IdSp] ON [dbo].[DbOrderDetail]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbProduct_IdDm]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbProduct_IdDm] ON [dbo].[DbProduct]
(
	[IdDm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbProduct_NhomId]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbProduct_NhomId] ON [dbo].[DbProduct]
(
	[NhomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbProductDetail_ColorId]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbProductDetail_ColorId] ON [dbo].[DbProductDetail]
(
	[ColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbProductDetail_IdSp]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbProductDetail_IdSp] ON [dbo].[DbProductDetail]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbProductDetail_SizeId]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbProductDetail_SizeId] ON [dbo].[DbProductDetail]
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbRating_customerIdKh]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbRating_customerIdKh] ON [dbo].[DbRating]
(
	[customerIdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbRating_IdSp]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbRating_IdSp] ON [dbo].[DbRating]
(
	[IdSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbUser_Voucher_customerIdKh]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbUser_Voucher_customerIdKh] ON [dbo].[DbUser_Voucher]
(
	[customerIdKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbUser_Voucher_voucherIdVoucher]    Script Date: 1/10/2025 4:01:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbUser_Voucher_voucherIdVoucher] ON [dbo].[DbUser_Voucher]
(
	[voucherIdVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DbOrder] ADD  DEFAULT (CONVERT([bit],(0))) FOR [ODSuccess]
GO
ALTER TABLE [dbo].[DbOrder] ADD  DEFAULT (CONVERT([bit],(0))) FOR [ODReadly]
GO
ALTER TABLE [dbo].[DbOrder] ADD  DEFAULT (CONVERT([bit],(0))) FOR [ODTransported]
GO
ALTER TABLE [dbo].[DbOrder] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Complete]
GO
ALTER TABLE [dbo].[DbOrder] ADD  DEFAULT (CONVERT([bit],(0))) FOR [ODHuy]
GO
ALTER TABLE [dbo].[DbOrderDetail] ADD  DEFAULT ((0.0)) FOR [PriceBy]
GO
ALTER TABLE [dbo].[DbAddress]  WITH CHECK ADD  CONSTRAINT [FK_DbAddress_DbCustomer_IdKh] FOREIGN KEY([IdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbAddress] CHECK CONSTRAINT [FK_DbAddress_DbCustomer_IdKh]
GO
ALTER TABLE [dbo].[DbCart]  WITH CHECK ADD  CONSTRAINT [FK_DbCart_DbColor_ColorId] FOREIGN KEY([ColorId])
REFERENCES [dbo].[DbColor] ([ColorId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbCart] CHECK CONSTRAINT [FK_DbCart_DbColor_ColorId]
GO
ALTER TABLE [dbo].[DbCart]  WITH CHECK ADD  CONSTRAINT [FK_DbCart_DbCustomer_IdKh] FOREIGN KEY([IdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbCart] CHECK CONSTRAINT [FK_DbCart_DbCustomer_IdKh]
GO
ALTER TABLE [dbo].[DbCart]  WITH CHECK ADD  CONSTRAINT [FK_DbCart_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbCart] CHECK CONSTRAINT [FK_DbCart_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbCart]  WITH CHECK ADD  CONSTRAINT [FK_DbCart_DbSize_SizeId] FOREIGN KEY([SizeId])
REFERENCES [dbo].[DbSize] ([SizeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbCart] CHECK CONSTRAINT [FK_DbCart_DbSize_SizeId]
GO
ALTER TABLE [dbo].[DbFavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_DbFavoriteProduct_DbCustomer_IdKh] FOREIGN KEY([IdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbFavoriteProduct] CHECK CONSTRAINT [FK_DbFavoriteProduct_DbCustomer_IdKh]
GO
ALTER TABLE [dbo].[DbFavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_DbFavoriteProduct_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbFavoriteProduct] CHECK CONSTRAINT [FK_DbFavoriteProduct_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbImg]  WITH CHECK ADD  CONSTRAINT [FK_DbImg_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbImg] CHECK CONSTRAINT [FK_DbImg_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbOrder]  WITH CHECK ADD  CONSTRAINT [FK_DbOrder_DbCustomer_IdKh] FOREIGN KEY([IdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
GO
ALTER TABLE [dbo].[DbOrder] CHECK CONSTRAINT [FK_DbOrder_DbCustomer_IdKh]
GO
ALTER TABLE [dbo].[DbOrder]  WITH CHECK ADD  CONSTRAINT [FK_DbOrder_DbPayment_PaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[DbPayment] ([PaymentId])
GO
ALTER TABLE [dbo].[DbOrder] CHECK CONSTRAINT [FK_DbOrder_DbPayment_PaymentId]
GO
ALTER TABLE [dbo].[DbOrder]  WITH CHECK ADD  CONSTRAINT [FK_DbOrder_DbVoucher_IdVoucher] FOREIGN KEY([IdVoucher])
REFERENCES [dbo].[DbVoucher] ([IdVoucher])
GO
ALTER TABLE [dbo].[DbOrder] CHECK CONSTRAINT [FK_DbOrder_DbVoucher_IdVoucher]
GO
ALTER TABLE [dbo].[DbOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_DbOrderDetail_DbOrder_IdDh] FOREIGN KEY([IdDh])
REFERENCES [dbo].[DbOrder] ([IdDh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbOrderDetail] CHECK CONSTRAINT [FK_DbOrderDetail_DbOrder_IdDh]
GO
ALTER TABLE [dbo].[DbOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_DbOrderDetail_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
GO
ALTER TABLE [dbo].[DbOrderDetail] CHECK CONSTRAINT [FK_DbOrderDetail_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbProduct]  WITH CHECK ADD  CONSTRAINT [FK_DbProduct_DbCategory_IdDm] FOREIGN KEY([IdDm])
REFERENCES [dbo].[DbCategory] ([IdDm])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbProduct] CHECK CONSTRAINT [FK_DbProduct_DbCategory_IdDm]
GO
ALTER TABLE [dbo].[DbProduct]  WITH CHECK ADD  CONSTRAINT [FK_DbProduct_DbGroup_NhomId] FOREIGN KEY([NhomId])
REFERENCES [dbo].[DbGroup] ([IdNhom])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbProduct] CHECK CONSTRAINT [FK_DbProduct_DbGroup_NhomId]
GO
ALTER TABLE [dbo].[DbProductDetail]  WITH CHECK ADD  CONSTRAINT [FK_DbProductDetail_DbColor_ColorId] FOREIGN KEY([ColorId])
REFERENCES [dbo].[DbColor] ([ColorId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbProductDetail] CHECK CONSTRAINT [FK_DbProductDetail_DbColor_ColorId]
GO
ALTER TABLE [dbo].[DbProductDetail]  WITH CHECK ADD  CONSTRAINT [FK_DbProductDetail_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbProductDetail] CHECK CONSTRAINT [FK_DbProductDetail_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbProductDetail]  WITH CHECK ADD  CONSTRAINT [FK_DbProductDetail_DbSize_SizeId] FOREIGN KEY([SizeId])
REFERENCES [dbo].[DbSize] ([SizeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbProductDetail] CHECK CONSTRAINT [FK_DbProductDetail_DbSize_SizeId]
GO
ALTER TABLE [dbo].[DbRating]  WITH CHECK ADD  CONSTRAINT [FK_DbRating_DbCustomer_customerIdKh] FOREIGN KEY([customerIdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbRating] CHECK CONSTRAINT [FK_DbRating_DbCustomer_customerIdKh]
GO
ALTER TABLE [dbo].[DbRating]  WITH CHECK ADD  CONSTRAINT [FK_DbRating_DbProduct_IdSp] FOREIGN KEY([IdSp])
REFERENCES [dbo].[DbProduct] ([IdSp])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbRating] CHECK CONSTRAINT [FK_DbRating_DbProduct_IdSp]
GO
ALTER TABLE [dbo].[DbUser_Voucher]  WITH CHECK ADD  CONSTRAINT [FK_DbUser_Voucher_DbCustomer_customerIdKh] FOREIGN KEY([customerIdKh])
REFERENCES [dbo].[DbCustomer] ([IdKh])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbUser_Voucher] CHECK CONSTRAINT [FK_DbUser_Voucher_DbCustomer_customerIdKh]
GO
ALTER TABLE [dbo].[DbUser_Voucher]  WITH CHECK ADD  CONSTRAINT [FK_DbUser_Voucher_DbVoucher_voucherIdVoucher] FOREIGN KEY([voucherIdVoucher])
REFERENCES [dbo].[DbVoucher] ([IdVoucher])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbUser_Voucher] CHECK CONSTRAINT [FK_DbUser_Voucher_DbVoucher_voucherIdVoucher]
GO
/****** Object:  StoredProcedure [dbo].[add_order]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[add_order]
	 @idkh INT,
    @emailkh NVARCHAR(25),
    @nguoinhan NVARCHAR(30),
    @sdt NVARCHAR(15),
    @city NVARCHAR(10),
    @district NVARCHAR(10),
    @ward NVARCHAR(10),
    @diachi NVARCHAR(500),
    @tongtien DECIMAL(18, 2),
    @tongtienthanhtoan DECIMAL(18, 2),
    @soluong INT,
    @payid INT,
    @payname NVARCHAR(50),
    @idvoucher INT = NULL,
    @valuevoucher INT = NULL,
    @giamgia DECIMAL(18, 2) = NULL,
    @ship DECIMAL(18, 2),
    @ghichu NVARCHAR(MAX) = NULL,
	--@createdate datetime,
    @NewIdDH INT OUTPUT, -- Trả về ID đơn hàng mới
	@NewMaDH nvarchar(500) output
	--@odsuccess bit,
	--@oreadly bit,
	--@otransported bit,
	--@ocomplete bit
as
begin
	declare @GeneratedMaDH nvarchar(500)
	begin
		insert into DbOrder(IdKh,EmailKh,NguoiNhan,Sdt,City,District,Ward,DiaChi,TongTien,TongTienThanhToan,soluong,PaymentId,PaymentName,IdVoucher,ValueVoucher,Giamgia,Ship,GhiChu,ODSuccess,ODReadly,ODTransported,Complete,ODHuy,CreateDate)
		values (@idkh,@emailkh,@nguoinhan,@sdt,@city,@district,@ward,@diachi,@tongtien,@tongtienthanhtoan,@soluong,@payid,@payname,@idvoucher,@valuevoucher,@giamgia,@ship,@ghichu,1,0,0,0,0,GETDATE());
		set @NewIdDH = SCOPE_IDENTITY();
		set @GeneratedMaDH = CONCAT('DH',FORMAT(@NewIdDH,''));
		set @NewMaDH = @GeneratedMaDH;
		update DbOrder
			set MaDh=@GeneratedMaDH where IdDh=@NewIdDH;
	end
end;
GO
/****** Object:  StoredProcedure [dbo].[add_orderdetail]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[add_orderdetail]
	@iddh int,
	@madh nvarchar(500),
	@idsp int,
	@masp nvarchar(10),
	@colorid int,
	@sizeid int,
	@priceby decimal,
	@soluongsp int
as
begin
	insert into DbOrderDetail(IdDh,MaDh,IdSp,MaSp,IdColor,IdSize,PriceBy,SoLuongSp,CreateDate)
	values(@iddh,@madh,@idsp,@masp,@colorid,@sizeid,@priceby,@soluongsp,GETDATE())
end;
GO
/****** Object:  StoredProcedure [dbo].[adress_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[adress_showall]
	@idkh int
as
begin
	select * from DbAddress
	where IdKh=@idkh
end;
GO
/****** Object:  StoredProcedure [dbo].[cart_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[cart_showall]
	@idkh int
as
begin	
	select cr.IdSp,p.MaSp,p.TenSp,p.AnhSp,dt.ColorId,dt.NameColor,dt.SizeId,dt.NameSize,dt.GiaLoai,cr.ProductQuantity,cr.ProductQuantity * dt.GiaLoai as Total
	from DbCart cr 
	join DbProduct p on cr.IdSp=p.IdSp
	join DbProductDetail dt on cr.IdSp=dt.IdSp and cr.ColorId=dt.ColorId and cr.SizeId=dt.SizeId
	where p.IActive = 1 and cr.IdKh=@idkh
	order by cr.CreateDate desc
end;
GO
/****** Object:  StoredProcedure [dbo].[category_delete]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[category_delete]
	@iddm int,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		delete DbCategory where IdDm=@iddm;
		set @msg = N'Xóa danh mục thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[category_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[category_insert]
	@tendm nvarchar(10),
	@anhdaidien nvarchar(250),
	@createby nvarchar(25),

	@newiddm int output,
	@newmadm nvarchar(10) output,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	declare @GeneratedMaDm nvarchar(10)
	begin try
		--tạo mới
		insert into DbCategory (TenDm,AnhDaiDien,CreateBy,CreateDate) 
		values (@tendm,@anhdaidien,@createby,GETDATE())

		set @newiddm=SCOPE_IDENTITY();
		set @GeneratedMaDm= CONCAT('DM',FORMAT(@newiddm,''));
		set @newmadm=@GeneratedMaDm;
		--cập nhật lại mã dm
		update DbCategory set MaDm=@newmadm where IdDm=@newiddm

		set @msg = N'Danh mục đã được thêm thành công.';
	end try
	begin catch
		set @error =ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[category_search]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[category_search]
	@keyword nvarchar(50)
as
begin
	select c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,count(p.IdSp)as Products, c.CreateDate, c.ModifiedDate,c.CreateBy
	from DbCategory c
	left join DbProduct p on c.IdDm=p.IdDm
	where c.MaDm like '%'+@keyword+'%' or c.TenDm like '%'+@keyword+'%'
	group by c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,c.CreateDate,c.ModifiedDate,c.CreateBy	
end;
GO
/****** Object:  StoredProcedure [dbo].[category_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[category_showall]
as
begin
	select c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,count(p.IdSp)as Products, c.CreateDate, c.ModifiedDate,c.CreateBy
	from DbCategory c
	left join DbProduct p on c.IdDm=p.IdDm
	group by c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,c.CreateDate,c.ModifiedDate,c.CreateBy
	order by c.IdDm desc
end;
GO
/****** Object:  StoredProcedure [dbo].[category_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[category_update]
	@iddm int,
	@tendm nvarchar(10),
	@anhdaidien nvarchar(250),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbCategory set TenDm=@tendm,AnhDaiDien=@anhdaidien,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
		where IdDm=@iddm;
		set @msg = N'Sửa danh mục thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[color_delete]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[color_delete]
	@idcl int,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		delete DbColor where ColorId=@idcl;
		set @msg = N'Xóa màu thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[color_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[color_insert]
	@namecl nvarchar(50),
	@mahex nvarchar(20),
	@img nvarchar(250),
	@createby nvarchar(25),

	@newidcl int output,
	@newmacl nvarchar(10) output,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	declare @GeneratedMaCl nvarchar(10)
	begin try
		--tạo mới
		insert into DbColor(NameColor,MaHex,Img,CreateBy,CreateDate) 
		values (@namecl,@mahex,@img,@createby,GETDATE())

		set @newidcl=SCOPE_IDENTITY();
		set @GeneratedMaCl= CONCAT('CL',FORMAT(@newidcl,''));
		set @newmacl=@GeneratedMaCl;
		--cập nhật lại mã cl
		update DbColor set MaColor=@newmacl where ColorId=@newidcl

		set @msg = N'Màu đã được thêm thành công.';
	end try
	begin catch
		set @error =ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[color_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[color_update]
	@idcl int,
	@namecl nvarchar(50),
	@mahex nvarchar(20),
	@img nvarchar(250),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbColor set NameColor=@namecl,MaHex=@mahex,Img=@img,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
		where ColorId=@idcl;
		set @msg = N'Sửa màu thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[compare_product_in_cart]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[compare_product_in_cart]
	@idsp int,
	@idkh int,
	@colorid int,
	@sizeid int
as
begin
	select cr.IdSp,p.MaSp,p.TenSp,p.AnhSp,cr.ColorId,pd.NameColor,cr.SizeId,pd.NameSize,pd.GiaLoai,cr.ProductQuantity,cr.ProductQuantity * pd.GiaLoai as Total
	from DbCart cr
	join DbProduct p on p.Idsp=cr.IdSp
	join DbProductDetail pd on cr.IdSp=pd.IdSp and cr.ColorId=@colorid and cr.SizeId=@sizeid
	where cr.IdSp=@idsp and cr.IdKh=@idkh and cr.ColorId=@colorid and cr.SizeId=@sizeid
end;
GO
/****** Object:  StoredProcedure [dbo].[create_customer_adress]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[create_customer_adress]
	@idkh int,
	@tennguoinhan nvarchar(25),
	@sdt nvarchar(15),
	@adress nvarchar(500),
	@city nvarchar(25),
	@quanhuyen nvarchar(25),
	@phuongxa nvarchar(25),
	@ghichu nvarchar(max),
	@idefault bit,
	@msg nvarchar(500) out,
	@error nvarchar(500) out
as
begin
	begin try
		insert into DbAddress (IdKh,TenNguoiNhan,Sdt,Address,City,QuanHuyen,PhuongXa,GhiChu,Idefault)
		values(@idkh,@tennguoinhan,@sdt,@adress,@city,@quanhuyen,@phuongxa,@ghichu,@idefault)

		set @msg=N'Tạo địa chỉ thành công';
	end try
	begin catch
		set @error=N'Lỗi - Tạo địa chỉ không thành công'+ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[create_favorite_product]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[create_favorite_product]
	@idsp int,
	@idkh int
as
begin
	insert into DbFavoriteProduct (IdSp,IdKh) values (@idsp,@idkh)
end;
GO
/****** Object:  StoredProcedure [dbo].[create_user]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[create_user]
	@tenkh nvarchar(25),
	@sdt nvarchar(15),
	@email nvarchar(50),
	@pass nvarchar(25),
	@confirmpass nvarchar(25),
	@IsExternalAccount bit,
	@newidkh int output,
	@newmakh nvarchar(10) OUTPUT,
    @msg NVARCHAR(500) OUTPUT,
    @error NVARCHAR(500) OUTPUT
as
begin 
	declare @GeneratedMaKH nvarchar(10);
	begin try
		IF EXISTS (SELECT 1 FROM DbCustomer WHERE Sdt = @sdt)
        BEGIN
            SET @error = N'Số điện thoại này đã được sử dụng!';
            RETURN;
        END
		if Exists(select 1 from DbCustomer where Email=@email)		
			begin
				set @error=N'Email này đã được sử dụng!';
				return;
			end;
		insert into DbCustomer (TenKh,Sdt,Email,Passwords,ConfirmPasswords,IsExternalAccount,CreateDate)
		values (@tenkh,@sdt,@email,@pass,@confirmpass,@IsExternalAccount,GETDATE())

		set @newidkh= SCOPE_IDENTITY();
		set @GeneratedMaKH=CONCAT('KH',FORMAT(@newidkh,''));
		set @newmakh=@GeneratedMaKH;
		set @msg=N'Tạo tài khoản thành công bạn có thể đăng nhập !';

		update DbCustomer set MaKh=@newmakh where IdKh=@newidkh
	end try
	begin catch
		set @error=N'Lỗi không tạo được tài khoản'+ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[customer_order_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[customer_order_showall]
	@idkh int
as
begin
	select od.IdDh,od.MaDh,od.PaymentName,od.soluong,od.TongTienThanhToan
		,STRING_AGG(CONCAT(p.AnhSp,'"',p.TenSp,'"',cl.NameColor,'"',sz.NameSize,'"',odd.PriceBy,'"',odd.SoLuongSp),';')as InforSP
		,od.CreateDate,
		CAST(od.ODSuccess AS BIT) AS ODSuccess, 
		CAST(od.ODReadly AS BIT) AS ODReadly,
		CAST(od.ODTransported AS BIT) AS ODTransported,
		CAST(od.Complete AS BIT) AS Complete,
		CAST(od.ODHuy AS BIT) AS ODHuy
	from DbOrder od
	join DbOrderDetail odd on odd.IdDh=od.IdDh
	join DbProduct p on odd.IdSp=p.IdSp
	join DbColor cl on cl.ColorId= odd.IdColor
	join DbSize sz on odd.IdSize=sz.SizeId
	where od.IdKh=@idkh
	group by od.IdDh,od.MaDh,od.PaymentName,od.soluong,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	order by od.CreateDate desc
end;
GO
/****** Object:  StoredProcedure [dbo].[delete_product_in_cart]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delete_product_in_cart]
	@idsp int,
	@idkh int,
	@colorid int,
	@sizeid int
as
begin
	delete from DbCart where IdSp=@idsp and IdKh=@idkh and ColorId=@colorid and SizeId=@sizeid
end;

GO
/****** Object:  StoredProcedure [dbo].[favorite_product_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[favorite_product_showall]
	@idkh int
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	join DbFavoriteProduct fvrp on p.IdSp=fvrp.IdSp where p.IActive=1 and fvrp.IdKh=@idkh
end;
GO
/****** Object:  StoredProcedure [dbo].[img_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[img_insert]
	@idsp int,
	@img nvarchar(250),
	@error nvarchar(500) out
as 
begin
	begin try
		insert into DbImg (IdSp,Img) values (@idsp,@img)
	end try
	begin catch
		set @error=N'lỗi không thêm các chi tiết ảnh vào bảng DbImg'+ ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[img_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[img_update]
	@idsp int,
	@img nvarchar(500)
as
begin
	update DbImg set Img=@img where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[order_search]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[order_search]
	@keyword nvarchar(50)
as
begin
	select od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where od.MaDh like '%'+@keyword+'%' or cus.TenKh like '%'+@keyword+'%' or od.NguoiNhan like '%'+@keyword+'%'
	order by od.CreateDate desc
end;
GO
/****** Object:  StoredProcedure [dbo].[order_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[order_showall]
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	order by od.CreateDate desc
end;
GO
/****** Object:  StoredProcedure [dbo].[orderupdate]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[orderupdate]
	@iddh int,
	@odsuccess bit,
	@odreadly bit,
	@odtransported bit,
	@complete bit,
	@odhuy bit,	
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try	
		update DbOrder set ODSuccess=@odsuccess,ODReadly=@odreadly,ODTransported=@odtransported,Complete=@complete,ODHuy=@odhuy
		where IdDh=@iddh

		set @msg=N'Cập nhật đơn hàng thành công';
	end try
	begin catch
		set @error=N'Cập nhật đơn hàng thất bại'+ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[product_by_iddm]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_by_iddm]
	@iddm int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = @iddm
end;
GO
/****** Object:  StoredProcedure [dbo].[product_detail]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_detail]
	@idsp int
as
begin
	select p.IdSp, p.MaSp,ct.TenDm,p.TenSp,p.SaoDanhGia,p.AnhSp,p.PriceMax,p.GiamGia,p.PriceMin,p.LuotXem,p.LuotSold,p.MotaSp,p.Ifavorite,
		(select string_agg(i.Img,';')
		from DbImg i
		where i.IdSp=p.IdSp)as ImgDetail,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize,',',pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex,',',pd.GiaLoai,',',pd.Quantity),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp=p.IdSp)as Detail
	from DbProduct p
	join DbCategory ct on p.IdDm=ct.IdDm
	where p.IActive = 1 and p.IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[product_find]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_find]
	@idsp int
as
begin
	select * from DbProduct where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[product_hot_view]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_hot_view]
as
begin
	select top 10 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IHot =1
end;
GO
/****** Object:  StoredProcedure [dbo].[product_img_find]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_img_find]
	@idsp int
as
begin
	select * from DbImg where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[product_in_cart]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_in_cart]
	@idsp int,
	@idkh int,
	@quantity int,
	@colorid int,
	@sizeid int
as
begin
	begin try
		declare @SoluongTon int;
		declare @ExistProduct int;
		--kiểm tra số lượng trong kho
			select @SoluongTon=dt.Quantity from DbProductDetail dt where dt.IdSp=@idsp and dt.ColorId=@colorid and dt.SizeId=@sizeid;
			if @quantity > @SoluongTon
			begin
				RAISERROR('Số lượng sản phẩm yêu cầu vượt quá số lượng có trong kho.', 16, 1);
				RETURN;
			end 
			select @ExistProduct = cr.Id from DbCart cr where cr.IdKh=@idkh and cr.IdSp=@idsp and cr.ColorId=@colorid and cr.SizeId=@sizeid;
			if @ExistProduct is not null
				begin
					--cập nhật số lượng sp đã có vào giỏ hàng
					update DbCart set ProductQuantity =ProductQuantity+@quantity where Id=@ExistProduct;
				end
			else
				begin
					--thêm mới sp vào giỏ hàng
					insert into DbCart(IdSp,IdKh,ProductQuantity,ColorId,SizeId,CreateDate) values(@idsp,@idkh,@quantity,@colorid,@sizeid,GETDATE());
				end
			--msg	
		SELECT 'Thêm sản phẩm vào giỏ hàng thành công.' AS Message;
	end try
	begin catch
		SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[product_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_insert]
	@iddm int,
	@tensp nvarchar(100),
	@nhomid int,
	@anhsp nvarchar(500),
	@pricemax decimal,
	@giamgia int,
	@pricemin decimal,
	@motasp nvarchar(Max),
	@iactive bit,
	@ifeature bit,
	@ifavorite bit,
	@ihot bit,
	@isale bit,
	@createby nvarchar(25),
	@newidsp int out,
	@newmasp nvarchar(10) out,
	@error nvarchar(500) out
as
begin
	declare @GeneratedMaSp nvarchar(8);
	begin try
		insert into DbProduct (IdDm,TenSp,NhomId,AnhSp,PriceMax,GiamGia,PriceMin,MotaSp,IActive,IFeature,IFavorite,IHot,ISale,CreateBy,CreateDate) 
		values (@iddm,@tensp,@nhomid,@anhsp,@pricemax,@giamgia,@pricemin,@motasp,@iactive,@ifeature,@ihot,@isale,@ifavorite,@createby,GETDATE())

		set @newidsp=SCOPE_IDENTITY();
		set @GeneratedMaSp= CONCAT('SP',FORMAT(@newidsp,''));
		set @newmasp = @GeneratedMaSp;
			
		update DbProduct set MaSp=@newmasp where IdSp=@newidsp;
	end try
	begin catch
		set @error=N'Lỗi thêm các thông tin vào bảng DbProduct'+ ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[product_new_view]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_new_view]
as
begin
	select top 10 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.CreateDate <= DATEADD(DAY,50,GETDATE())
end;
GO
/****** Object:  StoredProcedure [dbo].[product_productdetail_find]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_productdetail_find]
	@idsp int
as
begin
	select cl.NameColor,cl.MaHex,sz.NameSize,pd.GiaLoai,pd.Quantity,pd.SoLuongBan
	from DbProductDetail pd
	join DbColor cl on pd.ColorId=cl.ColorId
	join DbSize sz on pd.SizeId=sz.SizeId
	where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[product_ql_view]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_ql_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = 2006
end;
GO
/****** Object:  StoredProcedure [dbo].[product_sale_view]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_sale_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.ISale =1
end;
GO
/****** Object:  StoredProcedure [dbo].[product_search]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_search]
	@keyword nvarchar(50)
as
begin
	select p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,SUM(pd.SoLuongBan) as LuotSold,SUM(pd.Quantity) as Quantity,
			p.IActive,p.IHot,p.ISale,p.IFeature
	from DbProduct p
	join DbCategory c on p.IdDm=c.IdDm
	join DbGroup g on p.NhomId=g.IdNhom
	join DbProductDetail pd on p.IdSp=pd.IdSp
	where p.MaSp like '%'+@keyword+'%' or p.TenSp like '%'+@keyword+'%' or c.TenDm like '%'+@keyword+'%' 
	group by p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,p.LuotSold,
			p.IActive,p.IHot,p.ISale,p.IFeature
	order by p.IdSp desc
end;
GO
/****** Object:  StoredProcedure [dbo].[product_showall]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_showall]
as
begin
	select p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,SUM(pd.SoLuongBan) as LuotSold,SUM(pd.Quantity) as Quantity,
			p.IActive,p.IHot,p.ISale,p.IFeature
	from DbProduct p
	join DbCategory c on p.IdDm=c.IdDm
	join DbGroup g on p.NhomId=g.IdNhom
	join DbProductDetail pd on p.IdSp=pd.IdSp
	group by p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,p.LuotSold,
			p.IActive,p.IHot,p.ISale,p.IFeature
	order by p.IdSp desc
end;
GO
/****** Object:  StoredProcedure [dbo].[product_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_update]
	@idsp int,
	@iddm int,
	@tensp nvarchar(100),
	@nhomid int,
	@anhsp nvarchar(500),
	@pricemax decimal,
	@giamgia int,
	@pricemin decimal,
	@motasp nvarchar(Max),
	@iactive bit,
	@ifeature bit,
	@ifavorite bit,
	@ihot bit,
	@isale bit,
	@modifiedby nvarchar(25)
as
begin
	update DbProduct set IdDm=@iddm,TenSp=@tensp,NhomId=@nhomid,AnhSp=@anhsp,PriceMax=@pricemax,GiamGia=@giamgia,PriceMin=@pricemin,
						MotaSp=@motasp,IActive=@iactive,IFeature=@ifeature,IFavorite=@ifavorite,IHot=@ihot,ISale=@isale,ModifiedBy=@modifiedby,ModifiedDate=GETDATE()
	where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[product_view]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[product_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1
end;
GO
/****** Object:  StoredProcedure [dbo].[productdetail_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[productdetail_insert]
	@idsp int,
	@colorid int,
	@namecolor nvarchar(50),
	@sizeid int,
	@namesize nvarchar(50),
	@gialoai decimal,
	@soluong int,
	@error nvarchar(500) out
as 
begin
	begin try
		insert into DbProductDetail (IdSp,ColorId,NameColor,SizeId,NameSize,GiaLoai,Quantity,SoLuongBan)
		values (@idsp,@colorid,@namecolor,@sizeid,@namesize,@gialoai,@soluong,0)
	end try
	begin catch
		set @error=N'lỗi không thêm đc các thông tin chi tiết ảnh vào bảng DbProductDetail'+ ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[productdetail_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[productdetail_update]
	@idsp int,
	@colorid int,
	@namecolor nvarchar(50),
	@sizeid int,
	@namesize nvarchar(50),
	@gialoai decimal,
	@soluong int
as
begin
	update DbProductDetail set ColorId=@colorid,NameColor=@namecolor,SizeId=@sizeid,NameSize=@namesize,GiaLoai=@gialoai,Quantity=@soluong
	where IdSp=@idsp
end;
GO
/****** Object:  StoredProcedure [dbo].[show_orderdetail]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[show_orderdetail]
	@iddh int
as
begin
	select od.MaDh,
			(select string_agg(concat(odd.MaSp,'"',p.TenSp,'"',p.AnhSp,'"',cl.NameColor,'"',sz.NameSize,'"',odd.SoLuongSp,'"',pd.GiaLoai),';')  
			from DbOrderDetail odd
			 join DbProduct p on odd.IdSp=p.IdSp
			 join DbColor cl on cl.ColorId= odd.IdColor
			 join DbSize sz on odd.IdSize=sz.SizeId
			 join DbProductDetail pd  on p.IdSp=pd.IdSp and odd.IdColor=pd.ColorId and odd.IdSize= pd.SizeId
			where odd.IdDh= od.IdDh) as InForSp,			
			od.IdKh,cus.TenKh,od.NguoiNhan,od.DiaChi,od.GhiChu,
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 where od.IdDh= @iddh
end;
GO
/****** Object:  StoredProcedure [dbo].[size_delete]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[size_delete]
	@idsz int,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		delete DbSize where SizeId=@idsz;
		set @msg = N'Xóa size thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[size_insert]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[size_insert]
	@namesz nvarchar(5),
	@masz nvarchar(5),
	@createby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	declare @GeneratedMaCl nvarchar(10)
	begin try
		--tạo mới
		insert into DbSize(NameSize,MaSize,CreateBy,CreateDate) 
		values (@namesz,@masz,@createby,GETDATE())

		set @msg = N' thêm Size thành công.';
	end try
	begin catch
		set @error =ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[size_update]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[size_update]
	@idsz int,
	@namesz nvarchar(5),
	@masz nvarchar(5),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbSize set NameSize=@namesz,MaSize=@masz,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
		where SizeId=@idsz;
		set @msg = N'Sửa size thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[update_product_in_cart]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[update_product_in_cart]
	@idsp int,
	@idkh int,
	@quantity int,
	@colorid int,
	@sizeid int
as
begin
	begin try
		if @quantity <=0
			begin
				-- Gọi procedure xóa sản phẩm khỏi giỏ hàng
				EXEC [dbo].[delete_product_in_cart] @idsp, @idkh, @colorid, @sizeid
			end
		else
			begin
				update DbCart set ProductQuantity = @quantity where IdKh=@idkh and IdSp=@idsp and ColorId=@colorid and SizeId=@sizeid
			end
	end try
	begin catch
		SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
	end catch
end;
GO
/****** Object:  StoredProcedure [dbo].[update_user]    Script Date: 1/10/2025 4:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[update_user]
	@idkh int,
	@tenkh nvarchar(25),
	@img nvarchar(250),
	@sex nvarchar(5),
	@sdt nvarchar(15),
	@email nvarchar(50),
	@pass nvarchar(25),
	@confirmpass nvarchar(25),
    @msg NVARCHAR(500) OUTPUT,
    @error NVARCHAR(500) OUTPUT
as
begin
	begin try
		IF EXISTS (SELECT 1 FROM DbCustomer WHERE Sdt = @sdt)
			BEGIN
				SET @error = N'Số điện thoại này đã được sử dụng!';
				RETURN;
			END
		begin
			update DbCustomer set MaKh='KH'+CAST(@idkh as nvarchar),TenKh=@tenkh,Img=@img,GioiTinh=@sex,Sdt=@sdt,Email=@email,Passwords=@pass,ConfirmPasswords=@confirmpass
			where IdKh=@idkh
			set @msg=N'Cập nhật thông tin thành công';
		end
	end try
	begin catch
		set @error=N'Cập nhật thông tin không thành công'+ ERROR_MESSAGE();
	end catch
end;
GO
USE [master]
GO
ALTER DATABASE [KLTN] SET  READ_WRITE 
GO
