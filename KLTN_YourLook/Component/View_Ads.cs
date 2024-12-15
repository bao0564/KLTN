using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
	public class View_Ads : ViewComponent
	{
		private readonly YourlookContext _context;
		public View_Ads(YourlookContext context)
		{
			_context = context;
		}
		public async Task<IViewComponentResult> InvokeAsync(string place)
		{
			var result =await  _context.DbAdss.Where(a=>a.Place == place && a.IsActive).ToListAsync();
			return View(result);
		}
	}
}
