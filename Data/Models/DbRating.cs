using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbRating")]
    public class DbRating:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int IdKh { get; set; }
        public int IdSp { get; set; }
        public int IdDh { get; set; }
        [StringLength(500)]
        public string ColorSize { get; set; }
        [StringLength(500)]
        public string DanhGia { get; set; }
        public int Rate { get; set; }//số sao đánh giá
        public virtual DbProduct product { get; set; }//1 đánh giá thuộc 1 sp
        public virtual DbCustomer customer { get; set; }//1 đánh giá thuộc 1 khách hàng
    }
}
