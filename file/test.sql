
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
	select * from DbProduct
	
	  delete DbAdmin
	select * from DbGroup
	select * from DbCustomer
	select * from DbOrderDetail
	select * from DbOrder
	select * from DbAddress
	select * from DbCart
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