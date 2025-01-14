using Data.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;

namespace KLTN_YourLook.Component
{
    public class View_Suggest:ViewComponent
    {
        private readonly YourlookContext _context;
        private readonly SP_Product _productRepository;
        public View_Suggest(YourlookContext context, SP_Product productRepository)
        {
            _context = context;
            _productRepository = productRepository;
        }
        //Sản phẩm gợi ý
        public async Task<IViewComponentResult> InvokeAsync(int idsp)
        {
            var lstSanPham = await _productRepository.Product_Suggest(idsp);
            var idkh = HttpContext.Session.GetInt32("userId");
            var idFvrPrd = new List<int>();
            foreach (var prd in lstSanPham)
            {
                prd.IFavorite = idFvrPrd.Contains(prd.IdSp);
            }
            return View(lstSanPham);
        }
    }
}
