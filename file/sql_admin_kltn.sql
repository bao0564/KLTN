﻿  use [KLTN];
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
--DECLARE @msg NVARCHAR(500), @error NVARCHAR(500);exec category_insert @madm="Polotron", @tendm="polo trơn",@anhdaidien="bvwb", @createby="bao",@msg = @msg OUTPUT, @error = @error OUTPUT; SELECT @msg AS Message, @error AS Error;
--drop procedure category_insert
create procedure [dbo].[category_insert]
	@madm nvarchar(50),
	@tendm nvarchar(50),
	@anhdaidien nvarchar(250),
	@createby nvarchar(25),

	@msg nvarchar(500) output,
	@error nvarchar(500) output
as 
begin
	begin try
		--tạo mới
		insert into DbCategory (MaDm,TenDm,AnhDaiDien,CreateBy,CreateDate) 
		values (@madm,@tendm,@anhdaidien,@createby,GETDATE())

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
	@tendm nvarchar(50),
	@madm nvarchar(50),
	@anhdaidien nvarchar(250),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbCategory set TenDm=@tendm,MaDm=@madm,AnhDaiDien=@anhdaidien,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
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
--thêm nhóm
--DECLARE @msg NVARCHAR(500), @error NVARCHAR(500);exec group_insert @madm="Polotron", @tendm="polo trơn",@anhdaidien="bvwb", @createby="bao",@msg = @msg OUTPUT, @error = @error OUTPUT; SELECT @msg AS Message, @error AS Error;
--drop procedure group_insert
create procedure [dbo].[group_insert]
	@manhom nvarchar(50),
	@tennhom nvarchar(50),
	@anhdaidien nvarchar(250),
	@createby nvarchar(25),

	@msg nvarchar(500) output,
	@error nvarchar(500) output
as 
begin
	begin try
		--tạo mới
		insert into DbGroup(MaNhom,GroupName,AnhDaiDien,CreateBy,CreateDate) 
		values (@manhom,@tennhom,@anhdaidien,@createby,GETDATE())

		set @msg = N'Thêm nhóm thành công';
	end try
	begin catch
		set @error =ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--sửa nhóm
--drop procedure group_update
create procedure [dbo].[group_update]
	@idnhom int,
	@manhom nvarchar(50),
	@tennhom nvarchar(50),
	@anhdaidien nvarchar(250),
	@modifiedby nvarchar(25),

	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbGroup set GroupName=@tennhom,MaNhom=@manhom,AnhDaiDien=@anhdaidien,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
		where IdNhom=@idnhom;
		set @msg = N'Sửa thành công.';
	end try
	begin catch
		set @error= ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--xóa nhóm
--drop procedure group_delete
create procedure [dbo].[group_delete]
	@idnhom int,
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		delete DbGroup where IdNhom=@idnhom;
		set @msg = N'Đã xóa nhóm.';
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
	@macl nvarchar(50),
	@namecl nvarchar(50),
	@mahex nvarchar(20),
	@img nvarchar(250),
	@createby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		--tạo mới
		insert into DbColor(MaColor,NameColor,MaHex,Img,CreateBy,CreateDate) 
		values (@macl,@namecl,@mahex,@img,@createby,GETDATE())
		set @msg = N'Đã thêm màu.';
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
	@macl nvarchar(50),
	@mahex nvarchar(20),
	@img nvarchar(250),
	@modifiedby nvarchar(25),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	begin try
		update DbColor set NameColor=@namecl,MaColor=@macl,MaHex=@mahex,Img=@img,ModifiedBy=@modifiedby,ModifiedDate=GETDATE() 
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

/*DbOrder: Đơn hàng*/
SET QUOTED_IDENTIFIER ON
GO
--lưu thông tin thay đổi khi Cập nhật đơn hàng 
----drop trigger trg_AfterUpdateOrder
create trigger trg_AfterUpdateOrder 
on DbOrder
after update 
as
begin
	set nocount on;
	insert into DbHistory(TableName,TableId,OldValue,NewValue,ModifiedDate,ModifiedBy)
	select 
		'DbOrder' as TableName,
		i.IdDh as TableId,
		(
            SELECT 
				Case when d.ODSuccess<>i.ODSuccess then d.ODSuccess else null end as odsuccess,
				Case when d.ODReadly<>i.ODReadly then d.ODReadly else null end as odreadly,
				Case when d.ODTransported<>i.ODTransported then d.ODTransported else null end as odtransported,
				Case when d.Complete<>i.Complete then d.Complete else null end as complete,
				Case when d.ODHuy <>i.ODHuy then d.ODHuy else null end as odhuy,
				Case when d.ODPrint <>i.ODPrint then d.ODPrint else null end as odprint,
				Case when d.ODReprint <>i.ODReprint then d.ODReprint else null end as odreprint
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS OldValue,
        (
			select 
				Case when d.ODSuccess<>i.ODSuccess then i.ODSuccess else null end as odsuccess,
				Case when d.ODReadly<>i.ODReadly then i.ODReadly else null end as odreadly,
				Case when d.ODTransported<>i.ODTransported then i.ODTransported else null end as odtransported,
				Case when d.Complete<>i.Complete then i.Complete else null end as complete,
				Case when d.ODHuy <>i.ODHuy then i.ODHuy else null end as odhuy,
				Case when d.ODPrint <>i.ODPrint then i.ODPrint else null end as odprint,
				Case when d.ODReprint <>i.ODReprint then i.ODReprint else null end as odreprint
			for json path,WITHOUT_ARRAY_WRAPPER
		) as NewValue,
		GETDATE() as ModifiedDate,
		i.ModifiedBy as ModifiedBy
	from inserted i
	inner join deleted d on i.IdDh=d.IdDh
	where
		d.ODSuccess <> i.ODSuccess or
		d.ODReadly <> i.ODReadly or
		d.ODTransported <> i.ODTransported or
		d.Complete <> i.Complete or
		d.ODHuy <> i.ODHuy or
		d.ODPrint <>i.ODPrint or
		d.ODReprint <>i.ODReprint
end;

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
--tìm /lọc Đơn hàng 
--drop procedure order_search 
create procedure [dbo].[order_search]
	@keyword nvarchar(50)= null,	
	@odsuccess bit=null,
	@odreadly bit= null,
	@odtranport bit= null,
	@complete bit= null,
	@odhuy bit= null,
	@odreturn bit= null,
	@date datetime= null,
	@todate datetime= null	
as
begin
	select od.IdDh,od.MaDh,cus.TenKh,CONCAT(od.NguoiNhan,'-',od.Sdt) as NguoiNhan,CONCAT(od.Ward,'-',od.District,'-',od.City,'-',od.DiaChi) as InforAddress,
			od.soluong,od.TongTien,od.TongTienThanhToan,od.PaymentName,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy,od.ODReturn,od.ODPrint,od.ODReprint
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where (@keyword IS NULL OR od.MaDh LIKE '%' + @keyword + '%' 
		OR cus.TenKh LIKE '%' + @keyword + '%' 
		OR od.NguoiNhan LIKE '%' + @keyword + '%')

		AND (@odsuccess IS NULL OR od.ODSuccess = @odsuccess)
		AND (@odreadly IS NULL OR od.ODReadly = @odreadly)
		AND (@odtranport IS NULL OR od.ODTransported = @odtranport)
		AND (@complete IS NULL OR od.Complete = @complete)
		AND (@odhuy IS NULL OR od.ODHuy = @odhuy)
		AND (@odreturn IS NULL OR od.ODReturn = @odreturn)
		AND (
            (@date IS NULL AND @todate IS NULL) OR 
            (@date IS NOT NULL AND @todate IS NULL AND CAST(od.CreateDate AS DATE) = @date) OR
            (@date IS NULL AND @todate IS NOT NULL AND CAST(od.CreateDate AS DATE) <= @todate) OR
            (@date IS NOT NULL AND @todate IS NOT NULL AND CAST(od.CreateDate AS DATE) BETWEEN @date AND @todate)
        )
	order by
		CASE 
            WHEN @date IS NOT NULL AND @todate IS NULL THEN od.soluong
			ELSE NULL 
		END ASC,
	od.CreateDate desc
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
			od.soluong,od.TongTien,od.TongTienThanhToan,od.CreateDate,od.ODSuccess,od.ODReadly,ODTransported,od.Complete,od.ODHuy,od.ODReturn,od.ODPrint,od.ODReprint
	from DbOrder od
	join DbCustomer cus on od.IdKh=cus.IdKh
	where CAST(od.CreateDate AS DATE) = @date 
	order by od.soluong ASC
end;

--select * from DbOrder
--select * from DbOrderDetail
SET QUOTED_IDENTIFIER ON
GO
--tìm chi tiết đơn hàng// dùng để in đơn hàng//dùng để in tất cả đơn hàng
--drop procedure show_orderdetail
--EXEC show_orderdetail @iddh=0
create procedure [dbo].[show_orderdetail]
	@iddh int = null
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
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan,od.Sdt,od.PaymentName,od.CreateDate
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 WHERE (@iddh IS NULL OR @iddh = 0 OR od.IdDh = @iddh) --nếu in nhiều ctdh thì trong code @iddh = 0 nên thêm @iddh =0 vào dkien
end;

-- cập nhật tình trạng in sau khi in đơn hàng theo id, in tất cả đơn hàng
--drop procedure sp_print_order
--EXEC sp_print_order @iddh=10
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_print_order]--thông tin đơn đặt hàng của khách hàng
	@iddh int = null
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
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan,od.Sdt,od.PaymentName,od.CreateDate
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 WHERE (@iddh IS NULL OR @iddh = 0 OR od.IdDh = @iddh)and od.ODPrint=0 and od.ODHuy=0 --nếu in nhiều ctdh thì trong code @iddh = 0 nên thêm @iddh =0 vào dkien
end;
--in lại
--drop procedure sp_reprint_order
--EXEC sp_reprint_order @iddh=10
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_reprint_order]--thông tin đơn đặt hàng của khách hàng
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
			od.TongTien,od.Giamgia,od.Ship,od.TongTienThanhToan,od.Sdt,od.PaymentName,od.CreateDate
	 from DbOrder od
	 join DbCustomer cus on od.IdKh= cus.IdKh	 
	 WHERE od.IdDh = @iddh and od.ODPrint=1 and od.ODHuy=0
end;
--drop procedure sp_order_print_status
--DECLARE @error NVARCHAR(500); EXEC sp_order_print_status @iddh=10, @error = @error OUTPUT; PRINT @error;
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_order_print_status]
    @iddh INT = NULL,
	@error nvarchar(500) output
AS
BEGIN
	declare @isprint bit;
	declare @odS bit;
	declare @odR bit;
	declare @odT bit;
	declare @C bit;

	declare @count int;

    SET NOCOUNT ON;
	IF @iddh IS NOT NULL AND @iddh > 0
		BEGIN
			select @isprint=od.ODPrint, @odS=od.ODSuccess, @odR=od.ODReadly, @odT=od.ODTransported, @C=od.Complete from DbOrder od where od.IdDh = @iddh
			if @isprint = 0
				begin
					EXEC sp_print_order @iddh
					if @odS=1 -- nếu trường hợp ODSuccess= 1(đơn hàng mới đặt thành công) thì chuyển qua trạng thái tiếp theo
						begin
							UPDATE DbOrder set ODPrint =1,ODSuccess=0,ODReadly=1 WHERE IdDh = @iddh;
							return;
						end
					else -- còn trường hợp đơn hàng đã ko còn ở trạng thái ODSuccess= 1 thì chỉ thay đổi trạng thái in thôi
						begin
							UPDATE DbOrder set ODPrint =1 WHERE IdDh = @iddh;
							return;
						end
					return;
				end
			else
				begin
					set @error=N'đơn hàng đã được in trước đó không thể in lại nữa';
					select @error as error;
					return;
				end
		END
    --if(@iddh is null or @iddh=0)
	else
		BEGIN	
			create table #table1 (IdDh int,MaDh nvarchar(20),InForSp nvarchar(max),IdKh int,
								TenKh nvarchar(50),NguoiNhan nvarchar(50),DiaChi nvarchar(100),GhiChu nvarchar(500),
								TongTien decimal,Giamgia int,Ship decimal,TongTienThanhToan decimal,Sdt nvarchar(20),
								PaymentName nvarchar(50),CreateDate datetime); --bảng tạm phải đủ các cột vs bảng chính
			insert into #table1 
			EXEC sp_print_order @iddh;
			SELECT @count = COUNT(*) FROM #table1;
			if @count >0
				--begin --dùng con trỏ để lấy 
				--	declare @currentId INT;
				--	declare order_cursor cursor for 
				--		select IdDh from #table1 where IdDh is not null;-- duyệt lấy từng iddh trong bảng tạm
				--	open order_cursor;
				--		fetch next from order_cursor into @currentId;
				--			WHILE @@FETCH_STATUS = 0
				--			begin
				--				select @odS=ODSuccess from DbOrder where IdDh=@currentId;
				--				--EXEC sp_print_order @currentId; --in đơn hàng
				--				if @odS=1
				--					begin
				--						UPDATE DbOrder set ODPrint = 1,ODSuccess=0,ODReadly=1 WHERE  IdDh = @currentId and ODPrint = 0;
				--					end
				--				else
				--					begin
				--						UPDATE DbOrder set ODPrint = 1 WHERE  IdDh = @currentId  and ODPrint = 0;
				--					end
				--				fetch next from order_cursor into @currentId;
				--			end
					
				--		CLOSE order_cursor;
				--		DEALLOCATE order_cursor;
				--		DROP TABLE #table1;
				--	return;
				--end
				begin
					EXEC sp_print_order @iddh
					UPDATE DbOrder set ODPrint = 1 WHERE ODPrint = 0;--,ODSuccess=0,ODReadly=1
					DROP TABLE #table1;
					return;
				end
			else
				begin					
					set @error=N'Tất cả đơn hàng đã được in hết';
					select @error as error;
				end
		END
END;

SET QUOTED_IDENTIFIER ON
GO
-- cập nhật tình trạng in lại đơn hàng
--drop procedure sp_order_reprint_status
-- DECLARE @error NVARCHAR(500); EXEC sp_order_reprint_status @iddh=11, @error = @error OUTPUT; PRINT @error;
CREATE PROCEDURE [dbo].[sp_order_reprint_status] 
    @iddh INT,
	@error nvarchar(500) output
AS
BEGIN
	declare @isreprint bit;
	select @isreprint = od.ODReprint from DbOrder od where od.IdDh = @iddh 
	if @isreprint=0
		begin
			EXEC sp_reprint_order @iddh
			UPDATE DbOrder set ODReprint =1 where IdDh = @iddh;
			return;
		end
	else
		begin
			set @error=N'đơn hàng đã được in lại rồi không thể in lại nữa';
			select @error as error;
			return;
		end
end;

SET QUOTED_IDENTIFIER ON
GO
--update đơn hàng
--DECLARE @error NVARCHAR(500);DECLARE @msg NVARCHAR(500);exec orderupdate @iddh=77,@odsuccess=0,@odreadly=0,@odtransported=0,@complete=0,@odhuy=0,@odreturn=1 ,@modifiedby='bao'
--    ,@msg = @msg OUTPUT,
--    @error = @error OUTPUT;
--SELECT @msg AS Message, @error AS Error;
--drop procedure orderupdate
create procedure [dbo].[orderupdate]
	@iddh int,
	@odsuccess bit,
	@odreadly bit,
	@odtransported bit,
	@complete bit,
	@odhuy bit,
	@odreturn bit,
	@modifiedby nvarchar(50),
	@msg nvarchar(500) output,
	@error nvarchar(500) output
as
begin
	--các thông tin đang có trong đon hangf
	declare @isprint bit;
	declare @isodsuccess bit;
	declare @isodreadly bit;
	declare @isodtransported bit;
	declare @iscomplete bit;
	declare @iscompletedate datetime;
	declare @isodhuy bit;
	declare @isreturn bit;
	DECLARE @hasError BIT = 0;
	begin try	
		select @isprint=od.ODPrint,@isodsuccess=od.ODSuccess,@isodreadly=od.ODReadly,@isodtransported=od.ODTransported,@iscomplete=od.Complete,@isodhuy=od.ODHuy,@isreturn=od.ODReturn, @iscompletedate=od.CompleteDate
			from DbOrder od
			where od.IdDh=@iddh;		
		if @isodreadly=1 and @odsuccess =1
			begin
				set @error=N'Đơn hàng đã sẵn sàng không thể cập nhật về trạng thái này ';
				return;
			end					
		if @isodtransported=1 and (@odreadly =1 or @odsuccess =1)
			begin
				set @error=N'Đơn hàng đang vận chuyển không thể cập nhật về trạng thái này ';
				return;
			end
								
		if @iscomplete=1 and (@odreadly =1 or @odsuccess =1 or @odtransported=1)
			begin
				set @error=N'Đơn hàng đã hoàn thành không thể cập nhật về trạng thái này ';
				return;
			end						
		if @isodhuy=1 and (@odreadly =1 or @odsuccess =1 or @odtransported=1 or @complete=1)
			begin
				set @error=N'Đơn hàng đã hủy không thể cập nhật về trạng thái này ';
				return;
			end								
		if @isreturn=1 and (@odreadly =1 or @odsuccess =1 or @odtransported=1 or @complete=1 or @odhuy=1)
			begin
				set @error=N'Đơn hàng đã hoàn không thể cập nhật về trạng thái này ';
				return;
			end	
		else
			update DbOrder set ODSuccess=@odsuccess,ODReadly=@odreadly,ODTransported=@odtransported,Complete=@complete,ODHuy=@odhuy,ODReturn=@odreturn,ModifiedBy=@modifiedby
				where IdDh=@iddh
				if @complete=1
					begin
						update DbOrder set CompleteDate= GETDATE() 
						where IdDh=@iddh
					end
				if @odhuy=1
					begin
						update od set od.ODSuccess=0, ODReadly=0, ODTransported=0, Complete=0 from DbOrder od where od.IdDh=@iddh
						update pd set pd.Quantity= pd.Quantity + odd.SoLuongSp
							from DbProductDetail pd 
							join DbOrderDetail odd on pd.IdSp=odd.IdSp
							where odd.IdDh=@iddh and pd.ColorId=odd.IdColor and pd.SizeId=odd.IdSize
						set @msg=N'Hủy đơn hàng thành công';
						return;
					end
				if @odreturn=1 and @iscomplete=1 and DATEDIFF(DAY, @iscompletedate, GETDATE()) < 7
					begin
						update od set od.ODSuccess=0, ODReadly=0, ODTransported=0, Complete=0,ODHuy=0,ODReturn=1,ModifiedBy=@modifiedby from DbOrder od where od.IdDh=@iddh
						set @msg=N'Yêu cầu hoàn đơn hàng thành công';
						return;						
					end					
				if @odreturn=1 and @iscomplete=1 and DATEDIFF(DAY, @iscompletedate, GETDATE()) > 7
					begin
						set @msg=N'Đơn hàng đã vượt quá số ngày cho phép hoàn, ko thể hoàn hàng';
						return;	
					end
			set @msg=N'Cập nhật đơn hàng thành công';
	end try
	begin catch
		set @error=N'Cập nhật đơn hàng thất bại'+ERROR_MESSAGE();
	end catch
end;
/*Product*/
SET QUOTED_IDENTIFIER ON
GO
--lưu thông tin thay đổi khi sửa Sản phẩm
--drop trigger trg_AfterUpdateProduct
create trigger trg_AfterUpdateProduct
on DbProduct
after update
as
begin
	set nocount on;
	insert into DbHistory(TableName,TableId,OldValue,NewValue,ModifiedDate,ModifiedBy)
	select
		'DbProduct'as TableName,
		i.IdSp as TableId,
		(
            SELECT 
                CASE WHEN d.IdDm <> i.IdDm THEN d.IdDm ELSE NULL END AS Old_IdDm,
                CASE WHEN d.TenSp <> i.TenSp THEN d.TenSp ELSE NULL END AS Old_TenSp,
                CASE WHEN d.AnhSp <> i.AnhSp THEN d.AnhSp ELSE NULL END AS Old_AnhSp,
                CASE WHEN d.PriceMax <> i.PriceMax THEN d.PriceMax ELSE NULL END AS Old_PriceMax,
                CASE WHEN d.GiamGia <> i.GiamGia THEN d.GiamGia ELSE NULL END AS Old_GiamGia,
                CASE WHEN d.PriceMin <> i.PriceMin THEN d.PriceMin ELSE NULL END AS Old_PriceMin,
                CASE WHEN d.MotaSp <> i.MotaSp THEN d.MotaSp ELSE NULL END AS Old_MotaSp
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS OldValue,
        (
            SELECT 
                CASE WHEN d.IdDm <> i.IdDm THEN i.IdDm ELSE NULL END AS New_IdDm,
                CASE WHEN d.TenSp <> i.TenSp THEN i.TenSp ELSE NULL END AS New_TenSp,
                CASE WHEN d.AnhSp <> i.AnhSp THEN i.AnhSp ELSE NULL END AS New_AnhSp,
                CASE WHEN d.PriceMax <> i.PriceMax THEN i.PriceMax ELSE NULL END AS New_PriceMax,
                CASE WHEN d.GiamGia <> i.GiamGia THEN i.GiamGia ELSE NULL END AS New_GiamGia,
                CASE WHEN d.PriceMin <> i.PriceMin THEN i.PriceMin ELSE NULL END AS New_PriceMin,
                CASE WHEN d.MotaSp <> i.MotaSp THEN i.MotaSp ELSE NULL END AS New_MotaSp
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS NewValue,
		GETDATE() as ModifiedDate,
		i.ModifiedBy as ModifiedBy
	from inserted i
	INNER JOIN deleted d ON i.IdSp = d.IdSp
	WHERE 
        d.IdDm <> i.IdDm OR
        d.TenSp <> i.TenSp OR
        d.AnhSp <> i.AnhSp OR
        d.PriceMax <> i.PriceMax OR
        d.GiamGia <> i.GiamGia OR
        d.PriceMin <> i.PriceMin OR
        d.MotaSp <> i.MotaSp;
end;

--SET QUOTED_IDENTIFIER ON
--GO
--tất cả sản phẩm
--drop procedure product_showall
--create procedure [dbo].[product_showall]
--as
--begin
--	select p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,SUM(pd.SoLuongBan) as LuotSold,SUM(pd.Quantity) as Quantity,
--			p.IActive,p.IHot,p.ISale,p.IFeature
--	from DbProduct p
--	join DbCategory c on p.IdDm=c.IdDm
--	join DbGroup g on p.NhomId=g.IdNhom
--	join DbProductDetail pd on p.IdSp=pd.IdSp
--	group by p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,p.LuotSold,
--			p.IActive,p.IHot,p.ISale,p.IFeature
--	order by p.IdSp desc
--end;

SET QUOTED_IDENTIFIER ON
GO
--tìm kiếm sản phẩm
--drop procedure product_search
create procedure [dbo].[product_search]
	@keyword nvarchar(50)=null
as
begin
	select p.IdSp,p.MaSp,p.AnhSp,p.TenSp,p.PriceMax,p.PriceMin,p.GiamGia,c.TenDm,g.GroupName,SUM(pd.SoLuongBan) as LuotSold,SUM(pd.Quantity) as Quantity,
			p.IActive,p.IHot,p.ISale,p.IFeature
	from DbProduct p
	join DbCategory c on p.IdDm=c.IdDm
	join DbGroup g on p.NhomId=g.IdNhom
	join DbProductDetail pd on p.IdSp=pd.IdSp
	where @keyword IS NULL OR p.MaSp like '%'+@keyword+'%' or p.TenSp like '%'+@keyword+'%' or c.TenDm like '%'+@keyword+'%'
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
	@classify nvarchar(10),
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
		insert into DbProduct (IdDm,TenSp,NhomId,AnhSp,Classify,PriceMax,GiamGia,PriceMin,MotaSp,IActive,IFeature,IFavorite,IHot,ISale,CreateBy,CreateDate,LuotXem) 
		values (@iddm,@tensp,@nhomid,@anhsp,@classify,@pricemax,@giamgia,@pricemin,@motasp,@iactive,@ifeature,@ihot,@isale,@ifavorite,@createby,GETDATE(),0)

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
	declare @ma nvarchar(50);
	declare @sz nvarchar(10);
	declare @cl nvarchar(10);
	select @ma=c.MaDm, @sz=s.MaSize, @cl=cl.MaColor from DbCategory c  
		join DbProduct p on p.IdDm = c.IdDm
		join DbSize s on s.SizeId= @sizeid 
		join DbColor cl on cl.ColorId=@colorid
		where p.IdSp= @idsp
	begin try
		insert into DbProductDetail (IdSp,ColorId,NameColor,SizeId,NameSize,GiaLoai,Quantity,SoLuongBan,MaCTSP)
		values (@idsp,@colorid,@namecolor,@sizeid,@namesize,@gialoai,@soluong,0,@ma + @cl +@sz)
	end try
	begin catch
		set @error=N'lỗi không thêm đc các thông tin chi tiết ảnh vào bảng DbProductDetail'+ ERROR_MESSAGE();
	end catch
end;

SET QUOTED_IDENTIFIER ON
GO
--nhập số lượng nhập vào bảng chi tiết sản phẩm
--exec insert_quantity_stock @soluong= 50, @mactsp=shortlinenghiM
--drop procedure insert_quantity_stock
create procedure [dbo].[insert_quantity_stock]
	@mactsp nvarchar(50),
	@soluong int
as
begin
	update DbProductDetail set Quantity = Quantity + @soluong where MaCTSP=@mactsp
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
--exec revenue_showall @month=1, @year=2024
--drop procedure revenue_showall 
create procedure [dbo].[revenue_showall]
	@Month INT = NULL, 
    @Year INT = NULL  
as
begin 
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

	--các tháng có doanh thu trong năm 
	WITH
	DoanhThuThang AS (
		SELECT 
			MONTH(CreateDate) AS Thang,
			SUM(TongTienThanhToan) AS TongDoanhThu
		FROM DbOrder
		WHERE 
			YEAR(CreateDate) = @Year AND Complete = 1
		GROUP BY MONTH(CreateDate) --xếp theo từng tháng
	),
	--tất cả 12 tháng trong năm
	Thang AS (
		SELECT 1 AS Thang UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
		SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
		SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
	),
	--tổng hợp daonh thu của 12 tháng 
	DoanhThuDayDu AS (
		SELECT 
			t.Thang,
			ISNULL(dt.TongDoanhThu, 0) AS TongDoanhThu
		FROM Thang t
		LEFT JOIN DoanhThuThang dt ON t.Thang = dt.Thang
	)
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
        COUNT(CASE WHEN od.ODHuy = 1 THEN 1 ELSE NULL END) AS DHHuy,

		(
			select STRING_AGG(
				CAST(Thang AS VARCHAR) + ': ' + CAST(TongDoanhThu AS VARCHAR),
				' | '
			)
			FROM DoanhThuDayDu
		) AS DoanhThuTongHop
    FROM DbOrder od
    WHERE od.CreateDate >= @StartDate AND od.CreateDate <= @EndDate;
end;

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

--báo cáo 1
--drop procedure Report_Inventory
--exec Report_Inventory @keyword = 'phonghoathoaden',@quantity=0
create procedure [dbo].[Report_Inventory]
	@keyword nvarchar(50),-- mã chi tiết sản phẩm, tên ...
	@quantity int--số lượng tồn cần show
as 
begin
    if @keyword is not null and @quantity <= 0
		begin
			SELECT p.IdSp, p.MaSp, pd.MaCTSP, p.TenSp, cl.NameColor, sz.NameSize, pd.Quantity
				FROM DbProductDetail pd 
				JOIN DbProduct p ON p.IdSp = pd.IdSp
				JOIN DbColor cl ON pd.ColorId = cl.ColorId
				JOIN DbSize sz ON pd.SizeId = sz.SizeId
				WHERE (@keyword IS NULL OR LTRIM(RTRIM(@keyword)) = '' OR pd.MaCTSP LIKE N'%' + @keyword + '%'OR p.TenSp LIKE N'%' + @keyword + '%')
				ORDER BY pd.Quantity
		end
    if @keyword= null and @quantity >0
		begin			
			SELECT p.IdSp, p.MaSp, pd.MaCTSP, p.TenSp, cl.NameColor, sz.NameSize, pd.Quantity
				FROM DbProductDetail pd 
				JOIN DbProduct p ON p.IdSp = pd.IdSp
				JOIN DbColor cl ON pd.ColorId = cl.ColorId
				JOIN DbSize sz ON pd.SizeId = sz.SizeId
				WHERE pd.Quantity < @quantity 
				ORDER BY pd.Quantity ASC
		end
    -- Truy vấn 
	else
		begin		
			SELECT p.IdSp, p.MaSp, pd.MaCTSP, p.TenSp, cl.NameColor, sz.NameSize, pd.Quantity
				FROM DbProductDetail pd 
				JOIN DbProduct p ON p.IdSp = pd.IdSp
				JOIN DbColor cl ON pd.ColorId = cl.ColorId
				JOIN DbSize sz ON pd.SizeId = sz.SizeId
				WHERE (pd.Quantity < @quantity) and
					(@keyword IS NULL OR LTRIM(RTRIM(@keyword)) = '' OR pd.MaCTSP LIKE N'%' + @keyword + '%'OR p.TenSp LIKE N'%' + @keyword + '%')
				ORDER BY pd.Quantity ASC
		end
end;

--báo cáo 2 
--drop procedure Report_Revenue
--DECLARE @msg NVARCHAR(500);
--DECLARE @error NVARCHAR(500);
--exec Report_Revenue @keyword = '',@quantity=100, @msg = @msg OUTPUT, @error = @error OUTPUT;SELECT @msg AS Message, @error AS Error;
create procedure [dbo].[Report_Revenue]
	@date datetime,-- từ ngày
	@todate datetime--,tới ngày
	
    --@msg NVARCHAR(500) OUTPUT,
    --@error NVARCHAR(500) OUTPUT
as 
begin	
    -- Truy vấn chính
    SELECT  CAST(od.CreateDate AS DATE) AS Ngay,
			count(od.IdDh)as Tongdonhang,
			SUM(od.soluong) as Tongsanpham,
			SUM(od.TongTien) as Tongtien,
			SUM(od.TongTienThanhToan) as Tongtienthanhtoan,
			(SUM(od.TongTien)-SUM(od.TongTienThanhToan)) as Vouchergiam
			--(select COUNT(*)
			--		from DbOrder od2
			--		where od2.Complete = 1 and	od2.CreateDate >= '2025/01/01' and od2.CreateDate <= '2025/02/01'
			--) as Tongdonhoanthanh,
			--(select COUNT(*)
			--		from DbOrder od3
			--		where od3.ODHuy = 1 and	od3.CreateDate >= '2025/01/01' and od3.CreateDate <= '2025/02/01'
			--) as Tongdonhuy
		FROM DbOrder od 
		WHERE od.CreateDate >= @date and od.CreateDate <= @todate and od.Complete=1
		group by CAST(od.CreateDate AS DATE)
		order by Ngay
		--WHERE od.CreateDate >= @date and od.CreateDate <= @todate
		    
end;
