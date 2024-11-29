using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbImg")]
    public class DbImg
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int IdSp { get; set; }
        [StringLength(250)]
        public string? Img { get; set; }
        public bool IsDefault { get; set; }
        [StringLength(10)]
        public string? Place { get; set; }

        public virtual DbProduct? product { get; set; }// 1 ảnh thuộc 1 sp
    }
}
