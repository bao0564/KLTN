  	use [KLTN];
	select od.MaDh,
			(select string_agg(concat(odd.MaSp,'"',p.TenSp,'"',p.AnhSp,'"',cl.NameColor,'"',sz.NameSize,'"',odd.SoLuongSp,'"',pd.GiaLoai),';')  
			from DbOrderDetail odd
			 join DbProduct p on odd.IdSp=p.IdSp
			 join DbColor cl on cl.ColorId= odd.IdColor
			 join DbSize sz on odd.IdSize=sz.SizeId
			 join DbProductDetail pd on p.IdSp=pd.IdSp and odd.IdColor=pd.ColorId and odd.IdSize= pd.SizeId
			where odd.IdDh= od.IdDh) as InForSp,			
			od.IdKh,cus.TenKh,od.NguoiNhan,od.DiaChi,od.GhiChu,
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 where od.IdDh= 13
	select * from DbProduct p WHERE p.NhomId in(3,4) and p.Classify=1
	update DbOrder set ODReadly=1, ODSuccess=0, ODPrint=0, Complete=0, ODHuy=0  where IdDh=69
	  delete Dbhi where Id=72
	select * from DbGroup
	select * from DbCustomer
	select * from DbPayment
	select * from DbProductDetail where IdSp=51 and ColorId=2 --MaCTSP= 'shortlinenghiM' 
	select * from DbProduct where MaSp='SP44'
	select * from Dbcategory 
	select * from DbOrder  where MaDh='DH70'
	select * from DbOrderDetail  where MaDh='DH69'
	select * from DbAddress
	select * from DbCart
	select * from DbColor
	select * from DbNotification
	select * from DbRating
	select * from DbHistory
	select od.IdDh,od.MaDh,od.PaymentName,od.soluong,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
		,STRING_AGG(CONCAT(p.AnhSp,'"',p.TenSp,'"',cl.NameColor,'"',sz.NameSize,'"',odd.PriceBy,'"',odd.SoLuongSp),';')as InforSP
	from DbOrder od
	join DbOrderDetail odd on odd.IdDh=od.IdDh
	join DbProduct p on odd.IdSp=p.IdSp
	join DbColor cl on cl.ColorId= odd.IdColor
	join DbSize sz on odd.IdSize=sz.SizeId
	where od.IdKh=26
	group by od.IdDh,od.MaDh,od.PaymentName,od.soluong,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	order by od.CreateDate desc

	select sum(cr.ProductQuantity)as product from DbCart cr where IdKh=24

	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	where IdDm =(select p2.IdDm from DbProduct p2 where p2.IdSp=9) and p.IdSp !=9
delete DbCategory where IdDm=11

DECLARE @msg NVARCHAR(500);
DECLARE @error NVARCHAR(500);
EXEC create_admin 
    @emaildn = 'baokun959@gmail.com',
    @namedn = 'bossbao',
    @passdn = 'thanhmi@123',
    @chucvu = 'Admin',
    @quyen = 'Admin',
    @msg = @msg OUTPUT,
    @error = @error OUTPUT;

SELECT @msg AS Message, @error AS Error;
--số lượng và doanh thu theo thời gian 
SELECT 
    COUNT(od.IdDh) AS CoutDH,
    SUM(CASE WHEN od.Complete = 1 THEN od.TongTienThanhToan ELSE 0 END) AS DoanhThu,
    COUNT(CASE WHEN od.ODTransported = 1 THEN 1 ELSE NULL END) AS DHTranpost,
    COUNT(CASE WHEN od.Complete = 1 THEN 1 ELSE NULL END) AS DHComplete,
    COUNT(CASE WHEN od.ODHuy = 1 THEN 1 ELSE NULL END) AS DHHuy
FROM DbOrder od
WHERE od.CreateDate >= '2024-12-01' 
  AND od.CreateDate <= '2024-12-12 23:59:59';
  SELECT MONTH(GETDATE()) AS CurrentMonth, YEAR(GETDATE()) AS CurrentYear;
   EXEC Revenue @Month = 1, @Year = 2025;
--lọc đơn hàng theo trạng thái
select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where od.ODSuccess=0 and od.ODReadly=0 and ODTransported=0 and od.Complete=0 and od.ODHuy=1
	order by od.CreateDate desc
--lọc đơn hàng 
WITH OrderedData AS (
    SELECT 
        od.IdDh,p.IdSp, p.AnhSp, p.TenSp, 
        cl.NameColor, sz.NameSize,
        ROW_NUMBER() OVER (PARTITION BY p.IdSp ORDER BY cl.NameColor) AS ColorRank,
        ROW_NUMBER() OVER (PARTITION BY p.IdSp ORDER BY sz.NameSize) AS SizeRank
    FROM DbOrder od
    JOIN DbOrderDetail odd ON od.IdDh = odd.IdDh
    JOIN DbProduct p ON odd.IdSp = p.IdSp
    JOIN DbColor cl ON cl.ColorId = odd.IdColor
    JOIN DbSize sz ON sz.SizeId = odd.IdSize
    WHERE od.IdDh = 10 AND od.Complete = 1
)
SELECT 
    IdDh,IdSp, AnhSp, TenSp, 
    STRING_AGG(CONCAT(NameColor, ' - ', NameSize), ', ') AS ColorSizes
FROM OrderedData
WHERE ColorRank = SizeRank  -- Chỉ lấy các cặp có cùng số thứ tự
GROUP BY IdDh,IdSp, AnhSp, TenSp;

update DbOrder set ODHuy=0, ODSuccess=0,ODReadly=0,ODTransported=0,Complete=1 
select *from DbOrder
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_order_print_status]
    @iddh INT = NULL,
    @inlai BIT = NULL,  -- Đánh dấu là in lại hay không
    @error NVARCHAR(500) OUTPUT
AS
BEGIN 
    DECLARE @isprint BIT;
    DECLARE @reprint BIT;

    -- Nếu có truyền ID đơn hàng
    IF @iddh IS NOT NULL AND @iddh > 0 
    BEGIN
        -- Lấy trạng thái in của đơn hàng
        SELECT @isprint = ODPrint, @reprint = ODReprint 
        FROM DbOrder 
        WHERE IdDh = @iddh;

        -- Nếu không phải in lại (in lần đầu)
        IF (@inlai IS NULL OR @inlai = 0) 
        BEGIN
            IF @isprint = 0
            BEGIN
                --PRINT N'In đơn hàng lần đầu...';
                EXEC sp_reprint_order @iddh;
                UPDATE DbOrder 
                SET ODPrint = 1, ODSuccess = 0, ODReadly = 1 
                WHERE IdDh = @iddh;
                RETURN;
            END
            ELSE
            BEGIN
                SET @error = N'Đơn hàng đã được in trước đó. Vui lòng chọn chức năng in lại!';
                SELECT @error AS error;
                RETURN;
            END
        END

        -- Nếu là in lại (@inlai = 1)
        IF @inlai IS NOT NULL AND @inlai = 1
        BEGIN
            IF @isprint = 1 AND @reprint = 0
            BEGIN
                --PRINT N'In lại đơn hàng...';
                EXEC sp_print_order @iddh;
                UPDATE DbOrder 
                SET ODReprint = 1 
                WHERE IdDh = @iddh;
                RETURN;
            END
            ELSE
            BEGIN
                -- Không thể in lại nữa
                SET @error = N'Đơn hàng đã được in đủ số lần cho phép (2 lần) và không thể in lại nữa';
                SELECT @error AS error;
                RETURN;
            END
        END
    END
    ELSE
    BEGIN
        -- In tất cả đơn hàng chưa in
        --PRINT N'In tất cả đơn hàng chưa in...';
        EXEC sp_reprint_order NULL;
        UPDATE DbOrder 
        SET ODPrint = 1, ODSuccess = 0, ODReadly = 1 
        WHERE ODPrint = 0;
    END
END;

SELECT STRING_AGG(
    'Tháng ' + CAST(Month(CreateDate) AS VARCHAR) + ': ' + CAST(SUM(CASE WHEN Complete = 1 THEN TongTienThanhToan ELSE 0 END) AS VARCHAR),
    ' | '
) AS DoanhThuTongHop
FROM DbOrder
WHERE 
    YEAR(CreateDate) = YEAR(GETDATE())
    AND Complete = 1
GROUP BY MONTH(CreateDate);


WITH DoanhThuThang AS (
    SELECT 
        MONTH(CreateDate) AS Thang,
        SUM(TongTienThanhToan) AS TongDoanhThu
    FROM DbOrder
    WHERE 
        YEAR(CreateDate) = 2025
        AND Complete = 1
    GROUP BY MONTH(CreateDate)
)

--Dùng STRING_AGG để nối thành 1 chuỗi
SELECT STRING_AGG(
    'Tháng ' + CAST(Thang AS VARCHAR) + ': ' + CAST(TongDoanhThu AS VARCHAR),
    ' | '
) AS DoanhThuTongHop
FROM DoanhThuThang; 
update DbOrder set IdKh=21,
					NguoiNhan=N'Đặng bảo',
					EmailKh=N'baokun959@gmail.com',
					Sdt='0332020050',
					City=N'hưng yên',
					District=N'tân hưng',
					Ward=N'đội 9',
					DiaChi=N'đội 9- tân hưng- hưng yên',
					TongTien= 810000,
					TongTienThanhToan=749000,
					soluong=3,
					PaymentId=1,
					PaymentName=N'OCD-Thanh Toán Khi Nhận Hàng',
					IdVoucher=1,
					ValueVoucher=10,
					Giamgia=81000,
					Ship=20000,
					GhiChu=N'none',
					ODSuccess=1,
					ODReadly=0,
					ODTransported=0,
					Complete=0,
					CreateDate='2024-12-01 17:37:48.1233333',
					ModifiedBy=N'bosbao',
					ODHuy=0,
					ODPrint=1,
					ODReprint=0,
					CompleteDate='2024-12-11 17:37:48.1233333',
					odre