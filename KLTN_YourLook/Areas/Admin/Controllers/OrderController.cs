 using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using X.PagedList;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;

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
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
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
        [Route("orderdetail")]
        [HttpGet]
        public async Task<IActionResult> OrderDetail(int iddh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var lst= await _orderRepository.ShowOrderDetail(iddh);
            return View(lst);
        }
        [Route("orderupdate")]
        [HttpGet]
        public IActionResult OrderUpdate(int iddh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var dh= _context.DbOrders.Find(iddh);
            return View(dh);
        }
        [Route("orderupdate")]
        [HttpPost]
        public async Task<ActionResult> OrderUpdate(DbOrder model)
        {
            if(!ModelState.IsValid)
            {
                var (msg,error) = await _orderRepository.UpdateOrder(model.IdDh,model.ODSuccess, model.ODReadly, model.ODTransported, model.Complete, model.ODHuy);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] =error;
                }
                TempData["Success"] = msg;
                return RedirectToAction("order");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
    }
}
