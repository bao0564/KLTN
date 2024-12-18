using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{

    [Table("DbPayment")]
    public class DbPayment : DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PaymentId { get; set; }
        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        public string? PaymentName { get; set; }
        [StringLength(250)]
        public string? Icon { get; set; }

        public virtual ICollection<DbOrder> orders { get; set; } = new List<DbOrder>();//1 hình thức thanh toán có thể ở nhiều đơn hàng
    }
}
