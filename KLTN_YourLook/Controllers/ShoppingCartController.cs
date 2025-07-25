﻿using Data.Models;
using DocumentFormat.OpenXml.Office2016.Drawing.Command;
using KLTN_YourLook.Extension;
using KLTN_YourLook.Interface;
using KLTN_YourLook.Models;
using KLTN_YourLook.Repository_YL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using KLTN_YourLook.Areas.Admin.Repository;

namespace KLTN_YourLook.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly YourlookContext _context;
        private readonly SP_OrderCart _orderCart;
        private readonly OrderRepository _orderRepository;
        public ShoppingCartController(YourlookContext context, SP_OrderCart orderCart, OrderRepository orderRepository)
        {
            _context = context;
            _orderCart = orderCart;
            _orderRepository = orderRepository;
        }
        public async Task<IActionResult> Cart()
        {
            var idkh = HttpContext.Session.GetInt32("userId");
            var userAdress = _context.DbAddresss.Where(x => x.IdKh == idkh).ToList();
            var pay = _context.DbPayments.ToList();
            var voucher = _context.DbVouchers.ToList();
            var cart =await _orderCart.Cart_View(idkh);
            var item = new ShoppingCartDetail
            {
                Address = userAdress,
                Items = cart,
                Payments = pay,
                Vouchers = voucher
            };

            return View(item);
        }
        [AllowAnonymous]
        [HttpPost]
        public async Task<IActionResult> AddToCart(int idsp, int quantity, int sizeid, int colorid)
        {
            var prd = _context.DbProductDetails.FirstOrDefault(pd => pd.IdSp == idsp && pd.SizeId == sizeid && pd.ColorId == colorid);
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return Json(new { success = false, msg = "Bạn chưa đăng nhập" });
            }
            int idkh = checkkh.Value;
            var checkproduct = _context.DbProducts.FirstOrDefault(x => x.IdSp == idsp);
            if (checkproduct == null)
            {
                return Json(new { success = false, msg = "sản phẩm không tồn tại" });
            }
            var quantityprd = prd.Quantity;
            if(quantityprd == 0)
            {
                return Json(new { success = false, msg = "sản phẩm hiện tại đã hết hàng vui lòng chọn sản phẩm khác để thay thế" });
            }
            //if(quantity > quantityprd)
            //{
            //    return Json(new { success = false, msg = "Số lượng không được vượt quá số lượng còn lại của sản phẩm" });
            //}
            var (msg,error) = await _orderCart.Add_To_Cart(idsp, idkh, quantity, colorid, sizeid);//thêm sp
            if (!string.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, msg=msg});
            }
            return Json(new { success = false, msg = error });
        }
        [AllowAnonymous]
        [HttpPost]
        public async Task<IActionResult> UpdateProductInCart(int idsp, int quantity, int sizeid, int colorid)
		{
			var checkkh = HttpContext.Session.GetInt32("userId");
			if (checkkh == null)
			{
				return Json(new { success = false, msg = "Bạn chưa đăng nhập" });
			}
			int idkh = checkkh.Value;
            var result = await _orderCart.Update_Cart(idsp,idkh,quantity,colorid,sizeid);
            if (result)
            {
                return Json(new { success = true, msg = "Cập nhật thành công" });
            }
            else
            {
                return Json(new { success = false, msg = "cập nhật thất bại" });
            }
		}
        //////hiển thị địa chỉ
        //public IActionResult addressUser()
        //{
        //    var idkh = HttpContext.Session.GetInt32("userid");
        //    var adress = db.DbAddreses.Where(X => X.MaKh == idkh.Value).ToList();
        //    return PartialView("addressUser", adress);
        //}
        [HttpPost]
        public IActionResult Checkout([FromBody] CheckoutRequest request)
        {
			//lưu các thông tin chọn của khách hàng vào từng sesson riêng (lấy trong request js)
			HttpContext.Session.SetJson("Order", request.selectedProducts);
            HttpContext.Session.SetJson("OrderInfo", request.selectedInfors);
            HttpContext.Session.SetJson("OrderPayment", request.selectedPayments);
            HttpContext.Session.SetJson("OrderVoucher", request.selectedVouchers);
            return Json(new { success = true });
        }
        public IActionResult CheckOutOrder()
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            //gọi sesson ra
            var order = HttpContext.Session.GetJson<List<ShoppingCartItem>>("Order") ?? new List<ShoppingCartItem>();
            var orderInfor = HttpContext.Session.GetJson<addressInforItem>("OrderInfo") ?? new addressInforItem();
            var orderPayment = HttpContext.Session.GetJson<paymentInforItem>("OrderPayment") ?? new paymentInforItem();
            var orderVoucher = HttpContext.Session.GetJson<voucherInfoItem>("OrderVoucher") ?? new voucherInfoItem();
            //nhét vào CheckoutRequest
            var item = new CheckoutRequest
            {
                selectedProducts=order,
                selectedInfors=orderInfor,
                selectedPayments=orderPayment,
                selectedVouchers=orderVoucher
            };
            return View(item);
        }
        [HttpPost]
        public async Task<IActionResult> PayOrder()
        {
            try
            {
				//gọi sesson ra
				var order = HttpContext.Session.GetJson<List<ShoppingCartItem>>("Order") ?? new List<ShoppingCartItem>();
				var orderInfor = HttpContext.Session.GetJson<addressInforItem>("OrderInfo") ?? new addressInforItem();
				var orderPayment = HttpContext.Session.GetJson<paymentInforItem>("OrderPayment") ?? new paymentInforItem();
				var orderVoucher = HttpContext.Session.GetJson<voucherInfoItem>("OrderVoucher") ?? new voucherInfoItem();
				//tính tiền đã trừ đi mã giảm giá
				var tongtien = order.Sum(X => X.Total);
				int soluong = order.Sum(Y => Y.ProductQuantity);
                var idVoucher = orderVoucher.IdVoucher.HasValue ? orderVoucher.IdVoucher : null;
                int giamgiavalue = orderVoucher?.ValueVoucher ?? 0;
				decimal giamgia = giamgiavalue > 0 ? (tongtien * giamgiavalue / 100) : 0; ;
				var Giam = giamgia>0 ? giamgia.ToString("N0") + "VND" :"0";
                decimal ship = 0;
				decimal GiaCuoi = tongtien - giamgia + ship;
				decimal tongtiensanpham = GiaCuoi;
				var emailkh = HttpContext.Session.GetString("userEmail");
                var checkkh = HttpContext.Session.GetInt32("userId");
                if(checkkh == null)
                {
					return Json(new { success = false, msg = "Bạn chưa đăng nhập" });
				}
                if (emailkh == null)
                {
                    return Json(new { success = false, msg = "Bạn chưa đăng nhập" });
                }
                int idkh = checkkh.Value;

                var (newIdDH, newMaDH) = await _orderCart.Add_Order(idkh,emailkh,orderInfor.TenKh,orderInfor.Sdt,orderInfor.City,orderInfor.District,orderInfor.Ward,orderInfor.DiaChi
                                                           ,tongtien,tongtiensanpham,soluong,orderPayment.PaymentId,orderPayment.PayName, idVoucher
                                                           ,giamgiavalue, giamgia,ship,orderInfor.GhiChu);
                foreach (var item in order)
                {
                    var add_orderdetail = await _orderCart.Add_OrderDetail(newIdDH, newMaDH, item.IdSp, item.MaSp, item.ColorId, item.SizeId,item.GiaLoai, item.ProductQuantity);
                    //trừ số lượng tồn ,tăng số lượng bán
                    var slprd = _context.DbProductDetails.FirstOrDefault(pd=>pd.IdSp==item.IdSp && pd.ColorId==item.ColorId && pd.SizeId==item.SizeId);
                    if (slprd != null)
                    {
                        slprd.Quantity -= item.ProductQuantity;
                        slprd.SoLuongBan += item.ProductQuantity;
                        _context.DbProductDetails.Update(slprd);
                    }

                    //xóa sp đã thanh toán ra khỏi giỏ hàng
                    var spcart=_context.DbCarts.FirstOrDefault(cr=>cr.IdSp==item.IdSp && cr.IdKh==idkh && cr.ColorId==item.ColorId && cr.SizeId==item.SizeId);
                    if(spcart != null)
                    {
                        _context.Remove(spcart);
                    }
                }
                if (orderPayment.PaymentId!=1)
                {
                    var updateTrangThaiDH = await _orderRepository.UpdateOrder(newIdDH, false, true, false, false, false, false, orderInfor.TenKh);
                }
                await _context.SaveChangesAsync();
                HttpContext.Session.Remove("Order");
                HttpContext.Session.Remove("OrderInfor");
                HttpContext.Session.Remove("OrderPayment");
                HttpContext.Session.Remove("OrderVoucher");
                
                // Trả về view thành công
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                // Log lỗi chi tiết vào console hoặc log file
                var errorMessage = ex.Message;
                if (ex.InnerException != null)
                {
                    errorMessage += " Inner Exception: " + ex.InnerException.Message;
                }
                return Json(new { success = false, message = "Có lỗi xảy ra: " + errorMessage });
            }
        }
        public IActionResult PayOrderSuccess()
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            return View();
        }
        public IActionResult PaymentSpace()
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return RedirectToAction("Login", "Access");
            }
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> Delete(int idsp, int colorid, int sizeid)
        {
            var checkkh = HttpContext.Session.GetInt32("userId");
            if (checkkh == null)
            {
                return Json(new { success = false, msg = "Bạn chưa đăng nhập" });
            }
            int idkh = checkkh.Value;
            var result= await _orderCart.Delete_Cart(idsp,idkh,colorid,sizeid);
            if (result)
            {
                return Json(new { success = true, msg = "Sản phẩm đã được xóa" });
            }
            else
            {
                return Json(new { success = false, msg = "lỗi" });
            }
        }

        //[HttpGet]
        //public IActionResult ViewProductInCart()
        //{
        //    return ViewComponent("ViewProductInCart");
        //}
    }
}
