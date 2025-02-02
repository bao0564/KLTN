using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbNotification")]
    public class DbNotification
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [StringLength(25)]
        public string? Title { get; set; }
        [StringLength(250)]
        public string? Img { get; set; }
        public string Message { get; set; }
        public bool IsRead { get; set; }
        public DateTime CreateDate { get; set; }
    }
}
