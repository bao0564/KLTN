using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using X.PagedList;
using KLTN_YourLook.Interface;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class HomeController : Controller
    {
        private readonly YourlookContext _context;
        private readonly Iuploadimg _uploadimg;
        public HomeController(YourlookContext context,Iuploadimg uploadimg)
        {
            _context = context;
            _uploadimg = uploadimg;
        }

        //
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            //var name = HttpContext.Session.GetString("NameAdmin");
            //if (name == null)
            //{
            //    return RedirectToAction("Login", "HomeAdmin");
            //}
            return View();
        }
        //
        [Route("login")]
        [HttpGet]
        public IActionResult Login()
        {
            if (HttpContext.Session.GetString("NameAdmin") != null)
            {
                return RedirectToAction("Index", "HomeAdmin");
            }
            else
            {
                return View();
            }
        }
        [Route("login")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Login(DbAdmin admin)
        {
            if (HttpContext.Session.GetString("NameAdmin") == null)
            {
                //tìm 
                var e = _context.DbAdmins.Where(x => x.EmailDn.Equals(admin.EmailDn) && (x.PasswordDn.Equals(admin.PasswordDn))).FirstOrDefault();
                var n = _context.DbAdmins.Where(x => x.NameDn.Equals(admin.NameDn) && (x.PasswordDn.Equals(admin.PasswordDn))).FirstOrDefault();
                if (e != null)
                {
                    HttpContext.Session.SetString("NameAdmin", e.NameDn.ToString());
                    return RedirectToAction("Index", "HomeAdmin");
                }
                else if (n != null)
                {
                    HttpContext.Session.SetString("NameAdmin", n.NameDn.ToString());
                    return RedirectToAction("Index", "HomeAdmin");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác");
                }
            }
            return View(admin);
        }
        [Route("logout")]
        public IActionResult Logout()
        {
            HttpContext.Session.Remove("EmailAdmin");
            HttpContext.Session.Remove("NameAdmin");
            return RedirectToAction("Login", "HomeAdmin");
        }
        //ads
        [Route("ads")]
        public IActionResult Ads(int? page)
        {
            //var name = HttpContext.Session.GetString("NameAdmin");
            //if (name == null)
            //{
            //    return RedirectToAction("Login", "HomeAdmin");
            //}
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
    }
}
