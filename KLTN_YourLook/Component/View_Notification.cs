using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Component
{
    public class View_Notification:ViewComponent
    {
        private readonly YourlookContext _context;
        public View_Notification(YourlookContext context)
        {
            _context = context;
        }
        public async Task<IViewComponentResult> InvokeAsync(string place)
        {
            var result = await _context.DbNotifications.OrderByDescending(x=>x.CreateDate).ToListAsync();
            return View(result);
        }
    }
}
