using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class SizeController : Controller
    {
        private readonly YourlookContext _context;
        private readonly SizeRepository _sizeRepository; //các procedure được đặt ở đây
        public SizeController(YourlookContext context, SizeRepository sizeRepository)
        {
            _context = context;
            _sizeRepository = sizeRepository;
        }
        //size
        [Route("size")]
        [HttpGet]
        public IActionResult Size(int? page)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstSize = _context.DbSizes.OrderBy(x => x.SizeId);
            PagedList<DbSize> lst = new PagedList<DbSize>(lstSize, pageNumber, pageSize);
            return View(lst);
        }
        //tạo size
        [Route("creatsize")]
        [HttpGet]
        public IActionResult SizeCreat()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        [Route("creatsize")]
        [HttpPost]
        public async Task<IActionResult> SizeCreat(DbSize model)
        {
            if (ModelState.IsValid)
            {
                var (msg,error) = await _sizeRepository.CreateSize(model.MaSize,model.NameSize,"bao");
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error;
                }
                TempData["Success"] = msg;

                return RedirectToAction("size");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
        //sửa size
        [Route("updatesize")]
        [HttpGet]
        public IActionResult SizeUpdate(int idsize)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            var role = HttpContext.Session.GetString("Role");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else if (role != "Admin" && role != "Manager")
            {
                TempData["Error"] = "Bạn không có quyền truy cập trang này";
                return RedirectToAction("Error", "Admin");
            }
            var Size = _context.DbSizes.Find(idsize);
            return View(Size);
        }
        [Route("updatesize")]
        [HttpPost]
        public async Task<IActionResult> SizeUpdate(DbSize model)
        {
            if (ModelState.IsValid)
            {
                var (msg, error)= await _sizeRepository.UpdateSize(
                        model.SizeId,
                        model.MaSize,
                        model.NameSize,
                        "Bao2"
                    );
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error;
                }
                TempData["Success"] = msg;
                return RedirectToAction("Size");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
        //xóa size
        [Route("deletesize")]
        [HttpGet]
        public async Task<IActionResult> SizeDelete(int idsize)
        {
            TempData["Message"] = "";
            var ctsp = _context.DbProductDetails.Any(x => x.SizeId == idsize);
            if (ctsp)
            {
                TempData["Message"] = "Size ĐÃ CÓ SẢN PHẨM DÙNG - KHÔNG THỂ XÓA- chỉ được sửa";
                return RedirectToAction("Size");
            }
            var size = _context.DbSizes.Find(idsize);
            if (size != null)
            {
                var (msg, error) = await _sizeRepository.DeleteSize(idsize);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Message"] = error;
                }
                TempData["Success"] = msg;
            }
            return RedirectToAction("Size");
        }

        ////kiểm tra mã sp trùng lặp trong js
        //[HttpGet]
        //[Route("sizecheck")]
        //public async Task<IActionResult> sizecheck(string masize)
        //{
        //    var exists = await _context.DbSizes.AnyAsync(x => x.MaSize == masize);
        //    return Json(new { exists });
        //}
    }
}
