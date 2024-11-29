using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbCategory")]
    public class DbCategory:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdDm { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string MaDm { get; set; }
        [Required(ErrorMessage = "tên danh mục không được trống")]
        [StringLength(10)]
        public string TenDm { get; set; }
        [StringLength(250)]
        public string? AnhDaiDien { get; set; }
                
        public virtual ICollection<DbProduct> products { get; set; } = new List<DbProduct>();//1 danh mục có thể có nhiều sản phẩm

    }
}
