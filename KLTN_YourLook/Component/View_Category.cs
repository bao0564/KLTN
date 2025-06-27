using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
    public class View_Category:ViewComponent
    {
        private readonly YourlookContext _context;
        public View_Category(YourlookContext context)
        {
            _context = context;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var result = await _context.DbGroups.OrderBy(x => x.IdNhom).ToListAsync();
            return View(result);
        }
    }
}
