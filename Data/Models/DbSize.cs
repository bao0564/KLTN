using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{

    [Table("DbSize")]
    public class DbSize : DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int SizeId { get; set; }
        [StringLength(5)]
        public string MaSize { get; set; }
        [StringLength(5)]
        public string? NameSize { get; set; }

        //public virtual ICollection<DbOrderDetail> orderdetails { get; set; } = new List<DbOrderDetail>();
        public virtual ICollection<DbProductDetail> productdetails { get; set; } = new List<DbProductDetail>();
        public virtual ICollection<DbCart> carts { get; set; } = new List<DbCart>();//1 size có thể xuất hiện nhiều trong giỏ hàng
    }
}
