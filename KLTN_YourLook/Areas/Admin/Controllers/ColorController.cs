using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class ColorController : Controller
    {
        private readonly YourlookContext _context;
        private readonly ColorRepository _colorRepository; //các procedure được đặt ở đây
        public ColorController(YourlookContext context, ColorRepository colorRepository)
        {
            _context = context;
            _colorRepository = colorRepository;
        }
        //color
        [Route("color")]
        [HttpGet]
        public IActionResult Color(int? page)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstColor = _context.DbColors.OrderBy(x => x.ColorId);
            PagedList<DbColor> lst = new PagedList<DbColor>(lstColor, pageNumber, pageSize);
            return View(lst);
        }
        //tạo màu
        [Route("creatcolor")]
        [HttpGet]
        public IActionResult ColorCreat()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        [Route("creatcolor")]
        [HttpPost]
        public async Task<IActionResult> ColorCreat(DbColor model)
        {
            if (ModelState.IsValid)
            {
                var (msg,error) = await _colorRepository.CreateColor(model.NameColor,model.MaHex, model.Img ?? "", "bao" );
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"]=error;
                    return View(model);
                }
                TempData["Success"] = msg;

                return RedirectToAction("color");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
        //sửa color
        [Route("updatecolor")]
        [HttpGet]
        public IActionResult ColorUpdate(int idcl)
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
            var color = _context.DbColors.Find(idcl);
            return View(color);
        }
        [Route("updatecolor")]
        [HttpPost]
        public async Task<IActionResult> ColorUpdate(DbColor model)
        {
            if (ModelState.IsValid)
            {
                var (msg,error) =await _colorRepository.UpdateColor(model.ColorId, model.NameColor,model.MaHex, model.Img ?? "", "Bao2");
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error;
                    return View(model);
                }
                TempData["Success"] = msg;

                return RedirectToAction("color");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
        //xóa color
        [Route("deletecolor")]
        [HttpGet]
        public async Task<IActionResult> ColorDelete(int idcl)
        {
            TempData["Message"] = "";
            var ctsp = _context.DbProductDetails.Any(x => x.ColorId == idcl);
            if (ctsp)
            {
                TempData["Message"] = "Màu ĐÃ CÓ SẢN PHẨM DÙNG - KHÔNG THỂ XÓA- chỉ được sửa";
                return RedirectToAction("Color");
            }
            var color = _context.DbColors.Find(idcl);
            if (color != null)
            {
                var (msg,error) = await _colorRepository.DeleteColor(idcl);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Message"] = error;
                }
                TempData["Success"] = msg;
            }
            return RedirectToAction("Color");
        }

        ////kiểm tra mã trùng lặp trong js
        //[HttpGet]
        //[Route("colorcheck")]
        //public async Task<IActionResult> colorcheck(string macl)
        //{
        //    var exists = await _context.DbColors.AnyAsync(x => x.MaColor == macl);
        //    return Json(new { exists });
        //}
    }
}
