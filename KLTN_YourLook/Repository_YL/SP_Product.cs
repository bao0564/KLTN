using Dapper;
using Data.Models;
using KLTN_YourLook.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace KLTN_YourLook.Repository_YL
{
	public class SP_Product : Controller
	{
		private readonly IDbConnection _dbConnection;//dùng như dbcontext
        private readonly YourlookContext _context;
        public SP_Product(IDbConnection dbConnection, YourlookContext context)
        {
            _dbConnection = dbConnection;
            _context = context;
        }

        //hiển thị các sản phẩm trên giao diện 
        private List<ViewAllDetail> MapToViewAllDetails(IEnumerable<ViewAllDetailRaw> lstraw)
		{
			return lstraw.Select(x => new ViewAllDetail
			{
				IdSp = x.IdSp,
				MaSp = x.MaSp,
				TenSp = x.TenSp,
				AnhSp = x.AnhSp,
				PriceMax = x.PriceMax,
				GiamGia = x.GiamGia,
				PriceMin = x.PriceMin,
				IFavorite = x.IFavorite,
				LuotXem = x.LuotXem,
				Sizes = x.Sizes.Split(';')//tách lần 1
						.Select(y =>
						{
							var s = y.Split(',');//tách lần 2
							return new ViewSize
							{
								SizeId = int.Parse(s[0]),
								NameSize = s[1]
							};
						}).DistinctBy(s => s.SizeId)//loại bỏ trùng lặp
						.ToList(),
				Colors = x.Colors.Split(';')
						.Select(y =>
						{
							var c = y.Split(',');
							return new ViewColor
							{
								ColorId = int.Parse(c[0]),
								NameColor = c[1],
								MaColor = c[2],
								MaHex = c[3]
							};
						}).DistinctBy(c => c.ColorId)
						.ToList()
			}).ToList();
		}
		//all sản phẩm
		public async Task<List<ViewAllDetail>> Product_View()
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("EXEC product_view");
			var lst = lstraw.Select(x => new ViewAllDetail
			{
				IdSp = x.IdSp,
				MaSp = x.MaSp,
				TenSp = x.TenSp,
				AnhSp = x.AnhSp,
				PriceMax = x.PriceMax,
				GiamGia = x.GiamGia,
				PriceMin = x.PriceMin,
				IFavorite = x.IFavorite,
				LuotXem = x.LuotXem,
				Sizes = x.Sizes.Split(';')//tách lần 1
						.Select(y =>
						{
							var s = y.Split(',');//tách lần 2
							return new ViewSize
							{
								SizeId = int.Parse(s[0]),
								NameSize = s[1]
							};
						}).DistinctBy(s => s.SizeId)//loại bỏ trùng lặp
						.ToList(),
				Colors = x.Colors.Split(';')
						.Select(y =>
						{
							var c = y.Split(',');
							return new ViewColor
							{
								ColorId = int.Parse(c[0]),
								NameColor = c[1],
								MaColor = c[2],
                                MaHex = c[3]
                            };
						}).DistinctBy(c => c.ColorId)
						.ToList()
			});
			return lst.ToList();
		}
		//sản phẩm sale
		public async Task<List<ViewAllDetail>> Product_Sale_View()
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("EXEC product_sale_view");
			return MapToViewAllDetails(lstraw);
		}
		//sản phẩm new
		public async Task<List<ViewAllDetail>> Product_New_View()
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("EXEC product_new_view");
			return MapToViewAllDetails(lstraw);
		}
		//sản phẩm hot
		public async Task<List<ViewAllDetail>> Product_Hot_View()
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("EXEC product_hot_view");
			return MapToViewAllDetails(lstraw);
		}
		//sản phẩm underwear
		public async Task<List<ViewAllDetail>> Product_QL_View()
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("EXEC product_ql_view");
			return MapToViewAllDetails(lstraw);
		}
		//san pham theo danh mục
		public async Task<List<ViewAllDetail>> Product_By_Iddm(int iddm)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
			var lstraw= await _dbConnection.QueryAsync<ViewAllDetailRaw>("product_by_iddm", new { iddm = iddm }, commandType: CommandType.StoredProcedure);
			return MapToViewAllDetails(lstraw);
        }
		//chi tiết sản phẩm
		public async Task<List<ViewProductDetail>> Product_Detail(int idsp)
		{
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var lstraw = await _dbConnection.QueryAsync<ProductDetailViewModelRaw>("product_detail",new {idsp=idsp},commandType: CommandType.StoredProcedure);
            
            var lst = lstraw.Select(x => new ViewProductDetail
			{
				IdSp = idsp,
				MaSp = x.MaSp,
				TenDm = x.TenDm,
				TenSp = x.TenSp,
				SaoDanhGia = x.SaoDanhGia,
				AnhSp = x.AnhSp,
				PriceMax = x.PriceMax,
				GiamGia = x.GiamGia,
				PriceMin = x.PriceMin,
				LuotXem = x.LuotXem,
				LuotSold = x.LuotSold,
				MotaSp = x.MotaSp,
				IsFavorite = x.IsFavorite,
				ImgDetail = x.ImgDetail.Split(';')
							.Select(y => new ViewDetailImg
							{
								Img = y
							}).ToList(),
				Detail=x.Detail.Split(';')
							.Select(y =>
							{
								var s = y.Split(',');
								return new ViewDetail
								{
									SizeId = int.Parse(s[0]),
									NameSize = s[1],
									ColorId = int.Parse(s[2]),
									NameColor = s[3],
									MaColor = s[4],
									MaHex = s[5],
									GiaLoai = decimal.Parse(s[6]),
									Quantity = int.Parse(s[7])
								};
							}).ToList()
			});
			return lst.ToList();
		}
	}
}
