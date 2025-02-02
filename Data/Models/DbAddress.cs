using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbAddress")]
    public class DbAddress
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdAddress { get; set; }
        public int IdKh { get; set; }
        [StringLength(25)]
        public string TenNguoiNhan { get; set; }
        [StringLength(15)]
        public string Sdt { get; set; }
        [StringLength(500)]
        public string Address { get; set; }
        [StringLength(25)]
        public string City { get; set; }
        [StringLength(25)]
        public string QuanHuyen { get; set; }
        [StringLength(25)]
        public string PhuongXa { get; set; }
        public string? GhiChu { get; set; }
        public bool Idefault { get; set; }
        public virtual DbCustomer? customer { get; set; } //1 địa chỉ cho 1 khách hàng

    }
}
