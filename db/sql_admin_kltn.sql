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
		insert into DbColor(NameColor,Img,CreateBy,CreateDate) 
		values (@namecl,@img,@createby,GETDATE())

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
	@img nvarchar(250),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbColor set NameColor=@namecl,Img=@img,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
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

SET QUOTED_IDENTIFIER ON
GO
--all đơn hàng 
--drop procedure order_showall
create procedure [dbo].[order_showall]
as
begin
	select od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
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
	select od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where od.MaDh like '%'+@keyword+'%' or cus.TenKh like '%'+@keyword+'%' or od.NguoiNhan like '%'+@keyword+'%'
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
	select od.MaDh,
			(select string_agg(concat(odd.MaSp,',',p.TenSp,',',p.AnhSp,',',cl.NameColor,',',sz.NameSize,',',odd.SoLuongSp,','),';') 
			from DbOrderDetail odd
			 join DbProduct p on odd.IdSp=p.IdSp
			 join DbColor cl on cl.ColorId= odd.IdColor
			 join DbSize sz on odd.IdSize=sz.SizeId
			where odd.IdSp= p.IdSp) as MaSp,			
			od.IdKh,cus.TenKh,od.NguoiNhan,od.DiaChi,od.GhiChu,
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 where od.MaDh= @iddh
end;
/*Product*/
