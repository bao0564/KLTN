using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Extension;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Diagnostics;
using System.Linq;
using X.PagedList;

namespace KLTN_YourLook.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
		private readonly YourlookContext _context;
		private readonly SP_Product _productProcedure;

        public HomeController(ILogger<HomeController> logger,YourlookContext context, SP_Product productProcedure )
        {
            _logger = logger;
			_context = context;
			_productProcedure = productProcedure;
        }

		//trang chủ 
		public IActionResult Index()
		{
			var prdCart = HttpContext.Session.GetJson<List<ShoppingCartItem>>("Cart") ?? new List<ShoppingCartItem>();
			ViewBag.CartItemCount = prdCart.Sum(i => i.ProductQuantity);
			var email = HttpContext.Session.GetString("userEmail");
			if (email != null)
			{
				var user = GetEmailKhachHang(email);
			}
			return View();
		}
		private DbCustomer GetEmailKhachHang(string email)
		{
			using (var db = new YourlookContext())
			{
				return _context.DbCustomers.FirstOrDefault(x => x.Email == email);
			}
		}
		private DbCustomer GetIdKhachHang(int id)
		{
			using (var db = new YourlookContext())
			{
				return _context.DbCustomers.FirstOrDefault(x => x.IdKh == id);
			}
		}

		//tìm từ khóa
		public async Task<IActionResult> KeyWord(int? page, string keyword)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;

            var idkh = HttpContext.Session.GetInt32("userId");
            var idFvrPrd = new List<int>();
            if (idkh != null)
            {
                idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
            }
			//if (keyword == null)
			//{
			//	return RedirectToAction("Index","Home");
			//}
            var lst = await _productProcedure.User_Search_Product(keyword);
            ViewBag.keyword = keyword;
            foreach (var prd in lst)
            {
                prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
            }
            PagedList<ViewAllDetail> lstcatesp = new PagedList<ViewAllDetail>(lst, pageNumber, pageSize);
            return View(lstcatesp);
        }
		//hiển thị gọi ý tìm kiếm
		[HttpGet]		
		public async Task<JsonResult> SuggetResult(string keyword)
		{
            var lst = await _productProcedure.User_Search_Sugget(keyword);
			var result = lst.Select(x => new 
			{  
				IdSp=x.IdSp,//vào json là idSp,tenSp, anhSp :)))))
                TenSp = x.TenSp,
                AnhSp = x.AnhSp
			}).ToList();            
            return Json(result);
        }
		//all sp
		public async Task<IActionResult> AllProduct(int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>(); //danh sách yêu thích trống (false)
			if (idkh != null)
			{
				//nếu kh đã đăng nhập lấy thông tin sp yêu thích của kh đưa vào ds
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var prdlst = await _productProcedure.Product_View();
			foreach (var prd in prdlst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp); //đánh dấu sp yêu thích
			}
			PagedList<ViewAllDetail> lstsp = new PagedList<ViewAllDetail>(prdlst, pageNumber, pageSize);
			return View(lstsp);
		}
		//
		public async Task<IActionResult> SaleProduct(int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var salelst = await _productProcedure.Product_Sale_View();
			foreach (var prd in salelst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstsp = new PagedList<ViewAllDetail>(salelst, pageNumber, pageSize);
			return View(lstsp);
		}
		//
		public async Task<IActionResult> NewProduct(int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			DateTime prdNew = DateTime.Now.AddDays(-30);
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var newlst =await _productProcedure.Product_New_View();
			foreach (var prd in newlst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstNew = new PagedList<ViewAllDetail>(newlst, pageNumber, pageSize);
			return View(lstNew);
		}
		//
		public async Task<IActionResult> HotProduct(int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var hotlst = await _productProcedure.Product_Hot_View();
			foreach (var prd in hotlst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstHot = new PagedList<ViewAllDetail>(hotlst, pageNumber, pageSize);
			return View(lstHot);
		}
		//
		public async Task <IActionResult> UnderProduct(int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var ulst = await _productProcedure.Product_QL_View();
			foreach (var prd in ulst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstNew = new PagedList<ViewAllDetail>(ulst, pageNumber, pageSize);
			return View(lstNew);
		}
		//
		public async Task<IActionResult> ProductCategory(int? page)
		{
			int pageSize = 15;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var lstcate = await _productProcedure.Product_View();
            foreach (var prd in lstcate)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstcatesp = new PagedList<ViewAllDetail>(lstcate, pageNumber, pageSize);
			return View(lstcatesp);
		}
		//
		public async Task<IActionResult> ProductTipe(int idnhom, int? page)
		{
			int pageSize = 25;
			int pageNumber = page ?? 1;
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var lstProductTipe = await _productProcedure.Product_By_Idnhom(idnhom);
			foreach (var prd in lstProductTipe)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			PagedList<ViewAllDetail> lstprdbytipe = new PagedList<ViewAllDetail>(lstProductTipe, pageNumber, pageSize);
			return View(lstprdbytipe);
		}
		//chi tiết sản phẩm 
		public async Task<IActionResult> ProductDetail(int idsp)
		{
			var lstSanPham = await _productProcedure.Product_Detail(idsp);
			var idkh = HttpContext.Session.GetInt32("userId");
			var SanPham=lstSanPham.FirstOrDefault();
			if (lstSanPham == null || !lstSanPham.Any() || SanPham==null)
			{
				return NotFound(); // Nếu không tìm thấy sản phẩm, trả về lỗi 404
			}
            //Đã thay thêm lượt xem trực tiếp vì dùng trigger sẽ bị lỗi // đã thêm 1 đoạn + lượt xem trong dapper SP:Product_Detail
            //if (lstSanPham != null)
            //{
            //	SanPham.LuotXem = SanPham.LuotXem + 1;
            //	var prd = await _context.DbProducts.FindAsync(idsp);
            //	if (prd != null)
            //	{
            //		prd.LuotXem = SanPham.LuotXem;
            //		await _context.SaveChangesAsync();
            //	}
            //};
            if (idkh != null)
			{
				SanPham.IsFavorite = _context.DbFavoriteProducts.Any(x => x.IdKh == idkh.Value && x.IdSp == idsp);
			}
			return View(SanPham);
		}
		//lấy các thông tin trong chi tiết ssanr phẩm 
		[HttpGet("api/productdetails")]
		public async Task<IActionResult> GetProductDetail(int idsp)
		{
			var prddt=await _productProcedure.Product_Detail(idsp);
			if (prddt == null || !prddt.Any())
			{
				return NotFound(new { message = "Sản phẩm không tồn tại hoặc không có dữ liệu." });
			}
			return Ok(prddt);
		}
		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
