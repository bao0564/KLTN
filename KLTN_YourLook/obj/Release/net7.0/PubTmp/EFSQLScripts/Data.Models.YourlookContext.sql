IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbAdmin] (
        [Id] int NOT NULL IDENTITY,
        [MaAdmin] nvarchar(5) NOT NULL,
        [EmailDn] nvarchar(15) NOT NULL,
        [NameDn] nvarchar(25) NULL,
        [PasswordDn] nvarchar(10) NOT NULL,
        [ChucVu] nvarchar(10) NOT NULL,
        [Quyen] nvarchar(10) NULL,
        [IsExternalAccount] bit NOT NULL,
        CONSTRAINT [PK_DbAdmin] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbAds] (
        [Id] int NOT NULL IDENTITY,
        [MaAds] nvarchar(10) NOT NULL,
        [Img] nvarchar(250) NULL,
        [Place] nvarchar(10) NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_DbAds] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbCategory] (
        [IdDm] int NOT NULL IDENTITY,
        [MaDm] nvarchar(10) NOT NULL,
        [TenDm] nvarchar(10) NOT NULL,
        [AnhDaiDien] nvarchar(250) NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbCategory] PRIMARY KEY ([IdDm])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbColor] (
        [ColorId] int NOT NULL IDENTITY,
        [MaColor] nvarchar(10) NOT NULL,
        [NameColor] nvarchar(50) NOT NULL,
        [Img] nvarchar(250) NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbColor] PRIMARY KEY ([ColorId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbCustomer] (
        [IdKh] int NOT NULL IDENTITY,
        [MaKh] nvarchar(20) NOT NULL,
        [TenKh] nvarchar(25) NOT NULL,
        [Img] nvarchar(250) NULL,
        [GioiTinh] nvarchar(5) NULL,
        [Sdt] nvarchar(15) NULL,
        [Email] nvarchar(20) NOT NULL,
        [Passwords] nvarchar(25) NOT NULL,
        [ConfirmPasswords] nvarchar(25) NULL,
        [IsExternalAccount] bit NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbCustomer] PRIMARY KEY ([IdKh])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbGroup] (
        [IdNhom] int NOT NULL IDENTITY,
        [MaNhom] nvarchar(10) NOT NULL,
        [GroupName] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_DbGroup] PRIMARY KEY ([IdNhom])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbInforShop] (
        [Id] int NOT NULL IDENTITY,
        [Sdt] nvarchar(15) NULL,
        [Email] nvarchar(25) NULL,
        [Addres] nvarchar(250) NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbInforShop] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbPayment] (
        [PaymentId] int NOT NULL IDENTITY,
        [PaymentName] nvarchar(50) NOT NULL,
        [Icon] nvarchar(250) NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbPayment] PRIMARY KEY ([PaymentId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbSize] (
        [SizeId] int NOT NULL IDENTITY,
        [MaSize] nvarchar(5) NOT NULL,
        [NameSize] nvarchar(5) NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbSize] PRIMARY KEY ([SizeId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbVoucher] (
        [IdVoucher] int NOT NULL IDENTITY,
        [MaVoucher] nvarchar(25) NOT NULL,
        [IconVoucher] nvarchar(250) NOT NULL,
        [valueVoucher] int NOT NULL,
        [valueMax] int NULL,
        [MotaVoucher] nvarchar(500) NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbVoucher] PRIMARY KEY ([IdVoucher])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbAddress] (
        [IdAddress] int NOT NULL IDENTITY,
        [IdKh] int NOT NULL,
        [TenNguoiNhan] nvarchar(25) NOT NULL,
        [Sdt] nvarchar(15) NOT NULL,
        [Address] nvarchar(500) NOT NULL,
        [City] nvarchar(10) NOT NULL,
        [QuanHuyen] nvarchar(10) NOT NULL,
        [PhuongXa] nvarchar(10) NOT NULL,
        [GhiChu] nvarchar(max) NULL,
        [Idefault] bit NOT NULL,
        CONSTRAINT [PK_DbAddress] PRIMARY KEY ([IdAddress]),
        CONSTRAINT [FK_DbAddress_DbCustomer_IdKh] FOREIGN KEY ([IdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbProduct] (
        [IdSp] int NOT NULL IDENTITY,
        [MaSp] nvarchar(10) NOT NULL,
        [IdDm] int NOT NULL,
        [TenSp] nvarchar(100) NOT NULL,
        [SaoDanhGia] int NULL,
        [NhomId] int NOT NULL,
        [AnhSp] nvarchar(250) NULL,
        [PriceMax] decimal(18,2) NOT NULL,
        [GiamGia] int NULL,
        [PriceMin] decimal(18,2) NULL,
        [LuotXem] int NULL,
        [LuotSold] int NULL,
        [MotaSp] nvarchar(max) NOT NULL,
        [IActive] bit NOT NULL,
        [IFavorite] bit NOT NULL,
        [IFeature] bit NOT NULL,
        [IHot] bit NOT NULL,
        [ISale] bit NOT NULL,
        [categoryIdDm] int NULL,
        [groupIdNhom] int NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbProduct] PRIMARY KEY ([IdSp]),
        CONSTRAINT [FK_DbProduct_DbCategory_categoryIdDm] FOREIGN KEY ([categoryIdDm]) REFERENCES [DbCategory] ([IdDm]),
        CONSTRAINT [FK_DbProduct_DbGroup_groupIdNhom] FOREIGN KEY ([groupIdNhom]) REFERENCES [DbGroup] ([IdNhom])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbOrder] (
        [IdDh] int NOT NULL IDENTITY,
        [MaDh] nvarchar(500) NULL,
        [IdKh] int NOT NULL,
        [NguoiNhan] nvarchar(30) NOT NULL,
        [EmailKh] nvarchar(25) NOT NULL,
        [Sdt] nvarchar(15) NOT NULL,
        [City] nvarchar(10) NOT NULL,
        [District] nvarchar(10) NOT NULL,
        [Ward] nvarchar(10) NOT NULL,
        [DiaChi] nvarchar(500) NOT NULL,
        [TongTien] decimal(18,2) NOT NULL,
        [TongTienThanhToan] decimal(18,2) NOT NULL,
        [soluong] int NOT NULL,
        [PaymentId] int NOT NULL,
        [PaymentName] nvarchar(10) NOT NULL,
        [IdVoucher] int NULL,
        [ValueVoucher] int NULL,
        [Giamgia] decimal(18,2) NULL,
        [Ship] decimal(18,2) NOT NULL,
        [GhiChu] nvarchar(max) NULL,
        [ODSuccess] bit NULL,
        [ODReadly] bit NULL,
        [ODTransported] bit NULL,
        [Complete] bit NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbOrder] PRIMARY KEY ([IdDh]),
        CONSTRAINT [FK_DbOrder_DbCustomer_IdKh] FOREIGN KEY ([IdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE NO ACTION,
        CONSTRAINT [FK_DbOrder_DbPayment_PaymentId] FOREIGN KEY ([PaymentId]) REFERENCES [DbPayment] ([PaymentId]) ON DELETE NO ACTION,
        CONSTRAINT [FK_DbOrder_DbVoucher_IdVoucher] FOREIGN KEY ([IdVoucher]) REFERENCES [DbVoucher] ([IdVoucher]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbUser_Voucher] (
        [Id] int NOT NULL IDENTITY,
        [IdKh] int NOT NULL,
        [IdVoucher] int NOT NULL,
        [UsedDate] datetime2 NOT NULL,
        [customerIdKh] int NOT NULL,
        [voucherIdVoucher] int NOT NULL,
        CONSTRAINT [PK_DbUser_Voucher] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DbUser_Voucher_DbCustomer_customerIdKh] FOREIGN KEY ([customerIdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbUser_Voucher_DbVoucher_voucherIdVoucher] FOREIGN KEY ([voucherIdVoucher]) REFERENCES [DbVoucher] ([IdVoucher]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbCart] (
        [Id] int NOT NULL IDENTITY,
        [IdSp] int NOT NULL,
        [IdKh] int NOT NULL,
        [ProductQuantity] int NOT NULL,
        [ColorId] int NOT NULL,
        [SizeId] int NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbCart] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DbCart_DbColor_ColorId] FOREIGN KEY ([ColorId]) REFERENCES [DbColor] ([ColorId]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbCart_DbCustomer_IdKh] FOREIGN KEY ([IdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbCart_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbCart_DbSize_SizeId] FOREIGN KEY ([SizeId]) REFERENCES [DbSize] ([SizeId]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbFavoriteProduct] (
        [id] int NOT NULL IDENTITY,
        [IdSp] int NOT NULL,
        [IdKh] int NOT NULL,
        [productIdSp] int NOT NULL,
        [customerIdKh] int NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbFavoriteProduct] PRIMARY KEY ([id]),
        CONSTRAINT [FK_DbFavoriteProduct_DbCustomer_customerIdKh] FOREIGN KEY ([customerIdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbFavoriteProduct_DbProduct_productIdSp] FOREIGN KEY ([productIdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbImg] (
        [Id] int NOT NULL IDENTITY,
        [IdSp] int NOT NULL,
        [Img] nvarchar(250) NULL,
        [Place] nvarchar(10) NULL,
        CONSTRAINT [PK_DbImg] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DbImg_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbProductDetail] (
        [IdCTSP] int NOT NULL IDENTITY,
        [IdSp] int NOT NULL,
        [SizeId] int NOT NULL,
        [NameSize] nvarchar(50) NOT NULL,
        [ColorId] int NOT NULL,
        [NameColor] nvarchar(50) NOT NULL,
        [SoLuongBan] int NULL,
        [GiaLoai] decimal(18,2) NULL,
        [Quantity] int NOT NULL,
        CONSTRAINT [PK_DbProductDetail] PRIMARY KEY ([IdCTSP]),
        CONSTRAINT [FK_DbProductDetail_DbColor_ColorId] FOREIGN KEY ([ColorId]) REFERENCES [DbColor] ([ColorId]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbProductDetail_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbProductDetail_DbSize_SizeId] FOREIGN KEY ([SizeId]) REFERENCES [DbSize] ([SizeId]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE TABLE [DbOrderDetail] (
        [IdCTDH] int NOT NULL IDENTITY,
        [IdDh] int NOT NULL,
        [MaDh] nvarchar(500) NOT NULL,
        [IdSp] int NOT NULL,
        [MaSp] nvarchar(10) NOT NULL,
        [IdColor] int NOT NULL,
        [IdSize] int NOT NULL,
        [SoLuongSp] int NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbOrderDetail] PRIMARY KEY ([IdCTDH]),
        CONSTRAINT [FK_DbOrderDetail_DbOrder_IdDh] FOREIGN KEY ([IdDh]) REFERENCES [DbOrder] ([IdDh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbOrderDetail_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbAddress_IdKh] ON [DbAddress] ([IdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbCart_ColorId] ON [DbCart] ([ColorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbCart_IdKh] ON [DbCart] ([IdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbCart_IdSp] ON [DbCart] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbCart_SizeId] ON [DbCart] ([SizeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbFavoriteProduct_customerIdKh] ON [DbFavoriteProduct] ([customerIdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbFavoriteProduct_productIdSp] ON [DbFavoriteProduct] ([productIdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbImg_IdSp] ON [DbImg] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbOrder_IdKh] ON [DbOrder] ([IdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbOrder_IdVoucher] ON [DbOrder] ([IdVoucher]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbOrder_PaymentId] ON [DbOrder] ([PaymentId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbOrderDetail_IdDh] ON [DbOrderDetail] ([IdDh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbOrderDetail_IdSp] ON [DbOrderDetail] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbProduct_categoryIdDm] ON [DbProduct] ([categoryIdDm]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbProduct_groupIdNhom] ON [DbProduct] ([groupIdNhom]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbProductDetail_ColorId] ON [DbProductDetail] ([ColorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbProductDetail_IdSp] ON [DbProductDetail] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbProductDetail_SizeId] ON [DbProductDetail] ([SizeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbUser_Voucher_customerIdKh] ON [DbUser_Voucher] ([customerIdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    CREATE INDEX [IX_DbUser_Voucher_voucherIdVoucher] ON [DbUser_Voucher] ([voucherIdVoucher]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241226131825_new-database')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241226131825_new-database', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241227093926_27-12-24')
BEGIN
    ALTER TABLE [DbOrder] ADD [ODHuy] bit NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241227093926_27-12-24')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241227093926_27-12-24', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    ALTER TABLE [DbProduct] DROP CONSTRAINT [FK_DbProduct_DbCategory_categoryIdDm];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    ALTER TABLE [DbProduct] DROP CONSTRAINT [FK_DbProduct_DbGroup_groupIdNhom];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DROP INDEX [IX_DbProduct_categoryIdDm] ON [DbProduct];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DROP INDEX [IX_DbProduct_groupIdNhom] ON [DbProduct];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbProduct]') AND [c].[name] = N'categoryIdDm');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [DbProduct] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [DbProduct] DROP COLUMN [categoryIdDm];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbProduct]') AND [c].[name] = N'groupIdNhom');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [DbProduct] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [DbProduct] DROP COLUMN [groupIdNhom];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbProduct]') AND [c].[name] = N'MaSp');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [DbProduct] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [DbProduct] ALTER COLUMN [MaSp] nvarchar(10) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbColor]') AND [c].[name] = N'MaColor');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [DbColor] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [DbColor] ALTER COLUMN [MaColor] nvarchar(10) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    ALTER TABLE [DbColor] ADD [MaHex] nvarchar(20) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbCategory]') AND [c].[name] = N'MaDm');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [DbCategory] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [DbCategory] ALTER COLUMN [MaDm] nvarchar(10) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    CREATE INDEX [IX_DbProduct_IdDm] ON [DbProduct] ([IdDm]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    CREATE INDEX [IX_DbProduct_NhomId] ON [DbProduct] ([NhomId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    ALTER TABLE [DbProduct] ADD CONSTRAINT [FK_DbProduct_DbCategory_IdDm] FOREIGN KEY ([IdDm]) REFERENCES [DbCategory] ([IdDm]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    ALTER TABLE [DbProduct] ADD CONSTRAINT [FK_DbProduct_DbGroup_NhomId] FOREIGN KEY ([NhomId]) REFERENCES [DbGroup] ([IdNhom]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241228092040_28-12-24')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241228092040_28-12-24', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241230125355_30-12-24')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbCustomer]') AND [c].[name] = N'MaKh');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [DbCustomer] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [DbCustomer] ALTER COLUMN [MaKh] nvarchar(20) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241230125355_30-12-24')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbCustomer]') AND [c].[name] = N'Email');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [DbCustomer] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [DbCustomer] ALTER COLUMN [Email] nvarchar(50) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20241230125355_30-12-24')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241230125355_30-12-24', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    ALTER TABLE [DbFavoriteProduct] DROP CONSTRAINT [FK_DbFavoriteProduct_DbCustomer_customerIdKh];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    ALTER TABLE [DbFavoriteProduct] DROP CONSTRAINT [FK_DbFavoriteProduct_DbProduct_productIdSp];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    DROP INDEX [IX_DbFavoriteProduct_customerIdKh] ON [DbFavoriteProduct];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    DROP INDEX [IX_DbFavoriteProduct_productIdSp] ON [DbFavoriteProduct];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbFavoriteProduct]') AND [c].[name] = N'customerIdKh');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [DbFavoriteProduct] DROP CONSTRAINT [' + @var7 + '];');
    ALTER TABLE [DbFavoriteProduct] DROP COLUMN [customerIdKh];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbFavoriteProduct]') AND [c].[name] = N'productIdSp');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [DbFavoriteProduct] DROP CONSTRAINT [' + @var8 + '];');
    ALTER TABLE [DbFavoriteProduct] DROP COLUMN [productIdSp];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbCustomer]') AND [c].[name] = N'Passwords');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [DbCustomer] DROP CONSTRAINT [' + @var9 + '];');
    ALTER TABLE [DbCustomer] ALTER COLUMN [Passwords] nvarchar(25) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    CREATE INDEX [IX_DbFavoriteProduct_IdKh] ON [DbFavoriteProduct] ([IdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    CREATE INDEX [IX_DbFavoriteProduct_IdSp] ON [DbFavoriteProduct] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    ALTER TABLE [DbFavoriteProduct] ADD CONSTRAINT [FK_DbFavoriteProduct_DbCustomer_IdKh] FOREIGN KEY ([IdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    ALTER TABLE [DbFavoriteProduct] ADD CONSTRAINT [FK_DbFavoriteProduct_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250101065431_1-1-25')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250101065431_1-1-25', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbProduct]') AND [c].[name] = N'TenSp');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [DbProduct] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [DbProduct] ALTER COLUMN [TenSp] nvarchar(250) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    ALTER TABLE [DbOrderDetail] ADD [PriceBy] decimal(18,2) NOT NULL DEFAULT 0.0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    ALTER TABLE [DbCustomer] ADD [Birth] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAddress]') AND [c].[name] = N'QuanHuyen');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [DbAddress] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [DbAddress] ALTER COLUMN [QuanHuyen] nvarchar(25) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAddress]') AND [c].[name] = N'PhuongXa');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [DbAddress] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [DbAddress] ALTER COLUMN [PhuongXa] nvarchar(25) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAddress]') AND [c].[name] = N'City');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [DbAddress] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [DbAddress] ALTER COLUMN [City] nvarchar(25) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250103123640_3-1-25')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250103123640_3-1-25', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'PaymentName');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [DbOrder] ALTER COLUMN [PaymentName] nvarchar(50) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var15 sysname;
    SELECT @var15 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'ODTransported');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var15 + '];');
    EXEC(N'UPDATE [DbOrder] SET [ODTransported] = CAST(0 AS bit) WHERE [ODTransported] IS NULL');
    ALTER TABLE [DbOrder] ALTER COLUMN [ODTransported] bit NOT NULL;
    ALTER TABLE [DbOrder] ADD DEFAULT CAST(0 AS bit) FOR [ODTransported];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var16 sysname;
    SELECT @var16 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'ODSuccess');
    IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var16 + '];');
    EXEC(N'UPDATE [DbOrder] SET [ODSuccess] = CAST(0 AS bit) WHERE [ODSuccess] IS NULL');
    ALTER TABLE [DbOrder] ALTER COLUMN [ODSuccess] bit NOT NULL;
    ALTER TABLE [DbOrder] ADD DEFAULT CAST(0 AS bit) FOR [ODSuccess];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var17 sysname;
    SELECT @var17 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'ODReadly');
    IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var17 + '];');
    EXEC(N'UPDATE [DbOrder] SET [ODReadly] = CAST(0 AS bit) WHERE [ODReadly] IS NULL');
    ALTER TABLE [DbOrder] ALTER COLUMN [ODReadly] bit NOT NULL;
    ALTER TABLE [DbOrder] ADD DEFAULT CAST(0 AS bit) FOR [ODReadly];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var18 sysname;
    SELECT @var18 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'ODHuy');
    IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var18 + '];');
    EXEC(N'UPDATE [DbOrder] SET [ODHuy] = CAST(0 AS bit) WHERE [ODHuy] IS NULL');
    ALTER TABLE [DbOrder] ALTER COLUMN [ODHuy] bit NOT NULL;
    ALTER TABLE [DbOrder] ADD DEFAULT CAST(0 AS bit) FOR [ODHuy];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    DECLARE @var19 sysname;
    SELECT @var19 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbOrder]') AND [c].[name] = N'Complete');
    IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [DbOrder] DROP CONSTRAINT [' + @var19 + '];');
    EXEC(N'UPDATE [DbOrder] SET [Complete] = CAST(0 AS bit) WHERE [Complete] IS NULL');
    ALTER TABLE [DbOrder] ALTER COLUMN [Complete] bit NOT NULL;
    ALTER TABLE [DbOrder] ADD DEFAULT CAST(0 AS bit) FOR [Complete];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    CREATE TABLE [DbRating] (
        [Id] int NOT NULL IDENTITY,
        [IdKh] int NOT NULL,
        [IdSp] int NOT NULL,
        [DanhGia] nvarchar(max) NOT NULL,
        [Rate] int NOT NULL,
        [customerIdKh] int NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbRating] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DbRating_DbCustomer_customerIdKh] FOREIGN KEY ([customerIdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE,
        CONSTRAINT [FK_DbRating_DbProduct_IdSp] FOREIGN KEY ([IdSp]) REFERENCES [DbProduct] ([IdSp]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    CREATE INDEX [IX_DbRating_customerIdKh] ON [DbRating] ([customerIdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    CREATE INDEX [IX_DbRating_IdSp] ON [DbRating] ([IdSp]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250110072248_10-1-25')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250110072248_10-1-25', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var20 sysname;
    SELECT @var20 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'IsExternalAccount');
    IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var20 + '];');
    ALTER TABLE [DbAdmin] DROP COLUMN [IsExternalAccount];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var21 sysname;
    SELECT @var21 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'Quyen');
    IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var21 + '];');
    EXEC(N'UPDATE [DbAdmin] SET [Quyen] = N'''' WHERE [Quyen] IS NULL');
    ALTER TABLE [DbAdmin] ALTER COLUMN [Quyen] nvarchar(20) NOT NULL;
    ALTER TABLE [DbAdmin] ADD DEFAULT N'' FOR [Quyen];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var22 sysname;
    SELECT @var22 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'PasswordDn');
    IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var22 + '];');
    ALTER TABLE [DbAdmin] ALTER COLUMN [PasswordDn] nvarchar(20) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var23 sysname;
    SELECT @var23 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'MaAdmin');
    IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var23 + '];');
    ALTER TABLE [DbAdmin] ALTER COLUMN [MaAdmin] nvarchar(15) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var24 sysname;
    SELECT @var24 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'EmailDn');
    IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var24 + '];');
    ALTER TABLE [DbAdmin] ALTER COLUMN [EmailDn] nvarchar(50) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    DECLARE @var25 sysname;
    SELECT @var25 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'ChucVu');
    IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var25 + '];');
    ALTER TABLE [DbAdmin] ALTER COLUMN [ChucVu] nvarchar(20) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113073415_update-dbadmin')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250113073415_update-dbadmin', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113122005_13-1-25')
BEGIN
    DECLARE @var26 sysname;
    SELECT @var26 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'NameDn');
    IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var26 + '];');
    EXEC(N'UPDATE [DbAdmin] SET [NameDn] = N'''' WHERE [NameDn] IS NULL');
    ALTER TABLE [DbAdmin] ALTER COLUMN [NameDn] nvarchar(25) NOT NULL;
    ALTER TABLE [DbAdmin] ADD DEFAULT N'' FOR [NameDn];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113122005_13-1-25')
BEGIN
    DECLARE @var27 sysname;
    SELECT @var27 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbAdmin]') AND [c].[name] = N'MaAdmin');
    IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [DbAdmin] DROP CONSTRAINT [' + @var27 + '];');
    ALTER TABLE [DbAdmin] ALTER COLUMN [MaAdmin] nvarchar(15) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250113122005_13-1-25')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250113122005_13-1-25', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250114151217_14-1-25')
BEGIN
    CREATE TABLE [DbNotification] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(25) NULL,
        [Img] nvarchar(250) NULL,
        [Message] nvarchar(max) NOT NULL,
        [IsRead] bit NOT NULL,
        [CreateDate] datetime2 NOT NULL,
        CONSTRAINT [PK_DbNotification] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250114151217_14-1-25')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250114151217_14-1-25', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    ALTER TABLE [DbRating] DROP CONSTRAINT [FK_DbRating_DbCustomer_customerIdKh];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    DROP INDEX [IX_DbRating_customerIdKh] ON [DbRating];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    EXEC sp_rename N'[DbRating].[customerIdKh]', N'IdDh', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    ALTER TABLE [DbRating] ADD [ColorSize] nvarchar(max) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    CREATE INDEX [IX_DbRating_IdKh] ON [DbRating] ([IdKh]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    ALTER TABLE [DbRating] ADD CONSTRAINT [FK_DbRating_DbCustomer_IdKh] FOREIGN KEY ([IdKh]) REFERENCES [DbCustomer] ([IdKh]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250206152401_6-2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250206152401_6-2', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250216155955_16-2')
BEGIN
    DECLARE @var28 sysname;
    SELECT @var28 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbRating]') AND [c].[name] = N'DanhGia');
    IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [DbRating] DROP CONSTRAINT [' + @var28 + '];');
    ALTER TABLE [DbRating] ALTER COLUMN [DanhGia] nvarchar(500) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250216155955_16-2')
BEGIN
    DECLARE @var29 sysname;
    SELECT @var29 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DbRating]') AND [c].[name] = N'ColorSize');
    IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [DbRating] DROP CONSTRAINT [' + @var29 + '];');
    ALTER TABLE [DbRating] ALTER COLUMN [ColorSize] nvarchar(500) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250216155955_16-2')
BEGIN
    CREATE TABLE [DbHistory] (
        [Id] int NOT NULL IDENTITY,
        [TableName] nvarchar(100) NOT NULL,
        [TableId] int NOT NULL,
        [OldValue] nvarchar(1000) NOT NULL,
        [NewValue] nvarchar(1000) NOT NULL,
        [CreateDate] datetime2 NULL,
        [CreateBy] nvarchar(25) NULL,
        [ModifiedDate] datetime2 NULL,
        [ModifiedBy] nvarchar(25) NULL,
        CONSTRAINT [PK_DbHistory] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250216155955_16-2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250216155955_16-2', N'7.0.20');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250218130526_18-2')
BEGIN
    ALTER TABLE [DbOrder] ADD [ODPrint] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250218130526_18-2')
BEGIN
    ALTER TABLE [DbOrder] ADD [ODReprint] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20250218130526_18-2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250218130526_18-2', N'7.0.20');
END;
GO

COMMIT;
GO

