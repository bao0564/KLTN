using Data.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Component
{
    [Area("admin")]
    [Route("admin")]
    public class View_Admin_Order:ViewComponent
    {
        private readonly OrderRepository _orderRepository;
        public View_Admin_Order(OrderRepository orderRepository)
        { 
            _orderRepository = orderRepository;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            DateTime date= DateTime.Now.Date;
            var result = await _orderRepository.GetAllOrderDate(date);
            return View(result);
        }
    }
}
