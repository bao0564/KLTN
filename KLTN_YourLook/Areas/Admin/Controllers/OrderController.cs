using Data.Models;
using iText.IO.Font;
using iText.Kernel.Font;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Borders;
using iText.Layout.Element;
using iText.Layout.Properties;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using KLTN_YourLook.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
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
        public async Task<IActionResult> Order(int? page,bool? odsuccess,bool? odreadly,bool? odtranport,bool? complete,bool? odhuy,string? keyword,string date ,string todate)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 20;
            int pageNumber = page ?? 1;
            IEnumerable<AllOrderViewModle> order;//khai báo model chứa dữ liệu
            if (odsuccess.HasValue || odreadly.HasValue || odtranport.HasValue || complete.HasValue)
            {
                order = await _orderRepository.GetAllOrderFilter(odsuccess, odreadly, odtranport, complete, odhuy);
            }
            else if (!string.IsNullOrEmpty(keyword))
            {
                order=await _orderRepository.SearchOrder(keyword);
                ViewBag.keyword = keyword;
            }
            else if (!string.IsNullOrEmpty(date) && !string.IsNullOrEmpty(todate))
            {
                var formattedDate = DateTime.Parse(date);
                var formattedToDate = DateTime.Parse(todate);
                order = await _orderRepository.GetAllOrderDateToDate(formattedDate, formattedToDate);                
                ViewBag.date = date;
                ViewBag.todate = todate;
            }
            else if (!string.IsNullOrEmpty(date))
            {
                var formattedDate = DateTime.Parse(date);
                order = await _orderRepository.GetAllOrderDate(formattedDate);
                ViewBag.date = date;
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
        [HttpGet("orderexportbillpdf")]
        public async Task<IActionResult> ExportBillToPDF(int iddh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var oddr = await _orderRepository.ShowOrderDetail(iddh);
            var odd=oddr.FirstOrDefault();
            DateTime date=DateTime.Now;
            // Tạo MemoryStream để lưu file PDF
            using (MemoryStream ms = new MemoryStream())
            {
                PdfWriter writer = new PdfWriter(ms);
                PdfDocument pdf = new PdfDocument(writer);
                Document document = new Document(pdf);

                // Nhúng font hỗ trợ tiếng Việt
                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                PdfFont font = PdfFontFactory.CreateFont(fontPath, PdfEncodings.IDENTITY_H);

                // tiêu đề
                document.Add(new Paragraph("THÔNG TIN ĐƠN HÀNG")
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetFontSize(18)
                    .SetBold()
                    .SetFont(font));

                // bảng 1 chứa mã vạch               
                iText.Layout.Element.Table table1 = new iText.Layout.Element.Table(1).UseAllAvailableWidth();
                    table1.SetHorizontalAlignment(iText.Layout.Properties.HorizontalAlignment.CENTER);

                //table1.AddHeaderCell("mã dh").SetFont(font);
                table1.AddCell(odd.MaDh)
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetHeight(100)
                    .SetFont(font);
                //bảng 2 chứa thông tin người gửi /người nhận 
                iText.Layout.Element.Table table2 = new iText.Layout.Element.Table(2).UseAllAvailableWidth();
                    table2.SetHorizontalAlignment(iText.Layout.Properties.HorizontalAlignment.CENTER);

                Cell cell2_1 = new Cell();
                Cell cell2_2 = new Cell(); 
                Div div1_1 = new Div();
                    div1_1.SetHorizontalAlignment(iText.Layout.Properties.HorizontalAlignment.CENTER);
                    div1_1.Add(new Paragraph("Từ:")
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                    div1_1.Add(new Paragraph("YourLook - (+84) 775368054")
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                        .SetFontSize(13)
                        .SetBold());
                Div div1_2 = new Div();
                    div1_2.Add(new Paragraph("Địa chỉ: 55 ngõ 62 Trâu Quỳ Gia Lâm Hà Nội"))
                            .SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT);
                    div1_2.Add(new Paragraph($"Ngày tạo:{date.ToString("dd/MM/yyyy")}"))
                        .SetFontSize(10)
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT);
                    
                Div div2_1 = new Div();
                div2_1.SetHorizontalAlignment(iText.Layout.Properties.HorizontalAlignment.CENTER);
                div2_1.Add(new Paragraph("Tới:").SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT));
                div2_1.Add(new Paragraph($"{odd.NguoiNhan} - (+84){odd.Sdt}")
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetFontSize(13)
                    .SetBold());
                Div div4 = new Div().Add(new Paragraph($"Địa chỉ: {odd.DiaChi}"))
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT)
                    .SetBold();
                Div div5 = new Div().Add(new Paragraph($"Ghi Chú: {odd.GhiChu}"))
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.LEFT)
                    .SetBold();
                // Thêm tất cả Div vào Cell
                cell2_1.Add(div1_1);
                cell2_1.Add(div1_2);
                cell2_2.Add(div2_1);
                cell2_2.Add(div4);
                cell2_2.Add(div5);

                table2.AddCell(cell2_1).SetFont(font);
                table2.AddCell(cell2_2).SetFont(font);
                //bảng 3
                iText.Layout.Element.Table table3 = new iText.Layout.Element.Table(3).UseAllAvailableWidth();// bảng sản phẩm

                // Xóa toàn bộ border của bảng
                table3.SetBorder(Border.NO_BORDER);
                Cell hcell3_1 = new Cell().Add(new Paragraph("Name"))
                    .SetBorderLeft(Border.NO_BORDER)
                    .SetBorderRight(Border.NO_BORDER)
                    .SetWidth(UnitValue.CreatePercentValue(60))
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetFontSize(11)
                    .SetBold()
                    .SetFont(font);
                Cell hcell3_2 = new Cell().Add(new Paragraph("CL-S"))
                    .SetBorderLeft(Border.NO_BORDER)
                    .SetBorderRight(Border.NO_BORDER)
                    .SetWidth(UnitValue.CreatePercentValue(20))
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetFontSize(11)
                    .SetBold()
                    .SetFont(font);
                Cell hcell3_3 = new Cell().Add(new Paragraph("Qty"))
                    .SetBorderLeft(Border.NO_BORDER)
                    .SetBorderRight(Border.NO_BORDER)
                    .SetWidth(UnitValue.CreatePercentValue(10))
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.RIGHT)
                    .SetFontSize(11)
                    .SetBold()
                    .SetFont(font);
                table3.AddHeaderCell(hcell3_1);
                table3.AddHeaderCell(hcell3_2);
                table3.AddHeaderCell(hcell3_3);
                foreach (var item in odd.InForSp)
                {
                    Cell cell3_1 = new Cell().Add(new Paragraph(item.TenSp))
                        .SetBorderLeft(Border.NO_BORDER)
                        .SetBorderRight(Border.NO_BORDER)
                        .SetWidth(UnitValue.CreatePercentValue(60))
                        .SetFont(font);

                    Cell cell3_2 = new Cell().Add(new Paragraph($"{item.NameColor} - {item.NameSize}" ))
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                        .SetBorderLeft(Border.NO_BORDER)
                        .SetBorderRight(Border.NO_BORDER)
                        .SetWidth(UnitValue.CreatePercentValue(20))
                        .SetFont(font);

                    Cell cell3_3 = new Cell().Add(new Paragraph(item.SoLuongSp.ToString()))
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.RIGHT)
                        .SetBorderLeft(Border.NO_BORDER)
                        .SetBorderRight(Border.NO_BORDER)
                        .SetWidth(UnitValue.CreatePercentValue(20))
                        .SetFont(font);

                    table3.AddCell(cell3_1);
                    table3.AddCell(cell3_2);
                    table3.AddCell(cell3_3);
                }
                //bảng 4
                iText.Layout.Element.Table table4 = new iText.Layout.Element.Table(3).UseAllAvailableWidth();

                Cell cell4_1 = new Cell().Add(new Paragraph($"{odd.PaymentName}")
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                        .SetBold()
                        .SetFontSize(20)
                        .SetFont(font));
                Cell cell4_2 = new Cell().Add(new Paragraph($"Thời gian đặt hàng: {odd.CreateDate.ToString("dd/MM/yyy")}")
                        .SetFontSize(11)
                        .SetFont(font));

                Cell cell4_3 = new Cell().Add(new Paragraph($"{odd.IdDh}")
                        .SetBold()
                        .SetFont(font));
                table4.AddCell(cell4_1);
                table4.AddCell(cell4_2);
                table4.AddCell(cell4_3);

                //bảng 5
                iText.Layout.Element.Table table5 = new iText.Layout.Element.Table(2).UseAllAvailableWidth();

                Cell cell5_1 = new Cell().Add(new Paragraph($"{odd.TongTienThanhToan:N0} VNĐ")
                        .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                        .SetBold()
                        .SetFontSize(20)
                        .SetFont(font))
                        .SetWidth(UnitValue.CreatePercentValue(60));
                Cell cell5_2 = new Cell().Add(new Paragraph("mã code đơn hàng")                        
                        .SetFontSize(11)
                        .SetFont(font))
                        .SetWidth(UnitValue.CreatePercentValue(40));
                table5.AddCell(cell5_1)
                    .SetHeight(100);
                table5.AddCell(cell5_2)
                    .SetHeight(100);

                document.Add(table1);
                document.Add(table2);
                document.Add(table3);
                document.Add(table4);
                document.Add(table5);

                document.Close();

                return File(ms.ToArray(), "application/pdf", $"Bill_{odd.IdDh}.pdf");
            }
        }
    }
}
