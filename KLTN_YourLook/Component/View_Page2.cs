﻿using Data.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Component
{
	public class View_Page2 : ViewComponent
	{
		private readonly YourlookContext _context;
		private readonly SP_Product _productRepository;
		public View_Page2(YourlookContext context, SP_Product productRepository)
		{
			_context = context;
			_productRepository = productRepository;
		}
		public async Task<IViewComponentResult> InvokeAsync()
		{
			int iddm = 8;//Quần short
			var idkh = HttpContext.Session.GetInt32("userId");
			var idFvrPrd = new List<int>();
			if (idkh != null)
			{
				idFvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh.Value).Select(x => x.IdSp).ToList();
			}
			var page2lst = await _productRepository.Product_By_Iddm(iddm);
			foreach (var prd in page2lst)
			{
				prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
			}
			return View(page2lst);
		}
	}
}
