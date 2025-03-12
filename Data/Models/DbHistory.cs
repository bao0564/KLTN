using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbHistory")]
    public class DbHistory:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [StringLength(100)]
        public string TableName { get; set; }
        public int TableId { get; set; } //id trong bảng
        [StringLength(1000)]
        public string OldValue { get; set; }
        [StringLength(1000)]
        public string NewValue { get; set; }
    }
}
