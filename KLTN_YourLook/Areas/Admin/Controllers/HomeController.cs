using Data.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class HomeController : Controller
    {
        private readonly YourlookContext _context;
        public HomeController(YourlookContext context)
        {
            _context = context;
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
    }
}
