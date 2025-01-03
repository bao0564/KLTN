using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
	public class View_Hot:ViewComponent
	{
		private readonly YourlookContext _context;
		private readonly SP_Product _productRepository;
		public View_Hot(YourlookContext context,SP_Product productRepository)
		{
			_context = context;
			_productRepository = productRepository;
		}
		public async Task<IViewComponentResult> InvokeAsync()
		{
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var hotlst =await _productRepository.Product_Hot_View();
			foreach(var prd in hotlst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			return View(hotlst);
		}
	}
}
