using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbGroup")]
    public class DbGroup:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdNhom { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(50)]
        public string MaNhom { get; set; }
        [StringLength(250)]
        public string AnhDaiDien { get; set; }
        [StringLength(50)]
        public string GroupName { get; set; }

        public virtual ICollection<DbProduct> products { get; set; } = new List<DbProduct>();//1 nhóm có nhiều sản phẩm
    }
}
