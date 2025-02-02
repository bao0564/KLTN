 use [KLTN];
SET QUOTED_IDENTIFIER ON
GO
--all danh mục
--drop procedure category_showall
create procedure [dbo].[category_showall]
as
begin
	select c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,count(p.IdSp)as Products, c.CreateDate, c.ModifiedDate,c.CreateBy
	from DbCategory c
	left join DbProduct p on c.IdDm=p.IdDm
	group by c.IdDm,c.MaDm,c.TenDm,c.AnhDaiDien,c.CreateDate,c.ModifiedDate,c.CreateBy
	order by c.IdDm desc
end;

SET QUOTED_IDENTIFIER ON
GO
--tìm danh mục
--drop procedure category_search 
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

SET QUOTED_IDENTIFIER ON
GO
--thêm danh mục
--drop procedure category_insert
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

SET QUOTED_IDENTIFIER ON
GO
--sửa danh mục
--drop procedure category_update
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

SET QUOTED_IDENTIFIER ON
GO
--xóa danh mục
--drop procedure category_delete
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

SET QUOTED_IDENTIFIER ON
GO
--thêm màu
--drop procedure color_insert
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

SET QUOTED_IDENTIFIER ON
GO
--sửa màu
--drop procedure color_update
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

SET QUOTED_IDENTIFIER ON
GO
--xóa màu
--drop procedure color_delete
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
--size
SET QUOTED_IDENTIFIER ON
GO
--thêm size
--drop procedure color_insert
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

SET QUOTED_IDENTIFIER ON
GO
--sửa size
--drop procedure size_update
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

SET QUOTED_IDENTIFIER ON
GO
--xóa size
--drop procedure size_delete
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

SET QUOTED_IDENTIFIER ON
GO
--all đơn hàng 
--drop procedure order_showall
create procedure [dbo].[order_showall]
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	order by od.CreateDate desc
end;

SET QUOTED_IDENTIFIER ON
GO
--tìm Đơn hàng 
--drop procedure order_search 
create procedure [dbo].[order_search]
	@keyword nvarchar(50)
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where od.MaDh like '%'+@keyword+'%' or cus.TenKh like '%'+@keyword+'%' or od.NguoiNhan like '%'+@keyword+'%'
	order by od.CreateDate desc
end;

SET QUOTED_IDENTIFIER ON
GO
--lọc đơn hàng 
--drop procedure order_showall_filter 
create procedure [dbo].[order_showall_filter]	
	@odsuccess bit,
	@odreadly bit,
	@odtranport bit,
	@complete bit,
	@odhuy bit	
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where od.ODSuccess=@odsuccess and od.ODReadly=@odreadly and ODTransported=@odtranport and od.Complete=@complete and od.ODHuy=@odhuy
	order by od.CreateDate desc
end;

SET QUOTED_IDENTIFIER ON
GO
--lọc Đơn hàng theo ngày
--drop procedure order_date 
create procedure [dbo].[order_date]
	@date datetime
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where CAST(od.CreateDate AS DATE) = @date 
	order by od.CreateDate desc
end;

SET QUOTED_IDENTIFIER ON
GO
--lọc Đơn hàng theo khoảng thời gian
--drop procedure order_date_todate
create procedure [dbo].[order_date_todate]
	@date datetime,
	@todate datetime
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where CAST(od.CreateDate AS DATE) >= @date and CAST(od.CreateDate as date) <= @todate
	order by od.CreateDate desc
end;
SET QUOTED_IDENTIFIER ON
GO
--tìm chi tiết đơn hàng
--drop procedure show_orderdetail
create procedure [dbo].[show_orderdetail]
	@iddh int
as
begin
	select od.IdDh,od.MaDh,
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

SET QUOTED_IDENTIFIER ON
GO
--update đơn hàng
--drop procedure orderupdate
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
/*Product*/

SET QUOTED_IDENTIFIER ON
GO
--tất cả sản phẩm
--drop procedure product_showall
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

SET QUOTED_IDENTIFIER ON
GO
--tìm kiếm sản phẩm
--drop procedure product_search
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

SET QUOTED_IDENTIFIER ON
GO
--thêm sản phẩm
--drop procedure product_insert
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

SET QUOTED_IDENTIFIER ON
GO
--thêm chi tiết ảnh sản phẩm
--drop procedure img_insert
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
		set @error=N'lỗi không thêm đc các chi tiết ảnh vào bảng DbImg'+ ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--thêm thông tin chi tiết sản phẩm
--drop procedure productdetail_insert
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

SET QUOTED_IDENTIFIER ON
GO
--hiển thị thông tin chi tiết sản phẩm
	--drop procedure product_find
create procedure [dbo].[product_find]
	@idsp int
as
begin
	select * from DbProduct where IdSp=@idsp
end;
SET QUOTED_IDENTIFIER ON
GO
	--drop procedure product_img_find
create procedure [dbo].[product_img_find]
	@idsp int
as
begin
	select * from DbImg where IdSp=@idsp
end;
SET QUOTED_IDENTIFIER ON
GO
	--drop procedure product_productdetail_find
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
SET QUOTED_IDENTIFIER ON
GO
--sửa thông tin sản phẩm
--drop procedure product_update
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

--SET QUOTED_IDENTIFIER ON
--GO
----drop procedure img_update
--create procedure [dbo].[img_update]
--	@idsp int,
--	@img nvarchar(500)
--as
--begin
--	update DbImg set Img=@img where IdSp=@idsp
--end; 

--SET QUOTED_IDENTIFIER ON
--GO
----drop procedure productdetail_update
--create procedure [dbo].[productdetail_update]
--	@idsp int,
--	@colorid int,
--	@namecolor nvarchar(50),
--	@sizeid int,
--	@namesize nvarchar(50),
--	@gialoai decimal,
--	@soluong int
--as
--begin
--	update DbProductDetail set ColorId=@colorid,NameColor=@namecolor,SizeId=@sizeid,NameSize=@namesize,GiaLoai=@gialoai,Quantity=@soluong
--	where IdSp=@idsp
--end;


SET QUOTED_IDENTIFIER ON
GO
--tìm Khách hàng
--drop procedure customer_search 
create procedure [dbo].[customer_search]
	@keyword nvarchar(50)
as
begin
	select * from DbCustomer cus
	where cus.MaKh like '%'+@keyword+'%' or cus.TenKh like '%'+@keyword+'%'
end;

SET QUOTED_IDENTIFIER ON
GO
--tạo mới admin
--drop procedure create_admin 
create procedure [dbo].[create_admin]
	@emaildn nvarchar(50),
	@namedn nvarchar(25),
	@passdn nvarchar(20),
	@chucvu nvarchar(20),
	@quyen nvarchar(20),
	@msg nvarchar(500) out,
	@error nvarchar(500) out
as
begin
	declare @generedma nvarchar(20);
	declare @newid int;
	declare @newmaad nvarchar(20);
	begin try
		if exists (select 1 from DbAdmin where EmailDn=@emaildn)
			begin
				set @error=N'Email đã được sử dụng!';
				return; 
			end
		begin
			insert into DbAdmin (EmailDn,NameDn,PasswordDn,ChucVu,Quyen)
			values (@emaildn,@namedn,@passdn,@chucvu,@quyen)

			set @newid=SCOPE_IDENTITY();
			set @generedma=CONCAT('AD',CAST(@newid AS NVARCHAR(10)));
			set @newmaad=@generedma;
			update DbAdmin set MaAdmin=@newmaad where Id=@newid

			set @msg=N'tạo tài khoản thành công';
		end
	end try
	begin catch	
		set @error=N'tạo không thành công'+ ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--hiển thị thông tin số liệu bán hàng
--drop procedure revenue_showall
--create procedure [dbo].[revenue_showall]
--	@date datetime,
--	@todate datetime
--as
--begin 
--	SELECT COUNT(od.IdDh) AS CoutDH,
--		SUM(CASE WHEN od.Complete = 1 THEN od.TongTienThanhToan ELSE 0 END) AS DoanhThu,
--		COUNT(CASE WHEN od.ODTransported = 1 THEN 1 ELSE NULL END) AS DHTranpost,
--		COUNT(CASE WHEN od.Complete = 1 THEN 1 ELSE NULL END) AS DHComplete,
--		COUNT(CASE WHEN od.ODHuy = 1 THEN 1 ELSE NULL END) AS DHHuy
--	FROM DbOrder od
--	WHERE od.CreateDate >= @date AND od.CreateDate <= @todate;
--end;

SET QUOTED_IDENTIFIER ON
GO
--hiển thị thông tin số liệu bán hàng
--drop procedure Revenue
CREATE PROCEDURE [dbo].[revenue]
    @Month INT = NULL, 
    @Year INT = NULL  
AS
BEGIN
    -- Nếu @Month hoặc @Year không được cung cấp, sử dụng giá trị hiện tại
    SET @Month = ISNULL(@Month, MONTH(GETDATE()));
    SET @Year = ISNULL(@Year, YEAR(GETDATE()));

    -- Tính ngày bắt đầu và ngày kết thúc của tháng
    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
    DECLARE @EndDate DATE = EOMONTH(@StartDate);
	   
    -- Tính toán tháng và năm của tháng trước
    DECLARE @PrevMonth INT = @Month - 1;
    DECLARE @PrevYear INT = @Year;

    -- Nếu tháng trước là tháng 12 của năm trước
    IF @PrevMonth = 0
    BEGIN
        SET @PrevMonth = 12;
        SET @PrevYear = @Year - 1;
    END;
    -- Tính ngày bắt đầu và ngày kết thúc của tháng hiện tại
    DECLARE @CurrentStartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
    DECLARE @CurrentEndDate DATE = EOMONTH(@CurrentStartDate);

    -- Tính ngày bắt đầu và ngày kết thúc của tháng trước
    DECLARE @PrevStartDate DATE = DATEFROMPARTS(@PrevYear, @PrevMonth, 1);
    DECLARE @PrevEndDate DATE = EOMONTH(@PrevStartDate);

    -- Truy vấn doanh thu và số liệu
    SELECT 
		@Month as Thang,
		@Year as Nam,
		@PrevMonth as Thangtrc,
		@PrevYear as NamTrc,
        COUNT(od.IdDh) AS CoutDH,
        SUM(CASE WHEN od.Complete = 1 THEN od.TongTienThanhToan ELSE 0 END) AS DoanhThu,
		(SELECT SUM(CASE WHEN od.Complete = 1 THEN od.TongTienThanhToan ELSE 0 END)
         FROM DbOrder od
         WHERE od.CreateDate >= @PrevStartDate AND od.CreateDate <= @PrevEndDate) AS PrevDoanhThu,        
        COUNT(CASE WHEN od.ODTransported = 1 THEN 1 ELSE NULL END) AS DHTranpost,
        COUNT(CASE WHEN od.Complete = 1 THEN 1 ELSE NULL END) AS DHComplete,
        COUNT(CASE WHEN od.ODHuy = 1 THEN 1 ELSE NULL END) AS DHHuy
    FROM DbOrder od
    WHERE od.CreateDate >= @StartDate AND od.CreateDate <= @EndDate;
END;
