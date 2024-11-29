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
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string MaColor { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string NameColor { get; set; }
        [StringLength(25)]
        public string? Img { get; set; }

        public virtual ICollection<DbOrderDetail> orderdetails { get; set; } = new List<DbOrderDetail>();
    }
}
