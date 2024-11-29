use [KLTN];
select * from DbCategory;
/*Hiển thị tất cả thông tin sản phẩm từng sp*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_showall]
as
begin
	select p.IdSp, p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,p.LuotSold ,c.TenDm , g.GroupName ,p.IActive ,p.IHot,p.ISale,p.IFeature
	from DbProduct p
	join DbCategory c on p.IdDm=c.IdDm
	join DbGroup g on p.NhomId=g.IdNhom
	where p.PriceMax > 0
	order by p.CreateDate desc;	
end;
go
/*Thêm mới sản phẩm*/

create procedure [dbo].[product_create]
    @masp NVARCHAR(10),
    @iddm NVARCHAR(10),
    @tensp NVARCHAR(50),
    @saodanhgia INT,
    @nhomid INT,
    @anhsp NVARCHAR(250),
    @pricemax DECIMAL(18,2),
    @giamgia INT,
    @pricemin DECIMAL(18,2),
    @luotxem INT,
    @luotban INT,
    @motasp NVARCHAR(MAX),
    @iactive BIT,
    @ifeature BIT,
    @ihot BIT,
    @isale BIT,
    @createby NVARCHAR(20),
    @createdate DATETIME,
    @Images NVARCHAR(MAX),
    @Details NVARCHAR(MAX) -- JSON chứa thông tin màu, size, giá, số lượng
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Thêm sản phẩm vào bảng DbProduct
        INSERT INTO DbProduct (MaSp, TenSp, IdDm, NhomId, AnhSp, PriceMax, GiamGia, PriceMin, MotaSp, CreateDate, IActive, IFeature, IHot, ISale, CreateBy)
        VALUES (@masp, @tensp, @iddm, @nhomid, @anhsp, @pricemax, @giamgia, @pricemin, @motasp, GETDATE(), @iactive, @ifeature, @ihot, @isale, @createby);
        
        DECLARE @idsp INT = SCOPE_IDENTITY(); -- Lấy IdSp vừa được tạo ra

        -- Xử lý hình ảnh liên quan
        IF (@Images IS NOT NULL)
        BEGIN
            INSERT INTO DbImg (IdSp, Img)
            SELECT @idsp, TRIM(value)
            FROM STRING_SPLIT(@Images, ';')
            WHERE TRIM(value) <> '';
        END

        -- Xử lý JSON chi tiết sản phẩm
        IF (@Details IS NOT NULL)
        BEGIN
            INSERT INTO DbProductDetail (IdSp, ColorId, SizeId, GiaLoai, Quantity)
            SELECT 
                @idsp AS IdSp,
                JSON_VALUE(p.value, '$.ColorId') AS ColorId,
                JSON_VALUE(p.value, '$.SizeId') AS SizeId,
                JSON_VALUE(p.value, '$.GiaLoai') AS GiaLoai,
                JSON_VALUE(p.value, '$.Quantity') AS Quantity
            FROM OPENJSON(@Details) AS p;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Ghi log lỗi hoặc trả về lỗi
        THROW;
    END CATCH
END

/**/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_insert]
    @masp nvarchar(10),
	@iddm nvarchar(10),
	@tensp nvarchar(50),
	@saodanhgia int,
	@nhomid int,
	@anhsp nvarchar(250),
	@pricemax decimal,
	@giamgia int,
	@pricemin decimal,
	@luotxem int,
	@luotban int,
	@motasp nvarchar(max),
	@iactive bit,
	@ifeature bit,
	@ihot bit,
	@isale bit,
	@createby nvarchar(20),
	@createdate datetime,
    @Images NVARCHAR(700),
    @Details NVARCHAR(700) -- Chuỗi chứa Màu, Size, Giá, Số lượng
AS
BEGIN
    -- Thêm sản phẩm vào bảng DbSanPham
    INSERT INTO DbProduct (MaSp,TenSp, IdDm, NhomId, AnhSp, PriceMax, GiamGia, PriceMin, MotaSp, CreateDate, IActive, IFeature, IHot, ISale,CreateBy)
    VALUES (@masp,@TenSp, @iddm, @NhomId, @AnhSp, @PriceMax, @GiamGia, @PriceMin, @MotaSp, GETDATE(), @IActive, @IFeature, @IHot, @ISale,@createby);

    DECLARE @idsp INT = SCOPE_IDENTITY(); -- Lấy MaSp vừa được tạo ra

    -- Xử lý hình ảnh liên quan
    IF (@Images IS NOT NULL)
    BEGIN
        DECLARE @ImagePath NVARCHAR(255);
        DECLARE @ImgCursor CURSOR;
        SET @ImgCursor = CURSOR FOR
            SELECT value FROM STRING_SPLIT(@Images, ';');
        
        OPEN @ImgCursor;
        FETCH NEXT FROM @ImgCursor INTO @ImagePath;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO DbImg (IdSp, Img)
            VALUES (@idsp, @ImagePath);
            FETCH NEXT FROM @ImgCursor INTO @ImagePath;
        END
        
        CLOSE @ImgCursor;
        DEALLOCATE @ImgCursor;
    END

    -- Xử lý Màu, Size, Giá, Số lượng
    IF (@Details IS NOT NULL)
    BEGIN
        DECLARE @DetailCursor CURSOR;
        DECLARE @Item NVARCHAR(255);
        SET @DetailCursor = CURSOR FOR
            SELECT value FROM STRING_SPLIT(@Details, ';');
        
        OPEN @DetailCursor;
        FETCH NEXT FROM @DetailCursor INTO @Item;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @IdColor int;
            DECLARE @IdSize int;
            DECLARE @Price DECIMAL(18,2);
            DECLARE @Quantity INT;

            -- Tách thông tin Màu, Size, Giá, Số lượng
            SET @IdColor = CAST(PARSENAME(REPLACE(@Item, ',', '.'), 4) as int);
            SET @IdSize = CAST(PARSENAME(REPLACE(@Item, ',', '.'), 3) as int);
            SET @Price = CAST(PARSENAME(REPLACE(@Item, ',', '.'), 2) AS DECIMAL(18,2));
            SET @Quantity = CAST(PARSENAME(REPLACE(@Item, ',', '.'), 1) AS INT);

            -- Thêm chi tiết sản phẩm vào bảng DbChiTietSanPham
            INSERT INTO DbProductDetail(IdSp, ColorId, SizeId,GiaLoai,Quantity)
            VALUES (@idsp,@IdColor,@IdSize, @Price, @Quantity);            
            FETCH NEXT FROM @DetailCursor INTO @Item;
        END
        
        CLOSE @DetailCursor;
        DEALLOCATE @DetailCursor;
    END
END

/*Danh mục*/
--DROP PROCEDURE [dbo].[category_showall]
--exec category_showall
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[category_showall]
as
begin
	select c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,COUNT(p.IdSp) as Product,c.CreateBy,c.CreateDate,c.ModifiedDate
	from DbCategory c
	left join DbProduct p on c.IdDm=p.IdDm
	group by c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,c.CreateBy,c.CreateDate,c.ModifiedDate
	order by c.IdDm
end;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[category_insert]
	@madm NVARCHAR(10),
	@tendm  NVARCHAR(10),
	@anhdaidien  NVARCHAR(250),
	@createby nvarchar(20),
	@createdate datetime,
	@ret int out
as
begin
	set nocount on;
	begin try
		set @ret=1
			insert into DbCategory(MaDm,TenDm,AnhDaiDien,CreateBy,CreateDate) 
			values (@madm,@tendm,@anhdaidien,@createby,GETDATE())	
		set @ret=2
	end try
	begin catch
		set @ret=1
		declare @msg nvarchar(2000)= ERROR_MESSAGE();
		raiserror(@msg,16,1)
	end catch
end;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[category_update]
	@iddm int,
	@madm NVARCHAR(10),
	@tendm  NVARCHAR(10),
	@anhdaidien  NVARCHAR(250),
	@modifiedby nvarchar(20),
	@modifieddate datetime
as
begin
	update DbCategory set MaDm=@madm,TenDm=@tendm,AnhDaiDien=@anhdaidien,ModifiedBy=@modifiedby,ModifiedDate=@modifieddate
	where IdDm=@iddm
end;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[category_delete]
	@iddm int
as
begin
	delete DbCategory where IdDm=@iddm
end;