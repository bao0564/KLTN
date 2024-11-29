using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Data;
using System.Data.Common;
using X.PagedList;
using X.PagedList.Extensions;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class ProductController:Controller
    {
        private readonly YourlookContext _context;
        private readonly ProductRepository _productRepository; //các procedure được đặt ở đây
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly Iuploadimg _uploadimg;
        private readonly ILogger<ProductController> _logger;
        public ProductController(YourlookContext context,ProductRepository productRepository, IWebHostEnvironment webHostEnvironment,Iuploadimg iuploadimg,ILogger<ProductController> logger)
        {
            _context = context;
            _productRepository= productRepository;
            _webHostEnvironment = webHostEnvironment;
            _uploadimg = iuploadimg;
            _logger = logger;
        }
        //Sản Phẩm
        [Route("product")]
        public async Task<IActionResult> Product(int? page)
        {
            //var name = HttpContext.Session.GetString("NameAdmin");
            //if (name == null)
            //{
            //    return RedirectToAction("Login", "HomeAdmin");
            //}
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstSanPham = await _productRepository.GetAllProduct();
            PagedList<AllProductViewModel> lst = new PagedList<AllProductViewModel>(lstSanPham, pageNumber, pageSize);
            return View(lst);
        }
        //Thêm Sản Phẩm
        [Route("productcreat")]
        [HttpGet] 
        public async Task<IActionResult> CreatProduct()
        {
            //var viewModel = new AddProductViewModel
            //{
            //    SizeList =  _context.DbSizes.ToList(),
            //    ColorList = _context.DbColors.ToList()
            //};
            var danhmuc = await _context.DbCategorys//list chọn danh mục
                .Select(c => new{c.IdDm,Namedm = $"{c.TenDm}-({c.MaDm})"}).ToListAsync();
            ViewBag.IdDm = new SelectList(danhmuc, "IdDm", "Namedm");
            var nhom = await _context.DbGroups//list chọn nhóm
                .Select(c => new{c.IdNhom,Namen = $"{c.GroupName}-({c.MaNhom})"}).ToListAsync();
            ViewBag.IdNhom = new SelectList(nhom, "IdNhom", "Namen");
            return View();
        }
        [Route("productcreat")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatProduct(AddProductViewModel model, string Imgs, IFormFile AnhSpFile)//name trong 2 input tải ảnh
        {
            if (ModelState.IsValid)
            {
                if (AnhSpFile !=null && AnhSpFile.Length>0)
                {
                    model.AnhSp = await _uploadimg.uploadOnePhotosAsync(AnhSpFile,"img");
                }
                var prd = new DbProduct
                {
                    MaSp = model.MaSp,
                    TenSp = model.TenSp,
                    AnhSp = model.AnhSp,
                    IdDm = model.IdDm,
                    NhomId = model.NhomId,
                    SaoDanhGia = model.SaoDanhGia,
                    PriceMax = model.PriceMax,
                    PriceMin = model.PriceMin,
                    GiamGia = model.GiamGia,
                    MotaSp = model.MoTaSp,
                    IActive = model.IActive,
                    IFavorite=false,
                    IFeature = model.IFeature,
                    IHot = model.IHot,
                    ISale = model.ISale,
                    CreateDate=DateTime.Now
                    //CreateBy=
                };
                _context.DbProducts.Add(prd);
                await _context.SaveChangesAsync();

                //ảnh
                if (!string.IsNullOrEmpty(Imgs))
                {
                    var imagePaths = Imgs.Split(';');
                    foreach (var imagePath in imagePaths)
                    {
                        _context.DbImgs.Add(new DbImg
                        {
                            IdSp = prd.IdSp,
                            Img = imagePath
                        });
                    }
                    await _context.SaveChangesAsync();
                }
                //if (!string.IsNullOrEmpty(model.DetailData))
                //{
                //    var details = model.DetailData.Split(';', StringSplitOptions.RemoveEmptyEntries);
                //    foreach (var detail in details)
                //    {
                //        var parts = detail.Split(',');
                //        var dbDetail = new DbProductDetail
                //        {
                //            IdSp = prd.IdSp,
                //            ColorId = int.Parse(parts[0]),
                //            SizeId = int.Parse(parts[1]),
                //            GiaLoai = decimal.Parse(parts[2]),
                //            Quantity = int.Parse(parts[3]),
                //        };
                //        _context.DbProductDetails.Add(dbDetail);
                //    }
                //    await _context.SaveChangesAsync();
                //}
                return RedirectToAction("Product");
            }            
            else
            {
                //ModelState.AddModelError("", "Không thể tạo sản phẩm.");
                foreach (var state in ModelState)
                {
                    foreach (var error in state.Value.Errors)
                    {
                        // Ghi log hoặc xử lý lỗi cụ thể
                        Console.WriteLine($"Lỗi ở trường {state.Key}: {error.ErrorMessage}");
                    }
                }
            }
            //var viewModel = new AddProductViewModel
            //{
            //    SizeList = await _context.DbSizes.ToListAsync(),
            //    ColorList = await _context.DbColors.ToListAsync()
            //};
            return View(model);
        }
        //dùng cho ajax tải ảnh trong js
        [HttpPost]
        public async Task<IActionResult> UploadImg(List<IFormFile> files)
        {
            var filePaths = new List<string>();
            foreach (var file in files)
            {
                if (file.Length > 0)
                {
                    string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "img");
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    string filePath = Path.Combine(uploadDir, fileName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }

                    filePaths.Add(fileName);
                }
            }
            return Json(new { success = true, filePaths });
        }
        //kiểm tra mã sp trùng lặp trong js
        [HttpGet]
        [Route("productcheck")]
        public async Task<IActionResult> check(string masp)
        {
            var exists = await _context.DbProducts.AnyAsync(x => x.MaSp == masp);
            return Json(new { exists });
        }
    }
}
