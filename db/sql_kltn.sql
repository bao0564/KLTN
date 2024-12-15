use [KLTN];
--all sản phẩm
SET QUOTED_IDENTIFIER ON
GO
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
--sản phẩm sale
SET QUOTED_IDENTIFIER ON
GO
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

--sản phẩm new
--drop procedure product_new_view
SET QUOTED_IDENTIFIER ON
GO
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

--sản phẩm hot
--drop procedure product_hot_view
SET QUOTED_IDENTIFIER ON
GO
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

--sản phẩm underwear
--drop procedure product_ql_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
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

--sản phẩm Quần short
-- drop procedure product_qs_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_qs_view]
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
	WHERE p.IActive = 1 and p.IdDm = 2005
end;

--sản phẩm Áo thun
--drop procedure product_at_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_at_view]
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
	WHERE p.IActive = 1 and p.IdDm = 1
end;

--sản phẩm Quần bg
--drop procedure product_qbg_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_qbg_view]
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
	WHERE p.IActive = 1 and p.IdDm = 1007
end;

--sản phẩm Áo dài tay
--drop procedure product_adt_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_adt_view]
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
	WHERE p.IActive = 1 and p.IdDm = 1005
end;

--sản phẩm Áo khoác
--drop procedure product_ak_view
--select * from DbCategory
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[product_ak_view]
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
	WHERE p.IActive = 1 and p.IdDm = 2004
end;

--Sản phẩm Theo Danh mục
--drop procedure product_ak_view
--select * from DbCategory
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
		(select string_agg(CONCAT(pd.ColorId,',',pd.NameColor,',',c.MaColor),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = @iddm
end;
--Chi tiết sản phẩm
--drop procedure product_detail
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
		(select string_agg(concat(pd.SizeId,',',pd.NameSize,',',pd.ColorId,',',pd.NameColor,',',c.MaColor,',',pd.GiaLoai,',',pd.Quantity),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp=p.IdSp)as Detail
	from DbProduct p
	join DbCategory ct on p.IdDm=ct.IdDm
	where p.IActive = 1 and p.IdSp=@idsp
end;
--Giỏ Hàng
--Hiển thị sản phẩm giỏ hàng
--drop procedure cart_showall
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
	where cr.IdKh=@idkh
	order by cr.CreateDate desc
end;
--Thêm sản phẩm vào giỏ hàng
--drop procedure product_in_cart
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
		--kiểm tra số lượng trong kho
			select @SoluongTon=dt.Quantity from DbProductDetail dt where dt.IdSp=@idsp and dt.ColorId=@colorid and dt.SizeId=@sizeid;
			if @quantity > @SoluongTon
			begin
				RAISERROR('Số lượng sản phẩm yêu cầu vượt quá số lượng có trong kho.', 16, 1);
				RETURN;
			end
		--thêm vào giỏ hàng
		insert into DbCart(IdSp,IdKh,ProductQuantity,ColorId,SizeId,CreateDate) values(@idsp,@idkh,@quantity,@colorid,@sizeid,GETDATE());
		
		SELECT 'Thêm sản phẩm vào giỏ hàng thành công.' AS Message;
	end try
	begin catch
		SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
	end catch
end;
go