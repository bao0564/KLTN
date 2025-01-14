using Data.Models;
using KLTN_YourLook.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Component
{
    public class ViewProductInCart:ViewComponent
    {
        private readonly YourlookContext _context;
        //private readonly SP_OrderCart _sp_ordercart;
        public ViewProductInCart(YourlookContext context)
        {
            _context = context;
            //_sp_ordercart = sp_ordercart;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            var totalProducts = 0;
            if (checkkh != null)
            {
                int idkh = checkkh.Value;
                totalProducts = _context.DbCarts.Where(cr => cr.IdKh == idkh).Sum(cr => cr.ProductQuantity);
            }

            var model = new Product_Quantity_In_Cart
            {
                totalProducts = totalProducts
            };

            return View(model);
        }
    }
}
