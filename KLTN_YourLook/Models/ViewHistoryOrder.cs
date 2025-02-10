using Data.Models;

namespace KLTN_YourLook.Models
{
    public class ViewHistoryOrder
    {
    }
    public class ViewCustomerHistoryOrderRaw //hiển thị các đơn hàng của khách hàng raw
    {
        public int IdDh { get; set; }
        public string MaDh { get; set; }
        public string PaymentName { get; set; }
        public int soluong { get; set; }
        public decimal TongTienThanhToan { get; set; }
        public string InforSP { get; set; }
        public bool ODSuccess { get; set; }
        public bool ODReadly { get; set; }
        public bool ODTransported { get; set; }
        public bool Complete { get; set; }
        public bool ODHuy { get; set; }
        public DateTime CreateDate { get; set; }
    }
    public class ViewCustomerHistoryOrder //hiển thị các đơn hàng của khách hàng
    {
        public int IdDh { get; set; }
        public string MaDh { get; set; }
        public string PaymentName { get; set; }
        public int soluong { get; set; }
        public decimal TongTienThanhToan { get; set; }
        public List<ViewInforOrder> InforSP { get; set; }
        public bool ODSuccess { get; set; }
        public bool ODReadly { get; set; }
        public bool ODTransported { get; set; }
        public bool Complete { get; set; }
        public bool ODHuy { get; set; }
        public bool Israted { get; set; } //đánh giá hay chưa
        public DateTime CreateDate { get; set; }
    }
    public class ViewInforOrder //thông tin sp in order
    {
        public string AnhSp { get; set; }
        public string TenSp { get; set; }
        public string NameColor { get; set; }
        public string NameSize { get; set; }
        public decimal PriceBy { get; set; }
        public int SoLuongSp { get; set; }
    }
}
