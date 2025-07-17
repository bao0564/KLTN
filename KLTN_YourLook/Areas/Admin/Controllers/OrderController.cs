using System.IO.Packaging;
using ClosedXML.Excel;
using Data.Models;
using DocumentFormat.OpenXml.Drawing.Charts;
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
using static System.Runtime.InteropServices.JavaScript.JSType;
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
        public async Task<IActionResult> Order(int? page,bool? odsuccess,bool? odreadly,bool? odtranport,bool? complete,bool? odhuy, bool? odreturn, string? keyword,string? date ,string? todate)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            int pageSize = 40;
            int pageNumber = page ?? 1;
            IEnumerable<AllOrderViewModle> order;//khai báo model chứa dữ liệu

            order=await _orderRepository.SearchOrder( keyword,odsuccess, odreadly, odtranport, complete, odhuy, odreturn, date, todate);
            ViewBag.odsuccess = odsuccess;
            ViewBag.odreadly = odreadly;
            ViewBag.odtranport = odtranport;
            ViewBag.complete = complete;
            ViewBag.odhuy = odhuy;
            ViewBag.odreturn = odreturn;
            ViewBag.keyword = keyword;
            ViewBag.date = date;
            ViewBag.todate = todate;
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
            var viewModel = new ViewUpdateOrder
            {
                IdDh = dh.IdDh,
                ODSuccess = dh.ODSuccess,
                ODReadly = dh.ODReadly,
                ODTransported = dh.ODTransported,
                Complete = dh.Complete,
                ODHuy = dh.ODHuy
            };

            return View(viewModel);
        }
        [Route("orderupdate")]
        [HttpPost]
        public async Task<ActionResult> OrderUpdate(ViewUpdateOrder model)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            if (ModelState.IsValid)
            {
                var (msg,error) = await _orderRepository.UpdateOrder(model.IdDh,model.ODSuccess, model.ODReadly, model.ODTransported, model.Complete, model.ODHuy, model.ODReturn,name);
                if (!string.IsNullOrEmpty(error))
                {
                    TempData["Error"] =error;
                    return View(model);
                }
                TempData["Success"] = msg;
                return RedirectToAction("order");
            }
            TempData["Error"] = "dữ liệu không hợp lệ";
            return View(model);
        }
        //phiếu in pdf
        private byte[] GeneratePdf(List<OrderDetailViewModel> orders)
        {
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

                foreach (var odd in orders)
                {
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

                        Cell cell3_2 = new Cell().Add(new Paragraph($"{item.NameColor} - {item.NameSize}"))
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
                    document.Add(new Paragraph("\n"));
                    if (odd != orders.Last())
                    {
                        document.Add(new AreaBreak(AreaBreakType.NEXT_PAGE));
                    }
                }

                //cập nhật đơn hàng 
                // var Dborder= _context.DbOrders.Find()
                document.Close();
                return ms.ToArray();
            }
        }
        [HttpGet("printbillpdf")]//xuất pdf chi tiết đon hàng
        public async Task<IActionResult> PrintBillToPDF(int iddh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            //IEnumerable<OrderDetailViewModel> orders;
            var (orders, error) = await _orderRepository.PrintOrderDetail(iddh);//trong sp nếu iddh trống thì in tất cả đơnh chưa in ,có iddh thì in mỗi đh đó
            DateTime date=DateTime.Now;
            if (!string.IsNullOrEmpty(error))
            {
                TempData["Error"] = error;
                return RedirectToAction("Order"); 
            }
            //return File(ms.ToArray(), "application/pdf", "Bill_ODD.pdf");
            byte[] pdfBytes = GeneratePdf(orders);
            return File(pdfBytes, "application/pdf", "Bill_ODD"+$"{iddh}"+".pdf");
        }

        [HttpGet("reprintbillpdf")]//in lại pdf chi tiết đon hàng
        public async Task<IActionResult> ReprintBillToPDF(int iddh)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var (orders, error) = await _orderRepository.RePrintOrderDetail(iddh);
            DateTime date = DateTime.Now;
            if (!string.IsNullOrEmpty(error))
            {
                TempData["Error"] = error;
                return RedirectToAction("OrderDetail");
            }
            byte[] pdfBytes = GeneratePdf(orders);
            return File(pdfBytes, "application/pdf", "Bill_ODD"+$"{iddh}"+"_(InLai).pdf");
        } 

        [HttpGet]
        [Route("orderexportexcel")]//xuất excel tất cả thông tin đơn hàng (không phải chi tiết)
        public async Task<IActionResult> ExportOrderListToExcel(bool? odsuccess, bool? odreadly, bool? odtranport, bool? complete, bool? odhuy, bool? odreturn, string? keyword, string date, string todate)
        {
            IEnumerable<AllOrderViewModle> order;
            order = await _orderRepository.SearchOrder(keyword, odsuccess, odreadly, odtranport, complete, odhuy, odreturn, date, todate);
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Danh sách đơn hàng");
                var currentRow = 1;

                // Tiêu đề cột
                worksheet.Cell(currentRow, 1).Value = "Mã đơn hàng";
                worksheet.Cell(currentRow, 2).Value = "Tên khách hàng";
                worksheet.Cell(currentRow, 3).Value = "Số Lượng SP";
                worksheet.Cell(currentRow, 4).Value = "Tổng tiền";
                worksheet.Cell(currentRow, 5).Value = "Loại thanh toán";
                worksheet.Cell(currentRow, 6).Value = "Người nhận";
                worksheet.Cell(currentRow, 7).Value = "Trạng thái";
                worksheet.Cell(currentRow, 8).Value = "Ngày đặt";

                // Duyệt danh sách đơn hàng và ghi dữ liệu vào file Excel
                foreach (var od in order)
                {
                    currentRow++;
                    worksheet.Cell(currentRow, 1).Value = od.MaDh;
                    worksheet.Cell(currentRow, 2).Value = od.TenKh;
                    worksheet.Cell(currentRow, 3).Value = od.soluong;
                    worksheet.Cell(currentRow, 4).Value = $"{od.TongTienThanhToan:N0} VNĐ";
                    worksheet.Cell(currentRow, 5).Value = od.PaymentName;
                    worksheet.Cell(currentRow, 6).Value = od.NguoiNhan;
                    if (od.ODSuccess)
                    {
                        worksheet.Cell(currentRow, 7).Value = "Đặt hàng thành công";
                    }
                    else if (od.ODReadly)
                    {
                        worksheet.Cell(currentRow, 7).Value = "Chuẩn bị hàng thành công";
                    }
                    else if (od.ODTransported)
                    {
                        worksheet.Cell(currentRow, 7).Value = "Đang vận chuyển";
                    }
                    else if (od.Complete)
                    {
                        worksheet.Cell(currentRow, 7).Value = "Đơn hàng thành công";
                    }
                    else if(od.ODHuy)
                    {
                        worksheet.Cell(currentRow, 7).Value = "Đơn hàng đã hủy";
                    }
                    worksheet.Cell(currentRow, 8).Value =  od.CreateDate.ToString("dd/MM/yyyy");
                }
                // Định dạng bảng (tô đậm tiêu đề, căn giữa)
                worksheet.Range("A1:E1").Style.Font.Bold = true;
                worksheet.RangeUsed().Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Columns().AdjustToContents(); // Tự động điều chỉnh kích thước cột

                // Xuất file
                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();
                    return File(content, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "DanhSachDonHang.xlsx");
                }
            }
        }
    }
}
  