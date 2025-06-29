using Data.Models;
using dotenv.net;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Facebook;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.Data;

var builder = WebApplication.CreateBuilder(args);
builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(5016); // HTTP port
    serverOptions.ListenAnyIP(7129, listenOptions => // HTTPS port
    {
        listenOptions.UseHttps();
    });
});
//login gg
DotEnv.Load();
// Lấy giá trị từ biến môi trường
string googleClientId = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_ID");
string googleClientSecret = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_SECRET");
string facebookClientId = Environment.GetEnvironmentVariable("FACEBOOK_CLIENT_ID");
string facebookClientSecret = Environment.GetEnvironmentVariable("FACEBOOK_CLIENT_SECRET");

if (string.IsNullOrEmpty(googleClientId) || string.IsNullOrEmpty(googleClientSecret))
{
    throw new InvalidOperationException("ID or Secret gg không thấy đâu");
}
if (string.IsNullOrEmpty(facebookClientId) || string.IsNullOrEmpty(facebookClientSecret))
{
    throw new InvalidOperationException("ID or Secret facebook không thấy đâu");
}
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = GoogleDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = FacebookDefaults.AuthenticationScheme;
})
.AddCookie()
.AddGoogle(googleoptions =>
{
    googleoptions.ClientId = googleClientId;
    googleoptions.ClientSecret = googleClientSecret;
})
.AddFacebook(facebookOptions =>
 {
     facebookOptions.AppId = facebookClientId;
     facebookOptions.AppSecret = facebookClientSecret;
     //facebookOptions.CallbackPath = "/signin-facebook"; // Đường dẫn callback
 });

// Add services to the container.
builder.Services.AddControllersWithViews();
//add Session
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Session timeout
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});
//đăng ký interface
builder.Services.AddScoped<Iuploadimg, UploadImg>();
builder.Services.AddScoped<ISentMail, SentMail>();
builder.Services.AddScoped<Isanpham, Product>();

//chuỗi kết nối (cho các procedure,...)
builder.Services.AddScoped<IDbConnection>(sp =>
    new SqlConnection(builder.Configuration.GetConnectionString("DbConnected"))
);
builder.Services.AddScoped<ProductRepository>(); 
builder.Services.AddScoped<CategoryRepository>(); 
builder.Services.AddScoped<GroupRepository>(); 
builder.Services.AddScoped<SizeRepository>(); 
builder.Services.AddScoped<ColorRepository>(); 
builder.Services.AddScoped<OrderRepository>(); 
builder.Services.AddScoped<ReportRepository>(); 
builder.Services.AddScoped<HomeRespository>(); 
builder.Services.AddScoped<SP_Product>(); 
builder.Services.AddScoped<SP_OrderCart>(); 
builder.Services.AddScoped<SP_Access>(); 
builder.Services.AddScoped<SP_User>(); 
//chuỗi kết nối (dbcontext)
builder.Services.AddDbContext<YourlookContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DbConnected"));
});

//
var app = builder.Build();

//Environment
builder.Configuration.AddEnvironmentVariables();
//builder.Environment.EnvironmentName = "Production";  // Thi?t l?p môi tr??ng thành Production
// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
