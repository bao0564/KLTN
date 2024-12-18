using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbOrderDetail")]
    public class DbOrderDetail:DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdCTDH { get; set; }
        public int IdDh { get; set; }
		[StringLength(500)]
		public string MaDh { get; set; }
        public int IdSp { get; set; }
		[StringLength(10)]
		public string MaSp { get; set; }
		public int IdColor { get; set; }
        public int IdSize { get; set; }
        public int SoLuongSp { get; set; }
        public virtual DbOrder order { get; set; }// 1 chi tiết đơn hàng thuộc 1 đơn hàng
        public virtual DbProduct product { get; set; }
    }
}
