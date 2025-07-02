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
            var(lst,msg,error) = await _reportRepository.Search_Report_Inventory(keyword, quantity);
            ViewBag.keyword = keyword;
            ViewBag.quantity = quantity;
            if (!string.IsNullOrEmpty(error))
            {
                TempData["Error"] = error;
                return View();
            }
            TempData["Success"] = msg;
            return View(lst);
        }

        [HttpGet]
        [Route("inventory_export_excel")]
        public async Task<IActionResult> ExportInventoryListToExcel(string keyword, int quantity)
        {
            IEnumerable<AllProductViewModel> lstSanPham;
            var (lst, msg, error) = await _reportRepository.Search_Report_Inventory(keyword, quantity);
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
                currentRow = 2;

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
    }
}
