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

        public virtual ICollection<DbProductDetail> orderdetails{ get; set; } = new List<DbProductDetail>();
    }
}
