using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbColor")]
    public class DbColor:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ColorId { get; set; }
        [StringLength(10)]
        public string? MaColor { get; set; }
        [StringLength(50)]
        public string NameColor { get; set; }
        [StringLength(20)]
        public string? MaHex { get; set; }
        [StringLength(250)]
        public string? Img { get; set; }

        //public virtual ICollection<DbOrderDetail> orderdetails { get; set; } = new List<DbOrderDetail>();
        public virtual ICollection<DbProductDetail> productdetails { get; set; } = new List<DbProductDetail>();
        public virtual ICollection<DbCart> carts { get; set; } = new List<DbCart>();//1 cl có thể xuất hiện nhiều trong giỏ hàng
    }
}
