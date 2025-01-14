using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbAdmin")]
    public class DbAdmin
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [StringLength(15)]
        public string? MaAdmin { get; set; }
        [StringLength(50)]
        public string EmailDn { get; set; }
        [StringLength(25)]
        public string NameDn { get; set; }
        [StringLength(20)]
        public string PasswordDn { get; set; }
        [StringLength(20)]
        public string ChucVu { get; set; }
        [StringLength(20)]
        public string Quyen { get; set; }
    }
}
