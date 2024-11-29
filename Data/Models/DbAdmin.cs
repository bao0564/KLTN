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
        [Required(ErrorMessage = "không được trống")]
        [StringLength(5)]
        public string MaAdmin { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(15)]
        public string EmailDn { get; set; }
        [StringLength(25)]
        public string? NameDn { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string PasswordDn { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string ChucVu { get; set; }
        [StringLength(10)]
        public string? Quyen { get; set; }
        public bool IsExternalAccount { get; set; }
    }
}
