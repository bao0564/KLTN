using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Data.Models;
using BCrypt.Net;
using KLTN_YourLook.Repository_YL;
using static System.Runtime.InteropServices.JavaScript.JSType;
using KLTN_YourLook.Models;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.AspNetCore.Authentication.Facebook;
using DocumentFormat.OpenXml.Wordprocessing;

namespace KLTN_YourLook.Controllers
{
	public class AccessController : Controller
	{
		private readonly YourlookContext _context;
		private readonly SP_User _user;
		public AccessController(YourlookContext context,SP_User sp_user)
		{
			_context = context;
			_user = sp_user;
		}
		[HttpGet]
		public IActionResult Login()
		{
			if (HttpContext.Session.GetString("userEmail") == null)
			{
				return View();
			}
			else
			{
				return RedirectToAction("Index", "Home");
			}
		}
		[HttpPost]
		public IActionResult Login(DbCustomer model)
		{
			if (HttpContext.Session.GetString("userEmail") == null && HttpContext.Session.GetInt32("userId") == null)
			{
				//            var customer = _context.DbCustomers.FirstOrDefault(x => x.Email == model.Email && !x.IsExternalAccount);
				//            string enteredPassword = model.Passwords;
				//string storedHash = customer.Passwords;

				//            bool i = BCrypt.Net.BCrypt.Verify(enteredPassword, storedHash);
				var i = _context.DbCustomers.FirstOrDefault(x => x.Email == model.Email && (x.Passwords != null && x.Passwords == model.Passwords || x.IsExternalAccount == false));
				if (i !=null)
				{
					HttpContext.Session.SetString("userEmail", i.Email.ToString());
					HttpContext.Session.SetInt32("userId", i.IdKh);
					HttpContext.Session.SetString("userName", i.TenKh);
					return RedirectToAction("Index", "Home");
				}
				else
				{
					TempData["Error"] = "Email hoặc mật khẩu không đúng";
					ModelState.AddModelError(string.Empty, "thông tin không hợp lệ");
				}
			}
			return View(model);
		}
		[HttpGet]
		public IActionResult Register()
		{
			return View();
		}
		[HttpPost]
		public async Task<IActionResult> Register(View_Register model)
		{
			if (ModelState.IsValid)
			{
                //string password = model.Passwords; 
                //string hashedPassword= BCrypt.Net.BCrypt.HashPassword(password);
                //var (msg, error) = await _user.Create_User(model.TenKh, model.Sdt, model.Email, hashedPassword, model.ConfirmPasswords, false);
                var (msg, error) = await _user.Create_User(model.TenKh, model.Sdt, model.Email, model.Passwords, model.ConfirmPasswords, false);
                if (!string.IsNullOrEmpty(error))
				{
					TempData["Error"]= error;
                    return View(model);
                }
				TempData["Success"] = msg;
				return RedirectToAction("Login", "Access");
            }
            TempData["Error"] = "thông tin không hợp lệ";
            return View(model);
		}
		//đăng ký bằng gg
		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult ExternalLogin(string provider, string returnUrl = null)
		{
			var redirectUrl = Url.Action("ExternalLoginCallback", "Access", new { ReturnUrl = returnUrl });
			var properties = new AuthenticationProperties { RedirectUri = redirectUrl };
			return Challenge(properties, provider);
		}

		public async Task<IActionResult> ExternalLoginCallback(string returnUrl = null, string remoteError = null)
		{
			if (remoteError != null)
			{
				ModelState.AddModelError(string.Empty, $"Error from external provider: {remoteError}");
				return RedirectToAction(nameof(Login));
			}

			var info = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
			if (info?.Principal == null)
			{
				return RedirectToAction(nameof(Login));
			}

			var email = info.Principal.FindFirstValue(ClaimTypes.Email);
			var name = info.Principal.FindFirstValue(ClaimTypes.Name);
			var googleUserId = info.Principal.FindFirstValue("sub");

            if (email == null)
			{
				ModelState.AddModelError(string.Empty, "Email not received from external provider.");
				return RedirectToAction(nameof(Login));
			}
			
			var user = _context.DbCustomers.FirstOrDefault(x => x.Email == email);
			if (user == null)
			{
				user = new DbCustomer
				{
					MaKh = "gg"+googleUserId ?? "kh",
					Email = email,
					TenKh = name ?? "",
					Passwords = "",
					IsExternalAccount = true,
					CreateDate = DateTime.Now
				};
				_context.DbCustomers.Add(user);
				await _context.SaveChangesAsync();
			}

			HttpContext.Session.SetString("userEmail", user.Email);
			HttpContext.Session.SetInt32("userId", user.IdKh);

            return RedirectToAction("Index", "Home");
            //return RedirectToLocal(returnUrl);
		}

		private IActionResult RedirectToLocal(string returnUrl)
		{
			if (Url.IsLocalUrl(returnUrl))
			{
				return Redirect(returnUrl);
			}
			else
			{
				return RedirectToAction(nameof(HomeController.Index), "Home");
			}
        }
        //đăng ký bằng Facebook

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult FaceLogin()
		{
            var redirectUrl = Url.Action("FaceLoginCallBack", "Access");
            var properties = new AuthenticationProperties { RedirectUri = redirectUrl };
            return Challenge(properties, FacebookDefaults.AuthenticationScheme);
        }
		public async Task<IActionResult> FaceLoginCallBack()
		{
            var authenticateResult = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            if (!authenticateResult.Succeeded)
                return RedirectToAction("Login");

            var info = authenticateResult.Principal.Identities.FirstOrDefault()?.Claims;

            var facebookId = info.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var fullName = info.FirstOrDefault(c => c.Type == ClaimTypes.Name)?.Value;
            var email = info.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;

            var user = _context.DbCustomers.FirstOrDefault(x => x.Email == email);
			if (user == null)
			{
                user = new DbCustomer
                {
                    MaKh = "fb"+facebookId ?? "kh",
                    Email = email,
                    TenKh = fullName ?? "",
                    Passwords = "",
                    IsExternalAccount = true,
                    CreateDate = DateTime.Now
                };
                _context.DbCustomers.Add(user);
                _context.SaveChanges();
            }

            HttpContext.Session.SetString("userEmail", user.Email);
            HttpContext.Session.SetInt32("userId", user.IdKh);
            return RedirectToAction("Index", "Home");  
        }
        // quên mật khẩu

        [HttpGet]
        public IActionResult ForgotPassword()
		{
			return View();
		}
		
        [HttpPost]
        public IActionResult ForgotPassword(ForgotPasswordViewModel model)
		{
			return View();
		}

        public IActionResult LogOut()
		{
			HttpContext.Session.Remove("userEmail");
			HttpContext.Session.Remove("userId");
            HttpContext.Session.Remove("userName");
            return RedirectToAction("Index", "Home");
		}
	}
}
