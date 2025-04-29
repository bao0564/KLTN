using ClosedXML.Excel;
using Dapper;
using Data.Models;
using DocumentFormat.OpenXml.Office2021.Drawing.SketchyShapes;
using DocumentFormat.OpenXml.Spreadsheet;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Data;
using System.Data.Common;
using X.PagedList;
using X.PagedList.Extensions;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;
using static System.Runtime.InteropServices.JavaScript.JSType;

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
        [HttpGet]
        public async Task<IActionResult> Product(int? page,string keyword)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            IEnumerable<AllProductViewModel> lstSanPham;
            lstSanPham = await _productRepository.SearchProduct(keyword);
            ViewBag.keyword = keyword;
           
            PagedList<AllProductViewModel> lst = new PagedList<AllProductViewModel>(lstSanPham, pageNumber, pageSize);
            return View(lst);
        }
        //Thêm Sản Phẩm
        [Route("productcreat")]
        [HttpGet] 
        public async Task<IActionResult> CreatProduct()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var viewModel = new AddProductViewModel
            {
                SizeList = _context.DbSizes.ToList(),
                ColorList = _context.DbColors.ToList()
            };
            var danhmuc = await _context.DbCategorys//list chọn danh mục
                .Select(c => new{c.IdDm,Namedm = $"{c.TenDm}-({c.MaDm})"}).ToListAsync();
            ViewBag.IdDm = new SelectList(danhmuc, "IdDm", "Namedm");
            var nhom = await _context.DbGroups//list chọn nhóm
                .Select(c => new{c.IdNhom,Namen = $"{c.GroupName}-({c.MaNhom})"}).ToListAsync();
            ViewBag.IdNhom = new SelectList(nhom, "IdNhom", "Namen");
            return View(viewModel);
        }
        [Route("productcreat")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatProduct(AddProductViewModel model, string? Imgs,string DetailData, IFormFile? AnhSpFile)//name trong 2 input tải ảnh
        {
            if (ModelState.IsValid)
            {
                if (AnhSpFile !=null && AnhSpFile.Length>0)
                {
                    model.AnhSp = await _uploadimg.uploadOnePhotosAsync(AnhSpFile,"img");
                }
                var (newIdSp, error) = await _productRepository.CreateProduct(model.IdDm,model.TenSp,model.NhomId,model.AnhSp,model.Classify,model.PriceMax,
                        model.GiamGia ?? 0,model.PriceMin ?? 0,model.MoTaSp,model.IActive,model.IFeature,model.IFavorite,model.IHot, model.ISale, "bao" );
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"]=error;
                    return View(model);
                }
                //ảnh
                if (!string.IsNullOrEmpty(Imgs))
                {
                    var imagePaths = Imgs.Split(';');
                    foreach (var imagePath in imagePaths)
                    {
                        await _productRepository.CreateImg(
                                    newIdSp,
                                    imagePath
                                );
                    }
                }
                //chi tiết size,color,price,quantity
                if (!string.IsNullOrEmpty(DetailData))
                {
                    var details = DetailData.Split(';', StringSplitOptions.RemoveEmptyEntries);//bỏ chuỗi rỗng
                    foreach (var detail in details)
                    {
                        var parts = detail.Split(',');
                        await _productRepository.CreateProductDetail(
                                newIdSp,
                                int.Parse(parts[0]),
                                parts[1],
                                int.Parse(parts[2]),
                                parts[3],
                                decimal.Parse(parts[4]),
                                int.Parse(parts[5])
                            );
                    }
                }
                TempData["Success"] = "Thêm sản phẩm thành công";
                return RedirectToAction("Product");
            }            
            else
            {
                TempData["Error"] = "LỖI DỮ LIỆU";
                foreach (var state in ModelState)
                {
                    foreach (var error in state.Value.Errors)
                    {
                        // Ghi log hoặc xử lý lỗi cụ thể
                        Console.WriteLine($"Lỗi ở trường {state.Key}: {error.ErrorMessage}");
                    }
                }
            }
            var viewModel = new AddProductViewModel
            {
                SizeList = await _context.DbSizes.ToListAsync(),
                ColorList = await _context.DbColors.ToListAsync()
            };
            var danhmuc = await _context.DbCategorys//list chọn danh mục
                .Select(c => new { c.IdDm, Namedm = $"{c.TenDm}-({c.MaDm})" }).ToListAsync();
            ViewBag.IdDm = new SelectList(danhmuc, "IdDm", "Namedm");
            var nhom = await _context.DbGroups//list chọn nhóm
                .Select(c => new { c.IdNhom, Namen = $"{c.GroupName}-({c.MaNhom})" }).ToListAsync();
            ViewBag.IdNhom = new SelectList(nhom, "IdNhom", "Namen");
            return View(model);
        }
        
        //Nhập hàng
        [Route("stockup")]
        [HttpGet]
        public IActionResult Stock()
        {
            return View();
        }
        //sửa Sản phẩm
        [Route("updateproduct")]
        [HttpGet]
        public async Task<IActionResult> UpdateProduct(int idsp)
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
            var prd= _context.DbProducts.Include(p=>p.imgs)
                .Include(p=>p.detailproducts)
                .ThenInclude(p=>p.size)
                .Include(p=>p.detailproducts)
                .ThenInclude(p=>p.color)
                .FirstOrDefault(p=>p.IdSp==idsp);
            var model = new AddProductViewModel
            {
                IdSp = prd.IdSp,
                MaSp = prd.MaSp,
                TenSp = prd.TenSp,
                IdDm = prd.IdDm,
                NhomId = prd.NhomId,
                PriceMax = prd.PriceMax,
                GiamGia = prd.GiamGia,
                PriceMin = prd.PriceMin,
                AnhSp = prd.AnhSp,
                MoTaSp = prd.MotaSp,
                IActive = prd.IActive,
                IFeature = prd.IFeature,
                IFavorite = prd.IFavorite,
                IHot = prd.IHot,
                ISale = prd.ISale,
                Imgs = prd.imgs.ToList(),
                Details = prd.detailproducts.Select(dt => new View_Productdetail
                {
                    IdSp = dt.IdSp,
                    SizeId = dt.SizeId,
                    NameSize = dt.NameSize,
                    ColorId = dt.ColorId,
                    NameColor= dt.NameColor,
                    GiaLoai = dt.GiaLoai,
                    Quantity = dt.Quantity,
                }).ToList(),
                SizeList = _context.DbSizes.ToList(),
                ColorList = _context.DbColors.ToList(),
                SelectedColor= prd.detailproducts.Select(ct=>ct.ColorId).ToList(),
                SelectedSize=prd.detailproducts.Select(ct=>ct.SizeId).ToList()
            };
            var danhmuc = await _context.DbCategorys//list chọn danh mục
                .Select(c => new { c.IdDm, Namedm = $"{c.TenDm}-({c.MaDm})" }).ToListAsync();
            ViewBag.IdDm = new SelectList(danhmuc, "IdDm", "Namedm");
            var nhom = await _context.DbGroups//list chọn nhóm
                .Select(c => new { c.IdNhom, Namen = $"{c.GroupName}-({c.MaNhom})" }).ToListAsync();
            ViewBag.IdNhom = new SelectList(nhom, "IdNhom", "Namen");
            return View(model);
        }
        [Route("updateproduct")]
        [HttpPost]
        public async Task<IActionResult> UpdateProduct(AddProductViewModel model, string? Imgs, string? DetailData, IFormFile? AnhSpFile)
        {
            if(ModelState.IsValid)
            {
                var img=_context.DbProducts.Where(p=>p.IdSp==model.IdSp).Select(p=>p.AnhSp).FirstOrDefault();//lấy ảnh hiện tại
                var oldprd = _context.DbProducts.Include(p => p.imgs)
                    .Include(p => p.detailproducts)
                    .ThenInclude(p => p.size)
                    .Include(p => p.detailproducts)
                    .ThenInclude(p => p.color)
                    .FirstOrDefault(p => p.IdSp == model.IdSp);

                if (AnhSpFile != null && AnhSpFile.Length > 0) //nếu tải lên ảnh 
                {
                    model.AnhSp = await _uploadimg.uploadOnePhotosAsync(AnhSpFile, "img");
                }
                else
                {
                    model.AnhSp = img;
                }
                var prd = await _productRepository.UpdateProduct(model.IdSp, model.IdDm, model.TenSp, model.NhomId, model.AnhSp, model.PriceMax, model.GiamGia ?? 0,//SP
                                                                 model.PriceMin ?? 0, model.MoTaSp, model.IActive, model.IFeature, model.IFavorite, model.IHot, model.ISale, "bao2" );
                //ảnh
                if (!string.IsNullOrEmpty(Imgs))
                {
                    var oldimg = _context.DbImgs.Where(i => i.IdSp == model.IdSp).ToList();
                    if (oldimg != null)
                    {
                        _context.DbImgs.RemoveRange(oldimg);
                        await _context.SaveChangesAsync();
                    }
                    var imagePaths = Imgs.Split(';');
                    foreach (var imagePath in imagePaths)
                    {
                        await _productRepository.CreateImg(model.IdSp, imagePath );//SP
                    }
                }
                //chi tiết size,color,price,quantity
                if (!string.IsNullOrEmpty(DetailData))
                {
                    var olddetail= _context.DbProductDetails.Where(pd=>pd.IdSp== model.IdSp).ToList();
                    if (olddetail !=null)
                    {
                        _context.DbProductDetails.RemoveRange(olddetail);
                        await _context.SaveChangesAsync();
                    }
                    var details = DetailData.Split(';', StringSplitOptions.RemoveEmptyEntries);//bỏ chuỗi rỗng
                    foreach (var detail in details)
                    {
                        var parts = detail.Split(',');
                        await _productRepository.CreateProductDetail(//SP
                            model.IdSp,
                            int.Parse(parts[0]),
                            parts[1],
                            int.Parse(parts[2]),
                            parts[3],
                            decimal.Parse(parts[4]),
                            int.Parse(parts[5])
                        );
                    }
                }
                TempData["Success"] = "Sửa sản phẩm thành công";
                return RedirectToAction("Product");
            }
            return View(model);
        }
        //Xóa Sản Phảm
        [Route("deleteproduct")]
        [HttpGet]
        public IActionResult DeleteProduct(int idsp)
        {
            //TempData["Message"] = "";
            var img = _context.DbImgs.Where(x => x.IdSp == idsp).ToList();
            var sanpham = _context.DbProducts.Find(idsp);
            var chitietsanpham = _context.DbProductDetails.Where(x => x.IdSp == idsp).ToList();
            if (sanpham != null)
            {
                if (img.Any())
                {
                    _context.DbImgs.RemoveRange(img);
                }
                if (chitietsanpham.Any())
                {
                    _context.DbProductDetails.RemoveRange(chitietsanpham);
                }
                _context.DbProducts.Remove(sanpham);
                _context.SaveChanges();
            }
            TempData["Success"] = "Sản Phẩm Đã Bị Xóa Khỏi Danh sách sản phẩm";
            return RedirectToAction("Product");
        }
        //api tải ảnh
        [HttpPost]
        [Route("uploadimg")]
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
        //Chi Tiết Sản Phẩm 
        [HttpGet]
        [Route("productdetail")]
        public async Task<IActionResult> ProductDetail(int idsp)
        {
            var prd =await _productRepository.Product_Find(idsp);
            var img=await _productRepository.Product_Img_Find(idsp);
            var ctsp = await _productRepository.Product_ProductDetail_Find(idsp);
            var model = new ProductDetailViewModel
            {
                Product = prd,
                Imgs = img.ToList(),
                Details = ctsp.ToList()
            };
            return View(model);
        }
        //api kiểm tra mã sp trùng lặp 
        [HttpGet]
        [Route("productcheck")]
        public async Task<IActionResult> check(string masp, int? idsp)
        {
            var exists = await _context.DbProducts.AnyAsync(x => x.MaSp == masp && x.IdSp != idsp);
            return Json(new { exists });
        }
        [HttpGet]
        [Route("productexportexcel")]
        public async Task<IActionResult> ExportProductListToExcel(string keyword)
        {
            IEnumerable<AllProductViewModel> lstSanPham;
            lstSanPham = await _productRepository.SearchProduct(keyword);
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Danh sách sản phẩm");
                var currentRow = 1;
                // Tiêu đề cột
                worksheet.Cell(currentRow, 1).Value = "Mã Sản Phẩm";
                worksheet.Cell(currentRow, 2).Value = "Tên sản phẩm";
                worksheet.Cell(currentRow, 3).Value = "Giá sản phẩm";
                worksheet.Cell(currentRow, 4).Value = "Giảm giá (%)";
                worksheet.Cell(currentRow, 5).Value = "Giá đã giảm";
                worksheet.Cell(currentRow, 6).Value = "Danh mục";
                worksheet.Cell(currentRow, 7).Value = "Nhóm";
                worksheet.Cell(currentRow, 8).Value = "Đã bán";
                worksheet.Cell(currentRow, 9).Value = "Tồn kho";
                worksheet.Cell(currentRow, 10).Value = "";
                worksheet.Cell(currentRow, 11).Value = "";
                worksheet.Cell(currentRow, 12).Value = "";
                worksheet.Cell(currentRow, 13).Value = "";
                foreach(var prd in lstSanPham)
                {
                    currentRow++;
                    worksheet.Cell(currentRow, 1).Value = prd.MaSp;
                    worksheet.Cell(currentRow, 2).Value = prd.TenSp;
                    worksheet.Cell(currentRow, 3).Value = $"{prd.PriceMax:N0} VNĐ";
                    worksheet.Cell(currentRow, 4).Value = prd.GiamGia +"%";
                    worksheet.Cell(currentRow, 5).Value = $"{prd.PriceMin:N0} VNĐ";
                    worksheet.Cell(currentRow, 6).Value = prd.TenDm;
                    worksheet.Cell(currentRow, 7).Value = prd.GroupName;
                    worksheet.Cell(currentRow, 8).Value = prd.LuotSold;
                    worksheet.Cell(currentRow, 9).Value = prd.Quantity;
                }
                // Định dạng bảng (tô đậm tiêu đề, căn giữa)
                worksheet.Range("A1:E1").Style.Font.Bold = true;
                worksheet.RangeUsed().Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Columns().AdjustToContents(); // Tự động điều chỉnh kích thước cột

                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();
                    return File(content, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "DanhSachSanPham.xlsx");
                }
            }
        }
    }
}
