using System.Collections.Generic;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

namespace KLTN_YourLook.Controllers
{
    public class UserController : Controller
    {
        private readonly YourlookContext _context;
        private readonly SP_User _spUser;
        private readonly Iuploadimg _uploadimg;
        private readonly OrderRepository _orderRepository;
        public UserController( YourlookContext context, SP_User spuser, Iuploadimg uploadImg,OrderRepository orderRepository)
        {
            _context = context;
            _spUser = spuser;
            _uploadimg = uploadImg;
            _orderRepository = orderRepository;
        }
        private DbCustomer GetEmailKhachHang(string email)
        {
            using (var db = new YourlookContext())
            {
                return db.DbCustomers.FirstOrDefault(x => x.Email == email);
            }
        }
        private DbCustomer GetIdKhachHang(int id)
        {
            using (var db = new YourlookContext())
            {
                return db.DbCustomers.FirstOrDefault(x => x.IdKh == id);
            }
        }
        //hiển thị thông tin người dùng 
        [HttpGet]
        public IActionResult UserDetail()
        {
            var idkh = HttpContext.Session.GetInt32("userId");
            if(idkh == null)
            {
                return RedirectToAction("Login","Access");
            }
            var kh = _context.DbCustomers.Find(idkh);
            return View(kh);
        }

        //sửa thông tin tài khoản
        [HttpGet]
        public IActionResult UpdateUserDetail(int idkh)
        {
            var kh = _context.DbCustomers.Find(idkh);
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            return View(kh);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateUserDetail(DbCustomer model, IFormFile? FileAnh)
        {
            var checkemail = HttpContext.Session.GetString("userEmail");
            if (checkemail == null)
            {
                return RedirectToAction("Login", "Access");
            }
            if (ModelState.IsValid)
            {
                var oldimg = _context.DbCustomers.Where(x => x.IdKh == model.IdKh).Select(x => x.Img).FirstOrDefault();
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.Img = await _uploadimg.uploadOnePhotosAsync(FileAnh, "fileupload");
                }
                else
                {
                    model.Img = oldimg;
                }
                //var idkh = _context.DbCustomers.Where(x => x.Email == checkemail).Select(x => x.IdKh).FirstOrDefault();
                var (msg, error) = await _spUser.Update_User(model.IdKh, model.TenKh, model.Img, model.GioiTinh, model.Sdt,model.Email, model.Passwords, model.ConfirmPasswords);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error; // báo lỗi về View
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("UserDetail", "User");
            }
            TempData["Error"] = "Thông tin cập nhật không hợp lệ. Vui lòng kiểm tra lại.";
            return View(model);
        }
        //Sản Phẩm yêu thích
        [HttpGet]
        public async Task<IActionResult> FavoriteProduct(int? page)
        {
            int pageSize = 25;
            int pageNumber = page ?? 1;
            var checkkh = HttpContext.Session.GetInt32("userId");
            if(checkkh == null)
            {
                return RedirectToAction("login", "access");
            }
            int idkh = checkkh.Value;
            var fvrPrd = _context.DbFavoriteProducts.Where(x => x.IdKh == idkh).Select(x => x.IdSp).ToList();
            var result = await _spUser.FavoriteProductShowAll(idkh);
            PagedList<ViewAllDetail> lstsp = new PagedList<ViewAllDetail>(result, pageNumber, pageSize);
            return View(lstsp);
        }
        [HttpPost]
        public async Task<IActionResult> FavoriteProduct(int idsp)
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return Json(new { success = false, message = "Hãy đăng nhập để sử dụng thao tác này" });
            }
            var kh = GetIdKhachHang(checkkh.Value);
            var isFvr = _context.DbFavoriteProducts.FirstOrDefault(x => x.IdKh == kh.IdKh && x.IdSp == idsp);
            if (isFvr == null)
            {
                int idkh =checkkh.Value;
                var result = await _spUser.Create_Favorite_Product(idsp, idkh);
                return Json(new { success = true, message = "Đã thêm vào mục yêu thích" });
            }
            else
            {
                _context.DbFavoriteProducts.Remove(isFvr);
                _context.SaveChanges();
                return Json(new { success = true, message = "Đã xóa khỏi mục yêu thích" });
            }
        }
        //Lịch sử đơn hàng 
        [HttpGet]
        public async Task<IActionResult> HistoryOrder(int iddh)
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            int idkh = checkkh.Value;
            var lstod = await _spUser.UserHistoryOrder(idkh);

            return View(lstod);
        }
        //Hủy đơn hàng
        [HttpGet]
        public async Task<IActionResult> UpdateOrder(int iddh)
        {
            var checkdh= _context.DbOrders.FirstOrDefault(dh=>dh.IdDh == iddh);
            var checkkh = HttpContext.Session.GetInt32("userId");
            var namekh= HttpContext.Session.GetString("userName");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            bool odsuccess = checkdh.ODSuccess;
            bool odreadly = checkdh.ODReadly;
            bool odtransported = checkdh.ODTransported;
            bool complete = false;
            bool odhuy = true;
            var hdh = await _orderRepository.UpdateOrder(iddh, odsuccess, odreadly, odtransported, complete, odhuy, namekh);

            TempData["Success"] = "Hủy đơn hàng thành công";
            return RedirectToAction("HistoryOrder");
        }
        //Địa chỉ người dùng
        [HttpGet]
        public async Task<IActionResult> UserAddress()
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            int idkh = checkkh.Value;
            var result = await _spUser.User_Adress(idkh);
            return View(result);
        }
        //Tạo địa chỉ mới
        [HttpGet]
        public async Task<IActionResult> CreateAddress()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> CreateAddress(DbAddress model)
        {
            if(ModelState.IsValid)  
            {
                var checkkh = HttpContext.Session.GetInt32("userId");
                if (checkkh == null)
                {
                    return RedirectToAction("Login", "Access");
                }
                int idkh = checkkh.Value;
                var (msg, error) = await _spUser.Create_Adress(idkh, model.TenNguoiNhan, model.Sdt, model.Address, model.City, model.QuanHuyen, model.PhuongXa,model.GhiChu, model.Idefault);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] = error; // báo lỗi về View
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("UserAddress","User");
            }
            TempData["Error"] = "Lỗi - Dữ liệu không hợp lệ!";
            return View(model);
        }
        //Sửa Địa chỉ
        //Xóa Địa chỉ
        //tạo đánh giá
        [HttpGet]
        public async Task<IActionResult> CreateRating(int iddh)
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            var Israted = _context.DbRatings.Any(x => x.IdDh == iddh);
            if (Israted)
            {
                return RedirectToAction("Error") ;
            }
            var result = await _spUser.Product_Rating(iddh);
            return View(result);
        }
        [HttpPost]
        public async Task<IActionResult> CreateRating([FromBody] RateRequest model)
        {
            if (model == null || model.Reviews == null || !model.Reviews.Any())
            {
                return Json(new { message = "Không có dữ liệu đánh giá!", success = false });
            }

            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            int idkh = checkkh.Value;

            try
            {
                foreach (var r in model.Reviews)
                {
                    //var newReview = new DbRating
                    //{
                    //    IdDh = model.IdDh,
                    //    IdSp = r.IdSp,
                    //    IdKh = idkh,
                    //    ColorSize =r.ColorSizes,
                    //    Rate = r.Rate,
                    //    DanhGia = r.DanhGia
                    //};

                    //_context.DbRatings.Add(newReview);
                    var result = await _spUser.Create_Rating(model.IdDh, r.IdSp, idkh, r.Rate, r.ColorSizes, r.DanhGia);
                }

                //await _context.SaveChangesAsync();
                return Json(new { success = true, msg = "Đánh giá sản phẩm thành công!" });
            }
            catch (Exception ex)
            {
                // Log lỗi để kiểm tra chi tiết
                return Json(new { success = false, message = "Lỗi server: " + ex.Message });
            }
        }


    }
}
