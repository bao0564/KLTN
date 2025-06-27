using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
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
        private readonly GroupRepository _groupRepository; //các procedure được đặt ở đây
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly Iuploadimg _uploadimg;
        public GroupController(YourlookContext context, GroupRepository groupRespository, IWebHostEnvironment webHostEnvironment, Iuploadimg iuploadimg)
        {
            _context = context;
            _groupRepository = groupRespository;
            _webHostEnvironment = webHostEnvironment;
            _uploadimg = iuploadimg;
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

        [Route("groupcreat")]
        [HttpGet]
        public async Task<IActionResult> CreatGroup()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        [Route("groupcreat")]
        [HttpPost]
        public async Task<IActionResult> Creatgroup(InsertGroupViewModel model, IFormFile FileAnh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            if (ModelState.IsValid)
            {
                //model.AnhDaiDien = "Null.png";
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.AnhDaiDien = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images");
                }
                var (msg, error) = await _groupRepository.CreateGroup(model.MaNhom, model.TenNhom, model.AnhDaiDien, name);

                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error; // báo lỗi về View
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("group");
            }
            TempData["Error"] = "model it not valid: dữ liệu không hợp lệ";
            return View(model);
        }
        //Sửa nhóm
        [Route("updategroup")]
        [HttpGet]
        public IActionResult UpdateGroup(int idnhom)
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
            var Nhom = _context.DbGroups.Find(idnhom);
            return View(Nhom);
        }
        [Route("updategroup")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateGroup(DbGroup model, IFormFile? FileAnh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            if (ModelState.IsValid)
            {
                var img = _context.DbGroups.Where(c => c.IdNhom == model.IdNhom).Select(c => c.AnhDaiDien).FirstOrDefault();//lấy ảnh hiện tại

                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.AnhDaiDien = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images"); // Chỉ 1 ảnh đại diện
                }
                else
                {
                    model.AnhDaiDien = img;
                }
                var (msg, error) = await _groupRepository.UpdateGroup(model.IdNhom, model.GroupName, model.MaNhom, model.AnhDaiDien, name);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error;
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("group");
            }
            TempData["Error"] = "dữ liệu khoog hợp lệ";
            return View(model);
        }
        //Xóa Nhóm
        [Route("deletegroup")]
        [HttpGet]
        public async Task<IActionResult> DeleteGroup(int idnhom)
        {
            //TempData["Message"] = "";
            var prd = _context.DbProducts.Any(x => x.NhomId == idnhom);
            if (prd)
            {
                TempData["Message"] = "Nhóm ĐÃ CÓ SẢN PHẨM DÙNG - KHÔNG THỂ XÓA";
                return RedirectToAction("Group");
            }
            var danhmuc = _context.DbGroups.Find(idnhom);
            if (danhmuc != null)
            {
                var (msg, error) = await _groupRepository.DeleteGroup(idnhom);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Message"] = error;
                }
                TempData["Success"] = msg;
            }
            return RedirectToAction("group");
        }

    }
}
