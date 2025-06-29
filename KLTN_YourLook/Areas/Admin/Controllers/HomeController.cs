using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using X.PagedList;
using KLTN_YourLook.Interface;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Identity;
using KLTN_YourLook.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.CodeAnalysis;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class HomeController : Controller
    {
        private readonly YourlookContext _context;
        private readonly Iuploadimg _uploadimg;
        private readonly HomeRespository _homeRespository;
        public HomeController(YourlookContext context,Iuploadimg uploadimg, HomeRespository homeRespository)
        {
            _context = context;
            _uploadimg = uploadimg;
            _homeRespository = homeRespository;
        }

        //trang chủ admin
        [Route("")]
        [Route("index")]
        public async Task<IActionResult> Index(int month,int year)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            if (month == 0)
            {
                month = DateTime.Now.Month;
            }
            if (year == 0)
            {
                year = DateTime.Now.Year;
            }
            var result = await _homeRespository.Revenue(month, year);
            return View(result);
        }
        [Route("getrevenuechart")]
        [HttpGet]
        public async Task<IActionResult> GetRevenueChart(int month, int year)
        {
            if (month == 0)
            {
                month = DateTime.Now.Month;
            }
            if (year == 0)
            {
                year = DateTime.Now.Year;
            }
            var data = await _homeRespository.RevenueAll(month, year);
            if (data == null) return Json(new { success = false });

            var chartData = new
            {
                labels = data.DoanhThuThangTheoNam.Select(x => x.Thang).ToArray(), //tên mặc định của thư viện
                values = data.DoanhThuThangTheoNam.Select(x => x.DoanhThu).ToArray()
            };

            return Json(chartData);
        }
        //tài khoản admin
        [Route("viewaccounts")]
        [HttpGet]
        public IActionResult ViewAccounts()
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
            var acc = _context.DbAdmins.OrderByDescending(x=>x.Id);
            return View(acc);
        }
        //đăng nhập 
        [Route("login")]
        [HttpGet]
        public IActionResult Login()
        {
            if (HttpContext.Session.GetString("NameAdmin") != null)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }
        [Route("login")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Login(DbAdmin admin,string name)
        {
            if (HttpContext.Session.GetString("NameAdmin") == null)
            {
                //tìm 
                var e = _context.DbAdmins.Where(x => x.EmailDn.Equals(name) && (x.PasswordDn.Equals(admin.PasswordDn))).FirstOrDefault();
                var n = _context.DbAdmins.Where(x => x.NameDn.Equals(name) && (x.PasswordDn.Equals(admin.PasswordDn))).FirstOrDefault();
                if (e != null)
                {
                    HttpContext.Session.SetString("NameAdmin", e.NameDn.ToString());
                    HttpContext.Session.SetString("Role", e.Quyen.ToString());
                    TempData["Success"] = "Đăng nhập thành công";
                    return RedirectToAction("Index", "Admin");
                }
                else if (n != null)
                {
                    HttpContext.Session.SetString("NameAdmin", n.NameDn.ToString());
                    HttpContext.Session.SetString("Role", n.Quyen.ToString());
                    TempData["Success"] = "Đăng nhập thành công";
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    //ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác");
                    TempData["Error"] = "Thông tin đăng nhập không chính xác";
                }
            }
            return View(admin);
        }
        [Route("register")]
        [HttpGet]
        public IActionResult Register()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            var role = HttpContext.Session.GetString("Role");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else if(role != "Admin" && role != "Manager")
            {
                TempData["Error"] = "Bạn không có quyền truy cập trang này";
                return RedirectToAction("Error", "Admin");
            }
            return View();
        }
        [Route("register")]
        [HttpPost]
        public async Task<IActionResult> Register(DbAdmin model)
        {
            if (ModelState.IsValid)
            {
                var (msg,error)= await _homeRespository.CreateAdmin(model.EmailDn, model.NameDn, model.PasswordDn,model.ChucVu, model.Quyen);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"]=error;
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("ViewAccounts", "Admin");
            }
            TempData["Error"] = "thông tin không hợp lệ";
            return View(model);
        }
        //đăng xuất
        [Route("logout")]
        public IActionResult Logout()
        {
            HttpContext.Session.Remove("NameAdmin");
            return RedirectToAction("Login", "Admin");
        }
        //view error
        [Route("error")]
        public IActionResult Error()
        {
            return View();
        }
        //ads
        [Route("ads")]
        public IActionResult Ads(int? page)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            var lstAds = _context.DbAdss.OrderByDescending(x => x.IsActive==true);
            PagedList<DbAds> lst = new PagedList<DbAds>(lstAds, pageNumber, pageSize);
            return View(lst);
        }
        //Thêm Ads
        [Route("creatads")]
        [HttpGet]
        public IActionResult CreatAds()
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        [Route("creatads")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatAds(DbAds model,IFormFile FileAnh)
        {
            if (ModelState.IsValid)
            {
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    model.Img = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images");
                }
                _context.DbAdss.Add(model);
                await _context.SaveChangesAsync();
                return RedirectToAction("Ads");
            }
            return View(model);
        }
        //Thêm Ads
        [Route("updateads")]
        [HttpGet]
        public IActionResult UpdateAds(int id)
        {
            var ad= _context.DbAdss.Find(id);
            return View(ad);
        }
        [Route("updateads")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateAds(DbAds ads, IFormFile? FileAnh)
        {
            if (ModelState.IsValid)
            {
                var img= _context.DbAdss.Where(a=>a.Id==ads.Id).Select(a=>a.Img).FirstOrDefault();
                if (FileAnh != null && FileAnh.Length > 0)
                {
                    ads.Img = await _uploadimg.uploadOnePhotosAsync(FileAnh, "images");
                }
                else
                {
                    ads.Img = img;
                }
                _context.DbAdss.Attach(ads);
                _context.Entry(ads).State=EntityState.Modified;
                await _context.SaveChangesAsync();
                return RedirectToAction("Ads");
            }
            return View(ads);
        }

        //Xóa Ads
        [Route("xoaads")]
        [HttpGet]
        public IActionResult XoaAds(int id)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            TempData["Message"] = "";
            var ads = _context.DbAdss.Find(id);
            if (ads != null)
            {
                _context.DbAdss.Remove(ads);
                _context.SaveChanges();
            }
            TempData["Message"] = "ĐÃ XÓA";
            return RedirectToAction("ads");
        }
        //tài khoản khách hàng
        [Route("customer")]
        public async Task<IActionResult> Customer(int? page, string keyword)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            IEnumerable<DbCustomer> lstcus;
            if (!string.IsNullOrEmpty(keyword))
            {
                lstcus = await _homeRespository.SearchCustomer(keyword);
                ViewBag.keyword = keyword;
            }
            else
            {
                lstcus = _context.DbCustomers.OrderByDescending(x => x.CreateDate);
            }
            PagedList<DbCustomer> lst = new PagedList<DbCustomer>(lstcus, pageNumber, pageSize);
            return View(lst);
        }
        [Route("createnotification")]
        [HttpGet]
        public IActionResult CreateNotification()
        {
            return View();
        }
        [Route("createnotification")]
        [HttpPost]
        public async Task<IActionResult> CreateNotification(string title, string message)
        {
            var notification = new DbNotification
            {
                Title = title,
                Message = message,
                CreateDate=DateTime.Now
            };
 
            _context.DbNotifications.Add(notification);
            await _context.SaveChangesAsync();

            TempData["Success"] = "Thông báo đã được gửi!";
            return RedirectToAction("Index");
        }
    }
}
