using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

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
        public async Task<IActionResult> Category(int? page)
        {
            //var name = HttpContext.Session.GetString("NameAdmin");
            //if (name == null)
            //{
            //    return RedirectToAction("Login", "HomeAdmin");
            //}
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstDanhMuc = await _categoryRepository.GetAllCategory();
            PagedList<AllCategoryViewModel> lst = new PagedList<AllCategoryViewModel>(lstDanhMuc, pageNumber, pageSize);
            return View(lst);
        }
        [Route("categorycreat")]
        [HttpGet]
        public async Task<IActionResult> CreatCategory()
        {
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
                var cate = await _categoryRepository.CreateCategory(
                    model.MaDm,
                    model.TenDm,
                    model.AnhDaiDien ?? "null",
                    "Bao"
                    );

                if (cate == 2) //@ret = 2 là thành công
                {
                    TempData["SuccessMessage"] = "Danh mục đã được tạo thành công!";
                    return RedirectToAction("Category"); 
                }
                else
                {
                    ModelState.AddModelError("", "Không thể tạo danh mục. Vui lòng thử lại.");
                }
            }
            return View(model);
        }
        //Sửa Danh Mục
        [Route("updatecategory")]
        [HttpGet]
        public IActionResult UpdateCategory(int iddm)
        {
            var DanhMuc = _context.DbCategorys.Find(iddm);
            return View(DanhMuc);
        }
        [Route("updatecategory")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateCategory(DbCategory model, IFormFile FileAnh)
        {
            if (ModelState.IsValid)
            {
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.AnhDaiDien = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images"); // Chỉ 1 ảnh đại diện
                }
                var cate = await _categoryRepository.UpdateCategory(
                        model.IdDm,
                        model.MaDm,
                        model.TenDm,
                        model.AnhDaiDien ?? "null",
                        "bao"
                    );
                return RedirectToAction("Category");
            }
            return View(model);
        }
        //Xóa Danh Mục
        [Route("deletecategory")]
        [HttpGet]
        public async Task<IActionResult> DeleteCategory(int iddm)
        {
            TempData["Message"] = "";
            var prd = _context.DbProducts.Any(x => x.IdDm == iddm);
            if (prd)
            {
                TempData["Message"] = "DANH MỤC ĐÃ CÓ SẢN PHẨM DÙNG - KHÔNG THỂ XÓA";
                return RedirectToAction("Category");
            }
            var danhmuc = _context.DbCategorys.Find(iddm);
            if (danhmuc != null)
            {
                var cate=await _categoryRepository.DeleteCategory(iddm);
            }            
            TempData["Message"] = "DANH MỤC ĐÃ ĐƯỢC XÓA";
            return RedirectToAction("Category");
        }

        //kiểm tra mã sp trùng lặp trong js
        [HttpGet]
        [Route("categorycheck")]
        public async Task<IActionResult> categorycheck(string madm)
        {
            var exists = await _context.DbCategorys.AnyAsync(x => x.MaDm == madm);
            return Json(new { exists });
        }
    }
}
