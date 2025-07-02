using Dapper;
using Data.Models;
using KLTN_YourLook.Models;
using Mailjet.Client.Resources;
using Microsoft.AspNetCore.Http;
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
        //tìm kiếm sản phẩm
        public async Task<List<ViewAllDetail>> User_Search_Product(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("sp_user_search_product", parameters,commandType:CommandType.StoredProcedure);
            return MapToViewAllDetails(lstraw);
        }
        //gợi ý tìm kiếm
        public async Task<List<ViewSugget>> User_Search_Sugget(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            var lst = await _dbConnection.QueryAsync<ViewSugget>("sp_user_search_sugget", parameters, commandType: CommandType.StoredProcedure);			
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
		//san pham theo nhóm
		public async Task<List<ViewAllDetail>> Product_By_Idnhom(int idnhom)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
			var lstraw= await _dbConnection.QueryAsync<ViewAllDetailRaw>("product_by_idnhom", new { idnhom = idnhom }, commandType: CommandType.StoredProcedure);
			return MapToViewAllDetails(lstraw);
        }

        //san pham nam theo danh mục các loại Quần
        public async Task<List<ViewAllDetail>> Product_Trousers(int classify)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("sp_product_trousers", new { classify = classify }, commandType: CommandType.StoredProcedure);
            return MapToViewAllDetails(lstraw);
        }
        //san pham nữ theo danh mục các loại Áo
        public async Task<List<ViewAllDetail>> Product_Shirt (int classify)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("sp_product_shirt", new { classify = classify }, commandType: CommandType.StoredProcedure);
            return MapToViewAllDetails(lstraw);
        }
        //san pham nữ theo danh mục các loại thu đông
        public async Task<List<ViewAllDetail>> Product_AW (int classify)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("sp_product_aw", new { classify = classify }, commandType: CommandType.StoredProcedure);
            return MapToViewAllDetails(lstraw);
        }
        //san pham nữ theo danh mục các loại hè thu
        public async Task<List<ViewAllDetail>> Product_SA (int classify)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("sp_product_sa", new { classify = classify }, commandType: CommandType.StoredProcedure);
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
			//
			var lst = lstraw.Select(x => new ViewProductDetail
			{
				IdSp = idsp,
				Rate=x.Rate,
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
				ImgDetail = !string.IsNullOrWhiteSpace(x.ImgDetail) ? x.ImgDetail.Split(';')//tránh sản phẩm ko có ảnh phụ
							.Select(y => new ViewDetailImg
							{
								Img = y
							}).ToList() : new List<ViewDetailImg>(),
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
        //lượt xem sản phẩm
        public async Task<int> Product_View(int idsp)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
			var action=await _dbConnection.ExecuteAsync("UPDATE DbProduct SET LuotXem = LuotXem + 1 WHERE IdSp = @id", new { id = idsp });
			return action;
                
        }
        //Sản phẩm gợi ý
        public async Task<List<ViewAllDetail>> Product_Suggest(int idsp)
		{
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("view_product_suggest", new {idsp=idsp},commandType:CommandType.StoredProcedure);
            return MapToViewAllDetails(lstraw);
        }
		//hiển thị đánh giá của khách hàng cho sản phẩm
		public async Task<List<ViewRattingProduct>> ViewRattings(int idsp)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
			var lst= await _dbConnection.QueryAsync<ViewRattingProduct>("sp_rating_product", new {idsp=idsp}, commandType:CommandType.StoredProcedure);
			return lst.ToList();
        }
    }
}
