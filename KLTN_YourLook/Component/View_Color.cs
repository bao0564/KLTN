using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
    public class View_Color:ViewComponent
    {
        private readonly YourlookContext _context;
        public View_Color(YourlookContext context)
        {
            _context = context;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var result = await _context.DbColors.OrderBy(x => x.ColorId).ToListAsync();
            return View(result);
        }
    }
}
