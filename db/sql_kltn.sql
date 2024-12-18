use [KLTN];
SET QUOTED_IDENTIFIER ON
GO
--all sản phẩm
create procedure [dbo].[product_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1
end;
SET QUOTED_IDENTIFIER ON
GO
--sản phẩm sale
create procedure [dbo].[product_sale_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.ISale =1
end;

SET QUOTED_IDENTIFIER ON
GO
--sản phẩm new
--drop procedure product_new_view
create procedure [dbo].[product_new_view]
as
begin
	select top 10 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.CreateDate <= DATEADD(DAY,50,GETDATE())
end;

SET QUOTED_IDENTIFIER ON
GO
--sản phẩm hot
--drop procedure product_hot_view
create procedure [dbo].[product_hot_view]
as
begin
	select top 10 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IHot =1
end;

SET QUOTED_IDENTIFIER ON
GO
--sản phẩm underwear
--drop procedure product_ql_view
--select * from DbCategory
create procedure [dbo].[product_ql_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = 2006
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Theo Danh mục
--drop procedure product_by_iddm
--select * from DbCategory
create procedure [dbo].[product_by_iddm]
	@iddm int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = @iddm
end;
SET QUOTED_IDENTIFIER ON
GO
--Chi tiết sản phẩm
--drop procedure product_detail
create procedure [dbo].[product_detail]
	@idsp int
as
begin
	select p.IdSp, p.MaSp,ct.TenDm,p.TenSp,p.SaoDanhGia,p.AnhSp,p.PriceMax,p.GiamGia,p.PriceMin,p.LuotXem,p.LuotSold,p.MotaSp,p.Ifavorite,
		(select string_agg(i.Img,';')
		from DbImg i
		where i.IdSp=p.IdSp)as ImgDetail,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize,',',pd.ColorId,',',pd.NameColor,',',c.MaColor,',',pd.GiaLoai,',',pd.Quantity),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp=p.IdSp)as Detail
	from DbProduct p
	join DbCategory ct on p.IdDm=ct.IdDm
	where p.IActive = 1 and p.IdSp=@idsp
end;
SET QUOTED_IDENTIFIER ON
GO
--Giỏ Hàng
--Hiển thị sản phẩm giỏ hàng
--drop procedure cart_showall
create procedure [dbo].[cart_showall]
	@idkh int
as
begin	
	select cr.IdSp,p.MaSp,p.TenSp,p.AnhSp,dt.ColorId,dt.NameColor,dt.SizeId,dt.NameSize,dt.GiaLoai,cr.ProductQuantity,cr.ProductQuantity * dt.GiaLoai as Total
	from DbCart cr 
	join DbProduct p on cr.IdSp=p.IdSp
	join DbProductDetail dt on cr.IdSp=dt.IdSp and cr.ColorId=dt.ColorId and cr.SizeId=dt.SizeId
	where cr.IdKh=@idkh
	order by cr.CreateDate desc
end;
SET QUOTED_IDENTIFIER ON
GO
--Thêm sản phẩm vào giỏ hàng
--drop procedure product_in_cart
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
go

SET QUOTED_IDENTIFIER ON
GO
--Thay đổi số lượng sản phẩm trong giỏ hàng
--drop procedure update_product_in_cart
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

SET QUOTED_IDENTIFIER ON
GO
--Xóa sản phẩm trong giỏ hàng
--drop procedure delete_product_in_cart
create procedure [dbo].[delete_product_in_cart]
	@idsp int,
	@idkh int,
	@colorid int,
	@sizeid int
as
begin
	delete from DbCart where IdSp=@idsp and IdKh=@idkh and ColorId=@colorid and SizeId=@sizeid
end;


SET QUOTED_IDENTIFIER ON
GO
--lấy sản phẩm được chọn trong giỏ hàng
--drop procedure delete_product_in_cart
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

SET QUOTED_IDENTIFIER ON
GO
--lưu thông tin đơn hàng vào bảng đơn hàng 
--drop procedure add_order
create procedure [dbo].[add_order]
	 @idkh INT,
    @emailkh NVARCHAR(25),
    @sdt NVARCHAR(15),
    @city NVARCHAR(10),
    @district NVARCHAR(10),
    @ward NVARCHAR(10),
    @diachi NVARCHAR(500),
    @tongtien DECIMAL(18, 2),
    @tongtienthanhtoan DECIMAL(18, 2),
    @soluong INT,
    @payid INT,
    @payname NVARCHAR(10),
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
		insert into DbOrder(IdKh,EmailKh,Sdt,City,District,Ward,DiaChi,TongTien,TongTienThanhToan,soluong,PaymentId,PaymentName,IdVoucher,ValueVoucher,Giamgia,Ship,GhiChu,ODSuccess, ODReadly, ODTransported, Complete,CreateDate)
		values (@idkh,@emailkh,@sdt,@city,@district,@ward,@diachi,@tongtien,@tongtienthanhtoan,@soluong,@payid,@payname,@idvoucher,@valuevoucher,@giamgia,@ship,@ghichu,1,0,0,0,GETDATE());
		set @NewIdDH = SCOPE_IDENTITY();
		set @GeneratedMaDH = CONCAT('DH',FORMAT(@NewIdDH,''));
		set @NewMaDH = @GeneratedMaDH;
		update DbOrder
			set MaDh=@GeneratedMaDH where IdDh=@NewIdDH;
	end
end;

SET QUOTED_IDENTIFIER ON
GO
--lưu thông tin sp vào bảng chi tiết đơn hàng 
--drop procedure add_orderdetail
create procedure [dbo].[add_orderdetail]
	@iddh int,
	@madh nvarchar(500),
	@idsp int,
	@masp nvarchar(10),
	@colorid int,
	@sizeid int,
	@soluongsp int
as
begin
	insert into DbOrderDetail(IdDh,MaDh,IdSp,MaSp,IdColor,IdSize,SoLuongSp,CreateDate)
	values(@iddh,@madh,@idsp,@masp,@colorid,@sizeid,@soluongsp,GETDATE())
end;

select * from DbOrder
select * from DbOrderDetail