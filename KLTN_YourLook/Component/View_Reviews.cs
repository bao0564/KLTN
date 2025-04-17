using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Component
{
    public class View_Reviews:ViewComponent
    {
        private readonly SP_Product _productRepository;
        public View_Reviews(SP_Product productRepository)
        {
            _productRepository = productRepository;
        }
        public async Task<IViewComponentResult> InvokeAsync(int idsp)
        {
            var pageReview= await _productRepository.ViewRattings(idsp);
            return View(pageReview);
        }
    }
}
