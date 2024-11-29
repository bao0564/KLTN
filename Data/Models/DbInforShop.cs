using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbInforShop")]
    public class DbInforShop:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [StringLength(15)]
        public string? Sdt { get; set; }
        [StringLength(25)]
        public string? Email { get; set; }
        [StringLength(250)]
        public string? Addres { get; set; }
    }
}
