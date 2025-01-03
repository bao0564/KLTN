using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    [Table("DbFavoriteProduct")]
    public class DbFavoriteProduct:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        [ForeignKey("DbProduct")] //ko cần cũng đc
        public int IdSp { get; set; }
        [ForeignKey("DbCustomer")]// ko cần cũng ok
        public int IdKh { get; set; }

        public virtual DbProduct? product { get; set; } // ngược lại với quan hệ ở bảng DbProduct
        public virtual DbCustomer? customer { get; set; } // ngược lại với quan hệ ở bảng DbCustomer
    }
}
