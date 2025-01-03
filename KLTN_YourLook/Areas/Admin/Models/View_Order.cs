using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Order
    {
    }
    public class AllOrderViewModle
    {
        public int IdDh { get; set; }
        public string MaDh { get; set; }
        public string TenKh { get; set; }
        public string NguoiNhan { get; set; }
        public string InforAddress { get; set; }
        public int soluong { get; set; }
        public decimal TongTien { get; set; }
        public decimal TongTienThanhToan { get; set; }
        public DateTime CreateDate { get; set; }
        public bool ODSuccess { get; set; }
        public bool ODReadly { get; set; }
        public bool ODTransported { get; set; }
        public bool Complete { get; set; }
        public bool ODHuy { get; set; }
    }
    public class OrderDetailViewModelRaw //chi tiết đơn hàng raw
    {
        public string MaDh { get; set; }
        public string InForSp { get; set; }
        public int IdKh { get; set; }
        public string TenKh { get; set; }
        public string NguoiNhan { get; set; }
        public string DiaChi { get; set; }
        public string GhiChu { get; set; }
        public decimal TongTien { get; set; }
        public decimal GiamGia { get; set; }
        public decimal Ship { get; set; }
        public decimal TongTienThanhToan { get; set; }

    }
    public class OrderDetailViewModel//chi tiết đơn hàng
    {
        public string MaDh { get; set; }
        public List<ViewInForSP> InForSp { get; set; }
        public int IdKh { get; set; }
        public string TenKh { get; set; }
        public string NguoiNhan { get; set; }
        public string DiaChi { get; set; }
        public string GhiChu { get; set; }
        public decimal TongTien { get; set; }
        public decimal GiamGia { get; set; }
        public decimal Ship { get; set; }
        public decimal TongTienThanhToan { get; set; }

    }
    public class ViewInForSP 
    {        
        public string MaSp { get; set; }
        public string TenSp { get; set; }
        public string AnhSp { get; set; }
        public string NameColor { get; set; }
        public string NameSize { get; set; }
        public int SoLuongSp { get; set; }
        public decimal GiaLoai { get; set; }
    }
}
