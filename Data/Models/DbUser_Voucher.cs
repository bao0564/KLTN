using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbUser_Voucher")]
    public class DbUser_Voucher
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int IdKh { get; set; }   // Khóa phụ, tham chiếu đến bảng User
        public int IdVoucher { get; set; }   // Khóa phụ, tham chiếu đến bảng Voucher
        public DateTime UsedDate { get; set; }   // Ngày sử dụng voucher

        public virtual DbCustomer customer { get; set; } // ngược lại với quan hệ bên bảng DbCustomer
        public virtual DbVoucher voucher { get; set; } //
    }
}
