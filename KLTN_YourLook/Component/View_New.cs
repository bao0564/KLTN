using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Component
{
	public class View_New:ViewComponent
	{
		private readonly YourlookContext _context;
		private readonly SP_Product _productRepository;
		public View_New(YourlookContext context, SP_Product productRepository)
		{
			_context = context;
			_productRepository = productRepository;
		}
		public async Task<IViewComponentResult> InvokeAsync()
		{
			var idkh = HttpContext.Session.GetInt32("userid");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var newlst = await _productRepository.Product_New_View();
			foreach (var prd in newlst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			return View(newlst);
		}
	}
}
