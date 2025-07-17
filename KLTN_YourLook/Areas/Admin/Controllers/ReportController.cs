using System.Globalization;
using ClosedXML.Excel;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Areas.Admin.Repository;
using Microsoft.AspNetCore.Mvc;

namespace KLTN_YourLook.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class ReportController : Controller
    {        
        private readonly ReportRepository _reportRepository;
        public ReportController(ReportRepository reportRepository)
        {
            _reportRepository = reportRepository;
        }
        [Route("report")]
        [HttpGet]
        public IActionResult Report()
        {
            return View();
        }

        [Route("report_inventory")]
        [HttpGet]
        public async Task<IActionResult> Report_Inventory(string keyword, int quantity)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var lst = await _reportRepository.Search_Report_Inventory(keyword, quantity);
            ViewBag.keyword = keyword;
            ViewBag.quantity = quantity;
            return View(lst);
        }

        [Route("report_revenue")]
        [HttpGet]
        public async Task<IActionResult> Report_Revenue(DateTime? date, DateTime? todate)
        {
            var name = HttpContext.Session.GetString("NameAdmin");
            if (name == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var data = await _reportRepository.Search_Report_Revenue(date, todate);
            return View(data);
        }
        [Route("api_report_revenue")]
        [HttpGet]
        public async Task<IActionResult> Report_Revenue_Chart(DateTime? date, DateTime? todate)
        {
            var data = await _reportRepository.Search_Report_Revenue(date, todate);
            if (data == null) return Json(new { success = false });
            var sortedData = data.OrderBy(d => d.Ngay).ToList();

            var labels = sortedData.Select(x => x.Ngay.ToString("dd/MM/yyyy")).ToList();

            var chartData = new
            {
                labels,
                tongdonhang = sortedData.Select(x => x.Tongdonhang).ToList(),
                tongsanpham = sortedData.Select(x => x.Tongsanpham).ToList(),
                tongtien = sortedData.Select(x => x.Tongtien).ToList(),
                tongtienthanhtoan = sortedData.Select(x => x.Tongtienthanhtoan).ToList(),
                vouchergiam = sortedData.Select(x => x.Vouchergiam).ToList()
            };

            return Json(chartData);
        }
        //
        [HttpGet]
        [Route("inventory_export_excel")]
        public async Task<IActionResult> ExportInventoryListToExcel(string keyword, int quantity)
        {
            IEnumerable<AllProductViewModel> lstSanPham;
            var lst = await _reportRepository.Search_Report_Inventory(keyword, quantity);
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Danh sách sản phẩm Tồn kho");
                var currentRow = 1;
                
                worksheet.Range("A1:F1").Merge(); // Gộp 6 ô từ A1 đến F1
                worksheet.Cell(1, 1).Value = "DANH SÁCH SẢN PHẨM TỒN KHO";
                worksheet.Cell(1, 1).Style.Font.Bold = true;
                worksheet.Cell(1, 1).Style.Font.FontSize = 14;
                worksheet.Cell(1, 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Cell(1, 1).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
                
                // Tiêu đề cột
                currentRow = 3;
                 
                worksheet.Cell(currentRow, 1).Value = "Mã Sản Phẩm";
                    worksheet.Cell(currentRow, 1).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 2).Value = "Mã chi tiết sản phẩm";
                    worksheet.Cell(currentRow, 2).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 3).Value = "Tên sản phẩm";
                    worksheet.Cell(currentRow, 3).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 4).Value = "Màu";
                    worksheet.Cell(currentRow, 4).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 5).Value = "Size";
                    worksheet.Cell(currentRow, 5).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 6).Value = "Số lượng";
                    worksheet.Cell(currentRow, 6).Style.Font.Bold = true;
                foreach (var prd in lst)
                {
                    currentRow++;
                    worksheet.Cell(currentRow, 1).Value = prd.MaSp;
                    worksheet.Cell(currentRow, 2).Value = prd.MaCTSP;
                    worksheet.Cell(currentRow, 3).Value = prd.TenSp;
                    worksheet.Cell(currentRow, 4).Value = prd.NameColor;
                    worksheet.Cell(currentRow, 5).Value = prd.NameSize;
                    worksheet.Cell(currentRow, 6).Value = prd.Quantity;
                }
                // Định dạng bảng (tô đậm tiêu đề, căn giữa)
                worksheet.Range("A1:E1").Style.Font.Bold = true;
                worksheet.RangeUsed().Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Columns().AdjustToContents(); // Tự động điều chỉnh kích thước cột

                using (var stream = new MemoryStream())
                {
                    var date = DateTime.Now;
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();
                    return File(content, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "DanhSachTonKho.xlsx");
                }
            }
        }
        //
        [HttpGet]
        [Route("revenue_export_excel")]
        public async Task<IActionResult> ExportRevenueListToExcel(DateTime? date, DateTime? todate)
        {
            IEnumerable<Report_Revenue_ViewModel> lstdata;
            var lst = await _reportRepository.Search_Report_Revenue(date, todate);
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Doanh thu");
                var currentRow = 1;

                worksheet.Range("A1:F1").Merge(); // Gộp 6 ô từ A1 đến F1
                worksheet.Cell(1, 1).Value = "Doanh thu";
                worksheet.Cell(1, 1).Style.Font.Bold = true;
                worksheet.Cell(1, 1).Style.Font.FontSize = 14;
                worksheet.Cell(1, 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Cell(1, 1).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

                // Tiêu đề cột
                currentRow = 3;

                worksheet.Cell(currentRow, 1).Value = "Ngày";
                worksheet.Cell(currentRow, 1).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 2).Value = "Tổng đơn hàng";
                worksheet.Cell(currentRow, 2).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 3).Value = "Tổng sản phẩm";
                worksheet.Cell(currentRow, 3).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 4).Value = "Tổng tiền";
                worksheet.Cell(currentRow, 4).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 5).Value = "Tổng tiền thanh toán";
                worksheet.Cell(currentRow, 5).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 6).Value = "Giảm giá từ voucher";
                worksheet.Cell(currentRow, 6).Style.Font.Bold = true;
                foreach (var prd in lst)
                {
                    currentRow++;
                    worksheet.Cell(currentRow, 1).Value = prd.Ngay;
                    worksheet.Cell(currentRow, 2).Value = prd.Tongdonhang;
                    worksheet.Cell(currentRow, 3).Value = prd.Tongsanpham;
                    worksheet.Cell(currentRow, 4).Value = prd.Tongtien;
                    worksheet.Cell(currentRow, 5).Value = prd.Tongtienthanhtoan;
                    worksheet.Cell(currentRow, 6).Value = prd.Vouchergiam;
                }
                // Định dạng bảng (tô đậm tiêu đề, căn giữa)
                worksheet.Range("A1:E1").Style.Font.Bold = true;
                worksheet.RangeUsed().Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Columns().AdjustToContents(); // Tự động điều chỉnh kích thước cột

                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();
                    return File(content, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "DanhSachTonKho.xlsx");
                }
            }
        }
        //hiển thị gọi ý tìm kiếm mã chi tiết sp
        [Route("api_find_mctsp")]
        [HttpGet]
        public async Task<JsonResult> Find_Mctsp(string keyword)
        {
            var sugget= await _reportRepository.Sugget_Mactsp(keyword);
            var result = sugget.Select(x => new
            {
                mactsp=x.MaCTSP
            }).ToList();
            return Json(result);
        }
    }
}
