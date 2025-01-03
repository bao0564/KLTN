using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbCustomer")]
    public class DbCustomer:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdKh { get; set; }
        [StringLength(20)]
        public string? MaKh { get; set; }
        [Required(ErrorMessage = "Tên không được để trống")]
        [StringLength(25)]
        public string TenKh { get; set; }
        [StringLength(250)]
        public string? Img { get; set; }
        [StringLength(5)]
        public string? GioiTinh { get; set; }
        [StringLength(15)]
        public string? Sdt { get; set; }
        public DateTime? Birth { get; set; } 
        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        public string Email { get; set; }
        [DataType(DataType.Password)]
        [StringLength(25)]
        public string? Passwords { get; set; }
        [Display(Name = "Confirm password")]
        [Compare("Passwords", ErrorMessage = "Mật khẩu không đúng.")]
        [StringLength(25)]
        public string? ConfirmPasswords { get; set; }
        public bool IsExternalAccount { get; set; }

        public virtual ICollection<DbOrder> orders { get; set; } = new List<DbOrder>();//1 user có nhiều đơn hàng
        public virtual ICollection<DbAddress> addresses { get; set; } = new List<DbAddress>(); // 1 user có nhiều địa chỉ
        public virtual ICollection<DbUser_Voucher> user_vouchers { get; set; } = new List<DbUser_Voucher>(); // 1 user có thể dùng nhiều voucher(ko phải cùng 1 mã)
        public virtual ICollection<DbFavoriteProduct> favorites { get; set; } = new List<DbFavoriteProduct>(); // 1 user có nhiều sản phẩm yêu thích
        public virtual ICollection<DbCart> carts { get; set; } = new List<DbCart>(); // 1 user có nhiều sản phẩm trong giỏ hàng

    }
}
