using Data.Models;
using dotenv.net;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Repository;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

var builder = WebApplication.CreateBuilder(args);
//login gg

DotEnv.Load();
// Lấy giá trị từ biến môi trường
string googleClientId = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_ID");
string googleClientSecret = Environment.GetEnvironmentVariable("GOOGLE_CLIENT_SECRET");
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = GoogleDefaults.AuthenticationScheme;
})
.AddCookie()
.AddGoogle(options =>
{
    options.ClientId = googleClientId;
    options.ClientSecret = googleClientSecret;
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
//
builder.Services.AddScoped<Iuploadimg, UploadImg>();
builder.Services.AddScoped<Isanpham, Product>();

//chuỗi kết nối (cho các procedure,...)
builder.Services.AddScoped<IDbConnection>(sp =>
    new SqlConnection(builder.Configuration.GetConnectionString("DbConnected")));
builder.Services.AddScoped<ProductRepository>(); 
builder.Services.AddScoped<CategoryRepository>(); 
//chuỗi kết nối (dbcontext)
builder.Services.AddDbContext<YourlookContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DbConnected"));
});

//
var app = builder.Build();

//Environment
//builder.Configuration.AddEnvironmentVariables();
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
