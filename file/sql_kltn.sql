use [KLTN];

SET QUOTED_IDENTIFIER ON
GO
--tìm kiếm sản phẩm
--EXEC sp_user_search_product @keyword="áo"
--drop procedure sp_user_search_product
--select * from DbProduct 
create procedure [dbo].[sp_user_search_product]
	@keyword nvarchar(50)=null
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors		
	from DbProduct p
	join DbCategory cate on p.IdDm=cate.IdDm
	where @keyword IS NULL OR p.TenSp like '%'+@keyword+'%' or cate.TenDm like '%'+@keyword+'%' and p.IActive = 1
	order by p.IdSp desc
end;

SET QUOTED_IDENTIFIER ON
GO
--tìm kiếm sản phẩm
--EXEC sp_user_search_sugget @keyword="ao"
--drop procedure sp_user_search_sugget  --COLLATE Latin1_General_CI_AI:không phân biệt chữ hoa thường dấu
create procedure [dbo].[sp_user_search_sugget]
	@keyword nvarchar(50)=null
as
begin
	select top 5 p.IdSp, p.TenSp, p.AnhSp from DbProduct p
	where (@keyword IS NULL or 
			p.TenSp COLLATE Latin1_General_CI_AI like @keyword +'% ' OR 
			p.TenSp COLLATE Latin1_General_CI_AI like '% '+@keyword+' % ' or 
			p.TenSp COLLATE Latin1_General_CI_AI like @keyword +' %') and p.IActive = 1
end;

SET QUOTED_IDENTIFIER ON
GO
--all sản phẩm
--EXEC product_view
-- drop procedure product_view
create procedure [dbo].[product_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1
	order by p.CreateDate desc	
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Danh mục QUẦN phân loại Nam/Nữ
--exec sp_product_trousers @classify=1
--drop procedure sp_product_trousers
--select * from DbCategory
create procedure [dbo].[sp_product_trousers]
	@classify int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm in(1,21) and p.Classify=@classify
	order by p.CreateDate desc 	
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Danh mục ÁO phân loại Nam/Nữ
--exec sp_product_shirt @classify=2
--drop procedure sp_product_shirt
--select * from DbCategory
create procedure [dbo].[sp_product_shirt]
	@classify int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p	
	WHERE p.IActive = 1 and p.NhomId in(1,2,3) and p.Classify=@classify
	order by p.CreateDate desc	
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Danh mục THU ĐÔNG phân loại Nam/Nữ
--exec sp_product_aw @classify=1
--drop procedure sp_product_aw
--select * from DbCategory
create procedure [dbo].[sp_product_aw]
	@classify int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.NhomId in(7,4) and p.Classify=@classify
	order by p.CreateDate desc	
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Danh mục THU ĐÔNG phân loại Nam/Nữ
--exec sp_product_sa @classify=1
--drop procedure sp_product_sa
--select * from DbCategory
create procedure [dbo].[sp_product_sa]
	@classify int
as
begin
	select top 5 p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.NhomId in(1,2,3,6) and p.Classify=@classify
	order by p.CreateDate desc	
end;

SET QUOTED_IDENTIFIER ON
GO
--sản phẩm sale
-- drop procedure product_sale_view
create procedure [dbo].[product_sale_view]
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
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
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.CreateDate >= DATEADD(DAY,-50,GETDATE())	
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
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors,
		SUM(od.SoLuongSp) as soluongban
	from DbProduct p
	join DbOrderDetail od on od.IdSp=p.IdSp
	WHERE p.IActive = 1 and od.CreateDate >=DATEADD(MONTH, -3, GETDATE())
	group by p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem
	order by soluongban desc
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
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.IdDm = 2006
end;

SET QUOTED_IDENTIFIER ON
GO
--Sản phẩm Theo nhóm
--drop procedure product_by_idnhom
--select * from DbCategory
create procedure [dbo].[product_by_idnhom]
	@idnhom int
as
begin
	select p.IdSp, p.MaSp,p.TenSp,p.AnhSp,p.PriceMax,p.PriceMin,p.GiamGia,p.Ifavorite,p.LuotSold,p.LuotXem,
		(select string_agg(concat(pd.SizeId,',',pd.NameSize),';')
		from DbProductDetail pd
		where pd.IdSp=p.IdSp)as Sizes,
		(select string_agg(concat(pd.ColorId,',',pd.NameColor,',',c.MaColor,',',c.MaHex),';')
		from DbProductDetail pd
		join DbColor c on pd.ColorId=c.ColorId
		where pd.IdSp =p.IdSp)as Colors
	from DbProduct p
	WHERE p.IActive = 1 and p.NhomId = @idnhom
	order by p.CreateDate desc	
end;

SET QUOTED_IDENTIFIER ON
GO
--Chi tiết sản phẩm
--EXEC product_detail @idsp=19
--drop procedure product_detail
create procedure [dbo].[product_detail]
	@idsp int
as
begin
	declare @rate DECIMAL(10,1);
	select @rate=cast(AVG(Cast(r.Rate as float)) AS DECIMAL(10,1)) from DbRating r where r.IdSp=@idsp
	select p.IdSp,@rate as Rate, p.MaSp,ct.TenDm,p.TenSp,p.SaoDanhGia,p.AnhSp,p.PriceMax,p.GiamGia,p.PriceMin,p.LuotXem,p.LuotSold,p.MotaSp,p.Ifavorite,
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
	where p.IActive = 1 and cr.IdKh=@idkh
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
	@sizeid int,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	--begin try
		declare @SoluongTon int;
		declare @ExistProduct int;
		declare @tongraw int;
		declare @tongsp int;
		--kiểm tra số lượng trong kho
			select @SoluongTon=dt.Quantity from DbProductDetail dt where dt.IdSp=@idsp and dt.ColorId=@colorid and dt.SizeId=@sizeid;
			if @quantity > @SoluongTon
			begin
				--RAISERROR('Số lượng sản phẩm yêu cầu vượt quá số lượng có trong kho.', 16, 1);
				set @error=N'Số lượng sản phẩm yêu cầu vượt quá số lượng có trong kho'
				RETURN;
			end 
			select @ExistProduct = cr.Id from DbCart cr where cr.IdKh=@idkh and cr.IdSp=@idsp and cr.ColorId=@colorid and cr.SizeId=@sizeid;
			if @ExistProduct is not null
				begin
					--kiểm tra tổng số lượng tồn tại và đang thêm vào có vượt quá tồn kho ko
					select @tongraw=ProductQuantity from DbCart where Id=@ExistProduct;
					set @tongsp= @tongraw + @quantity
					if @tongsp >@SoluongTon
						begin		
							--cập nhật số lượng sp bằng số lượng tồn kho đã có vào giỏ hàng					
							update DbCart set ProductQuantity =@SoluongTon where Id=@ExistProduct;
							set @msg=N'Thêm sản phẩm vào giỏ hàng thành công.'
							return;
						end
					else
						begin
							--cập nhật số lượng sp đã có vào giỏ hàng
							update DbCart set ProductQuantity =ProductQuantity+@quantity where Id=@ExistProduct;
							set @msg=N'Thêm sản phẩm vào giỏ hàng thành công.'
							return;
						end
				end
			else
				begin
					--thêm mới sp vào giỏ hàng
					insert into DbCart(IdSp,IdKh,ProductQuantity,ColorId,SizeId,CreateDate) values(@idsp,@idkh,@quantity,@colorid,@sizeid,GETDATE());
				end
			--msg	
		--SELECT 'Thêm sản phẩm vào giỏ hàng thành công.' AS Message;		
		 set @msg=N'Thêm sản phẩm vào giỏ hàng thành công.'
	--end try
	--begin catch
	--	SELECT 
 --           ERROR_NUMBER() AS ErrorNumber,
 --           ERROR_MESSAGE() AS ErrorMessage;
	--end catch
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
--drop procedure compare_product_in_cart
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
	@priceby decimal,
	@soluongsp int
as
begin
	insert into DbOrderDetail(IdDh,MaDh,IdSp,MaSp,IdColor,IdSize,PriceBy,SoLuongSp,CreateDate)
	values(@iddh,@madh,@idsp,@masp,@colorid,@sizeid,@priceby,@soluongsp,GETDATE())
end;


SET QUOTED_IDENTIFIER ON
GO
--tạo tài khoản khách hàng
--drop procedure create_user
--select * from DbCustomer
--delete DbCustomer where IdKh=25;
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
SET QUOTED_IDENTIFIER ON
GO
--sửa thông tin khách hàng
--drop procedure update_user
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
		IF EXISTS (SELECT 1 FROM DbCustomer WHERE Sdt = @sdt AND IdKh <> @idkh)
			BEGIN
				SET @error = N'Số điện thoại này đã được sử dụng!';
				RETURN;
			END
		begin
			update DbCustomer set MaKh='KH'+CAST(@idkh as nvarchar),TenKh=@tenkh,Img=@img,GioiTinh=@sex,Sdt=@sdt,Email=@email,Passwords=@pass,ConfirmPasswords=@confirmpass,ModifiedDate=GETDATE()
			where IdKh=@idkh
			set @msg=N'Cập nhật thông tin thành công';
		end
	end try
	begin catch
		set @error=N'Cập nhật thông tin không thành công'+ ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị sản phẩm yêu thích của khách hàng
--drop procedure favorite_product_showall
--select * from DbFavoriteProduct
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

SET QUOTED_IDENTIFIER ON
GO
--lưu sản phẩm yêu thích vào bảng yêu thích
--drop procedure create_favorite_product
--select * from DbFavoriteProduct
create procedure [dbo].[create_favorite_product]
	@idsp int,
	@idkh int
as
begin
	insert into DbFavoriteProduct (IdSp,IdKh) values (@idsp,@idkh)
end;


SET QUOTED_IDENTIFIER ON
GO
--Hiển thị Các đơn hàng của khách hàng
--select * from DbOrder
--drop procedure customer_order_showall
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

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị Các địa chỉ của khách hàng
--drop procedure adress_showall
create procedure [dbo].[adress_showall]
	@idkh int
as
begin
	select * from DbAddress
	where IdKh=@idkh
end;

SET QUOTED_IDENTIFIER ON
GO
--tạo địa chỉ cho khách hàng
--drop procedure create_customer_adress
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

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị số sản phẩm trong giỏ hàng khách hàng
--drop procedure view_product_in_cart
create procedure [dbo].[view_product_in_cart]
	@idkh int
as
begin	
	select sum(cr.ProductQuantity)as product from DbCart cr where IdKh=@idkh
end;

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị sản phẩm gợi ý
--drop procedure view_product_suggest
create procedure [dbo].[view_product_suggest]
	@idsp int
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
	where IdDm =(select p2.IdDm from DbProduct p2 where p2.IdSp=@idsp) and p.IdSp !=@idsp
end;

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị sản phẩm cần đánh giá
--drop procedure view_product_rating
create procedure [dbo].[view_product_rating]
	@iddh int
as
begin 		
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
		WHERE od.IdDh = @iddh AND od.Complete = 1
	)
	SELECT 
		IdDh,IdSp, AnhSp, TenSp, 
		STRING_AGG(CONCAT(NameColor, ' - ', NameSize), ', ') AS ColorSizes
	FROM OrderedData
	WHERE ColorRank = SizeRank  -- Chỉ lấy các cặp có cùng số thứ tự
	GROUP BY IdDh,IdSp, AnhSp, TenSp;
end;

SET QUOTED_IDENTIFIER ON
GO
--lưu đánh giá váo bảng đnahs giá
--drop procedure creat_rating
create procedure [dbo].[creat_rating]
	@iddh int,
	@idsp int,
	@idkh int,
	@rate int,
	@colorsize nvarchar(500) ,
	@danhgia nvarchar(500) 
as
begin 	
	insert into DbRating (IdDh,IdSp,IdKh,Rate,ColorSize,DanhGia,CreateDate) 
		values (@iddh,@idsp,@idkh,@rate,@colorsize,@danhgia,GETDATE())	
end;

SET QUOTED_IDENTIFIER ON
GO
--Hiển thị đánh giá sản phẩm trong chi tiết sản phẩm
--exec sp_rating_product @idsp=28
--drop procedure sp_rating_product
create procedure [dbo].[sp_rating_product]
	@idsp int
as
begin
	select cus.Img, cus.TenKh, rat.CreateDate, rat.DanhGia, rat.Rate, rat.ColorSize
	from DbRating rat 
	join DbCustomer cus on rat.IdKh=cus.IdKh
	where rat.IdSp=@idsp
end;

SET QUOTED_IDENTIFIER ON
GO
--Lưu mã code để đặt lại mật khẩu
--DECLARE @error NVARCHAR(500); EXEC sp_forgot_pass_code @idkh=21,@code="12345", @error = @error OUTPUT; PRINT @error;
--drop procedure sp_forgot_pass_code
create procedure [dbo].[sp_forgot_pass_code]
	@idkh int,
	@code nvarchar(15),
	@error nvarchar(500) out
as
begin
	begin try
		update DbCustomer set ForgotPasword= @code where IdKh=@idkh
	end try
	begin catch
		set @error=N'Lỗi - Mã code ForgotPasword không được lưu thành công '+ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--kiểm tra mã code để đổi mật khẩu
--DECLARE @error NVARCHAR(500); EXEC sp_check_pass_code @email="",@pass="",@confirmpass="", @error = @error OUTPUT; PRINT @error;
--drop procedure sp_check_pass_code
create procedure [dbo].[sp_check_pass_code]
	@email nvarchar(50),
	@pass nvarchar(15),
	@confirmpass nvarchar(15),
	@error nvarchar(500) out
as
begin
	begin try
		update DbCustomer set Passwords=@pass,ConfirmPasswords=@confirmpass where Email=@email
	end try
	begin catch
		set @error=N'Lỗi - Đổi mật khẩu không thành công '+ERROR_MESSAGE();
	end catch
end;
use [KLTN];