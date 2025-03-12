using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbOrder")]
    public class DbOrder:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdDh { get; set; }
        [StringLength(500)]
        public string? MaDh { get; set; }
        [ForeignKey("IdKh")]
        public int IdKh { get; set; }
        [StringLength(30)]
        public string NguoiNhan { get; set; }
        [StringLength(25)]
        public string EmailKh { get; set; }
        [StringLength(15)]
        public string Sdt { get; set; }
        [StringLength(10)]
        public string City { get; set; }
        [StringLength(10)]
        public string District { get; set; }
        [StringLength(10)]
        public string Ward { get; set; }
        [StringLength(500)]
        public string DiaChi { get; set; }
        public decimal TongTien { get; set; }
        public decimal TongTienThanhToan { get; set; }
        public int soluong { get; set; }
        public int PaymentId { get; set; }
        [StringLength(50)]
        public string PaymentName { get; set; }
        public int? IdVoucher { get; set; }
        public int? ValueVoucher { get; set; }
        public decimal? Giamgia { get; set; }
        public decimal Ship { get; set; }
        public string? GhiChu { get; set; }
        public bool ODSuccess { get; set; }
        public bool ODReadly { get; set; }
        public bool ODTransported { get; set; }
        public bool Complete { get; set; }
        public bool ODHuy { get; set; }
        public bool ODPrint { get; set; }
        public bool ODReprint { get; set; }

        public virtual DbCustomer customer { get; set; }//1 đơn hàng chỉ có 1 khách hàng
        public virtual DbVoucher? voucher { get; set; }//1 đơn hàng chỉ có 1 voucher
        public virtual DbPayment payment { get; set; }//1 đơn hàng chỉ có 1 phương thức thanh toán
        public virtual ICollection<DbOrderDetail> orderdetails { get; set; } = new List<DbOrderDetail>();// 1 order có nhiều order chi tiết( vì nhiều size/color...)
        
    }
}
