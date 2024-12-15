using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
    public class View_Size:ViewComponent
    {
        private readonly YourlookContext _context;
        public View_Size(YourlookContext context)
        {
            _context = context;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var result = await _context.DbSizes.OrderBy(x => x.SizeId).ToListAsync();
            return View(result);
        }
    }
}
