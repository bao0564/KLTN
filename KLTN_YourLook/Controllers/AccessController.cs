using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Data.Models;
using KLTN_YourLook.Repository_YL;
using static System.Runtime.InteropServices.JavaScript.JSType;
using KLTN_YourLook.Models;

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
				var i = _context.DbCustomers.Where(x => x.Email.Equals(model.Email) && (x.Passwords.Equals(model.Passwords) || x.IsExternalAccount)).FirstOrDefault();
				if (i != null)
				{
					HttpContext.Session.SetString("userEmail", i.Email.ToString());
					HttpContext.Session.SetInt32("userId", i.IdKh);
					HttpContext.Session.SetString("userName", i.TenKh);
					return RedirectToAction("Index", "Home");
				}
				else
				{
					ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
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
				////Kiểm tra email 
				//var emailexit = _context.DbCustomers.FirstOrDefault(x => x.Email == model.Email);
				//if (emailexit != null)
				//{
				//	ModelState.AddModelError("Email", "Email đã được sử dụng.");
				//	return View(model);
				//}
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
				//var (msg, error) = await _user.Create_User(name,"",email,"","",true);
				user = new DbCustomer
				{
					MaKh = googleUserId ?? "kh",
					Email = email,
					TenKh = name ?? "",
					Passwords = "",
					IsExternalAccount = true,
					CreateDate = DateTime.Now
				};
				_context.DbCustomers.Add(user);
				_context.SaveChanges();
			}

			HttpContext.Session.SetString("userEmail", user.Email);
			HttpContext.Session.SetInt32("userId", user.IdKh);

			return RedirectToLocal(returnUrl);
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

		public IActionResult LogOut()
		{
			HttpContext.Session.Remove("userEmail");
			HttpContext.Session.Remove("userId");
            HttpContext.Session.Remove("userName");
            return RedirectToAction("Index", "Home");
		}
	}
}
