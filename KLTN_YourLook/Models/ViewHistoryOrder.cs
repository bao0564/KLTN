using Data.Models;

namespace yourlook.Models
{
    public class ViewHistoryOrder
    {
        public int MaDh {  get; set; }
        public decimal? TongTien { get; set; }
        public decimal? TongTienThanhToan { get; set; }
        public string? PaymentName { get; set; }
        public string? MaVoucher { get; set; }
        public decimal? Giamgia { get; set; }
        public decimal? Ship { get; set; }
        public string? GhiChu { get; set; }
        public bool ODSuccess { get; set; }
        public bool ODReadly { get; set; }
        public bool ODTransported { get; set; }
        public bool Complete { get; set; }
        public DateTime? CreateDate { get; set; }
        public List<DbOrderDetail> DhDetail { get; set; }
    }
}
