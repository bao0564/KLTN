using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbAds")]
    public class DbAds
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required(ErrorMessage = "không được trống")]
        [StringLength(10)]
        public string MaAds { get; set; }
        [StringLength(250)]
        public string? Img { get; set; }
        [StringLength(10)]
        public string? Place { get; set; }
        public bool IsActive { get; set; }
    }
}
