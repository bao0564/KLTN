using Data.Models;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.ViewMenuKid
{
    public class ViewPage1:ViewComponent
    {
        private readonly Isanpham _isanpham;
        private readonly YourlookContext _context;
        public ViewPage1(YourlookContext context,Isanpham isanpham)
        {
            _context = context; 
            _isanpham = isanpham;
        }
        public IViewComponentResult Invoke()
        {
            //var db5SanPhamPage1 = _isanpham.GetAllProduct().Where(x => x.MaDm == 1).OrderBy(X => X.TenSp).Take(5);
            return View();
        }
    }
}
