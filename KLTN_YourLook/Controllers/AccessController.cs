using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Data.Models;

namespace KLTN_YourLook.Controllers
{
	public class AccessController : Controller
	{
		private readonly YourlookContext _context;
		public AccessController(YourlookContext context)
		{
			_context = context;
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
		public IActionResult Register(DbCustomer user)
		{
			if (ModelState.IsValid)
			{
				var emailexit = _context.DbCustomers.FirstOrDefault(x => x.Email == user.Email);
				if (emailexit != null)
				{
					ModelState.AddModelError("Email", "Email đã được sử dụng.");
					return View(user);
				}
				user.CreateDate = DateTime.Now;
				user.IsExternalAccount = false;
				_context.DbCustomers.Add(user);
				_context.SaveChanges();
				return RedirectToAction("Login", "Access");
			}
			return View(user);
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
					MaKh = googleUserId ?? "",
					Email = email,
					TenKh = name ?? "",
					Passwords= "",
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
			return RedirectToAction("Index", "Home");
		}
	}
}
