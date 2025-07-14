namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Report
    {
    }
    public class Report_Inventory_ViewModel
    {
        public int IdSp { get; set; }
        public string MaSp { get; set; }
        public string MaCTSP { get; set; }
        public string TenSp { get; set; }
        public string NameSize { get; set; }
        public string NameColor { get; set; }
        public int Quantity { get; set; }
    }
    public class Report_Revenue_ViewModel
    {
        public DateTime Ngay { get; set; }
        public int Tongdonhang { get; set; }
        public int Tongsanpham { get; set; }
        public decimal Tongtien { get; set; }
        public decimal Tongtienthanhtoan { get; set; }
        public decimal Vouchergiam { get; set; }
        public int Tongdonhoanthanh { get; set; }
        public int Tongdonhuy { get; set; }
    }
    public class Sugget_Mactsp
    {
        public string MaCTSP { get; set; }
    }
}
