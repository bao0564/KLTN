using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class CategoryController : Controller
    {
        private readonly YourlookContext _context;
        private readonly CategoryRepository _categoryRepository; //các procedure được đặt ở đây
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly Iuploadimg _uploadimg;
        private readonly ILogger<ProductController> _logger;
        public CategoryController(YourlookContext context, CategoryRepository categoryRepository, IWebHostEnvironment webHostEnvironment, Iuploadimg iuploadimg, ILogger<ProductController> logger)
        {
            _context = context;
            _categoryRepository = categoryRepository;
            _webHostEnvironment = webHostEnvironment;
            _uploadimg = iuploadimg;
            _logger = logger;
        }
        //danh mục
        [Route("category")]
        public async Task<IActionResult> Category(int? page,string keyword)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            IEnumerable<AllCategoryViewModel> lstDanhMuc;
            if (!string.IsNullOrEmpty(keyword))
            {
                lstDanhMuc= await _categoryRepository.SearchCategory(keyword);
                ViewBag.keyword = keyword;
            }
            else
            {
                lstDanhMuc = await _categoryRepository.GetAllCategory();
            }
            PagedList<AllCategoryViewModel> lst = new PagedList<AllCategoryViewModel>(lstDanhMuc, pageNumber, pageSize);
            return View(lst);
        }
        [Route("categorycreat")]
        [HttpGet]
        public async Task<IActionResult> CreatCategory()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        [Route("categorycreat")]
        [HttpPost]
        public async Task<IActionResult> CreatCategory(DbCategory model, IFormFile FileAnh)
        {
            if (ModelState.IsValid)
            {
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.AnhDaiDien = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images");
                }
                var (msg,error) = await _categoryRepository.CreateCategory(model.TenDm, model.AnhDaiDien ?? "","Bao");

                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error; // báo lỗi về View
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("category");
            }
            TempData["Error"] = "model it not valid: dữ liệu không hợp lệ";
            return View(model);
        }
        //Sửa Danh Mục
        [Route("updatecategory")] 
        [HttpGet]
        public IActionResult UpdateCategory(int iddm)
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
            var DanhMuc = _context.DbCategorys.Find(iddm);
            return View(DanhMuc);
        }
        [Route("updatecategory")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateCategory(DbCategory model, IFormFile? FileAnh)
        {
            if (ModelState.IsValid)
            {
                var img = _context.DbCategorys.Where(c=>c.IdDm==model.IdDm).Select(c=>c.AnhDaiDien).FirstOrDefault();//lấy ảnh hiện tại

                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.AnhDaiDien = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images"); // Chỉ 1 ảnh đại diện
                }
                else
                {
                    model.AnhDaiDien = img;
                }
                var (msg,error) = await _categoryRepository.UpdateCategory(model.IdDm, model.TenDm, model.AnhDaiDien, "bao2" );
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error;
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("category");
            }
            TempData["Error"] = "dữ liệu khoog hợp lệ";
            return View(model);
        }
        //Xóa Danh Mục
        [Route("deletecategory")]
        [HttpGet]
        public async Task<IActionResult> DeleteCategory(int iddm)
        {
            //TempData["Message"] = "";
            var prd = _context.DbProducts.Any(x => x.IdDm == iddm);
            if (prd)
            {
                TempData["Message"] = "DANH MỤC ĐÃ CÓ SẢN PHẨM DÙNG - KHÔNG THỂ XÓA";
                return RedirectToAction("Category");
            }
            var danhmuc = _context.DbCategorys.Find(iddm);
            if (danhmuc != null)
            {
                var (msg,error)=await _categoryRepository.DeleteCategory(iddm);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Message"] = error;
                }
                TempData["Success"] = msg;
            }        
            return RedirectToAction("Category");    
        }

        ////kiểm tra mã sp trùng lặp trong js
        //[HttpGet]
        //[Route("categorycheck")]
        //public async Task<IActionResult> categorycheck(string madm)
        //{
        //    var exists = await _context.DbCategorys.AnyAsync(x => x.MaDm == madm);
        //    return Json(new { exists });
        //}
    }
}
