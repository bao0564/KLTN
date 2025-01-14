using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class GroupController : Controller
    {

        private readonly YourlookContext _context;
        private readonly HomeRespository _homeRespository;
        public GroupController(YourlookContext context, HomeRespository homeRespository)
        {
            _context = context;
            _homeRespository = homeRespository;
        }
        //Nhóm sản phẩm
        [Route("group")]
        public async Task<IActionResult> Group(int? page, string keyword)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstgr = _context.DbGroups.OrderByDescending(x => x.IdNhom);
            PagedList<DbGroup> lst = new PagedList<DbGroup>(lstgr, pageNumber, pageSize);
            return View(lst);
        }
    }
}
