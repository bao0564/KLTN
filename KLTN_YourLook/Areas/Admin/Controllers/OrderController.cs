using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using X.PagedList;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class OrderController : Controller
    {
        private readonly YourlookContext _context;
        private readonly OrderRepository _orderRepository; //các procedure được đặt ở đây=
        public OrderController(YourlookContext context,OrderRepository orderRepository)
        {
            _context = context;
            _orderRepository = orderRepository;
        }
        [Route("order")]
        [HttpGet]
        public async Task<IActionResult> Order(int? page,bool? odsuccess,bool? odreadly,bool? odtranport,bool? complete,string? keyword)
        {
            int pageSize = 20;
            int pageNumber = page ?? 1;
            IEnumerable<AllOrderViewModle> order;//khai báo model chứa dữ liệu
            //if (odsuccess.HasValue || odreadly.HasValue || odtranport.HasValue || complete.HasValue )
            //{
            //    order = await _orderRepository.GetAllOrderFilter(odsuccess, odreadly, odtranport, complete);
            //}
            //else
            if (!string.IsNullOrEmpty(keyword))
            {
                order=await _orderRepository.SearchOrder(keyword);
                ViewBag.keyword = keyword;
            }
            else
            {
                order = await _orderRepository.GetAllOrder();
            }
            PagedList<AllOrderViewModle> lstorder = new PagedList<AllOrderViewModle>(order, pageNumber, pageSize);
            return View(lstorder);
        }
    }
}
