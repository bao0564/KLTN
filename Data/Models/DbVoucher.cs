using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbVoucher")]
    public class DbVoucher : DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdVoucher { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(25)]
        public string MaVoucher { get; set; }
        [Required(ErrorMessage = "Thêm ảnh")]
        [StringLength(250)]
        public string IconVoucher { get; set; }
        [Required(ErrorMessage = "giá trị voucher")]
        public int valueVoucher { get; set; }
        public int? valueMax { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(500)]
        public string MotaVoucher { get; set; }

        public virtual ICollection<DbOrder> orders { get; set; } = new List<DbOrder>();//1 voucher có thể áp dụng nhiều đơn hàng
        public virtual ICollection<DbUser_Voucher> user_voucher { get; set; } = new List<DbUser_Voucher>();//1 voucher có thể áp dụng nhiều người dùng/voucher(DbUserVoucher)
    }
}
