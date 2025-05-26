using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Drawing;

namespace Data.Models
{
    [Table("DbProductDetail")]
    public class DbProductDetail
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdCTSP { get; set; }
        [StringLength(50)]
        public string MaCTSP { get; set; }
        public int IdSp { get; set; }
        public int SizeId { get; set; }
        [StringLength(50)]
        public string NameSize { get; set; }
        public int ColorId { get; set; }
        [StringLength(50)]
        public string NameColor { get; set; }
        public int? SoLuongBan { get; set; }
        public decimal? GiaLoai {  get; set; }
        public int Quantity { get; set; }

        public virtual DbProduct product { get; set; }// 1 chi tiết sp ứng với 1 sp
        public virtual DbSize size { get; set; }//1 chi tiết sp ứng với 1 màu
        public virtual DbColor color { get; set; }//1 chi tiết sp ứng với 1 size
    }
}
