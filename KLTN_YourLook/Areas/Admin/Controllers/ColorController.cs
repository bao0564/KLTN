using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

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
            //var name = HttpContext.Session.GetString("NameAdmin");
            //if (name == null)
            //{
            //    return RedirectToAction("Login", "HomeAdmin");
            //}
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
            return View();
        }
        [Route("creatcolor")]
        [HttpPost]
        public async Task<IActionResult> ColorCreat(DbColor model)
        {
            if (ModelState.IsValid)
            {
                var s = await _colorRepository.CreateColor(
                        model.MaColor,
                        model.NameColor,
                        model.Img ?? "",
                        "bao"
                    );

                if (s == 2) //@ret = 2 là thành công
                {
                    TempData["SuccessMessage"] = "Color đã được tạo thành công!";
                    return RedirectToAction("Color");
                }
                else
                {
                    ModelState.AddModelError("", "Không thể tạo color. Vui lòng thử lại.");
                }
            }
            return View(model);
        }
        //sửa color
        [Route("updatecolor")]
        [HttpGet]
        public IActionResult ColorUpdate(int idcl)
        {
            var color = _context.DbColors.Find(idcl);
            return View(color);
        }
        [Route("updatecolor")]
        [HttpPost]
        public async Task<IActionResult> ColorUpdate(DbColor model)
        {
            if (ModelState.IsValid)
            {
                var cl =await _colorRepository.UpdateColor(
                        model.ColorId,
                        model.MaColor,
                        model.NameColor,
                        model.Img ?? "",
                        "Bao2"
                    );
                return RedirectToAction("Color");
            }
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
                var s = await _colorRepository.DeleteColor(idcl);
            }
            TempData["Message"] = "Màu ĐÃ ĐƯỢC XÓA";
            return RedirectToAction("Color");
        }

        //kiểm tra mã trùng lặp trong js
        [HttpGet]
        [Route("colorcheck")]
        public async Task<IActionResult> colorcheck(string macl)
        {
            var exists = await _context.DbColors.AnyAsync(x => x.MaColor == macl);
            return Json(new { exists });
        }
    }
}
