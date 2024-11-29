using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbOrderDetail")]
    public class DbOrderDetail
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdCTDH { get; set; }
        [StringLength(10)]
        public string MaCTDH { get; set; }
        public int IdDh { get; set; }
        //public int IdSp { get; set; }
        //public string MaSp { get; set; }
        //public string? TenSp { get; set; }
        [StringLength(250)]
        public string? AnhSp { get; set; }
        //public int IdColor { get; set; }
        //public string ColorName { get; set; }
        //public int IdSize { get; set; }
        //public string SizeName { get; set; }
        public int SoLuongSp { get; set; }
        public decimal Price { get; set; }
        [ForeignKey("IdProductDetail")]
        public int IdProductDetail { get; set; } // Khóa ngoại đến DbProductDetail thay cho idsp,idcolor,idsize
        
        public virtual DbProductDetail ProductDetail { get; set; }//1 chi tiết đơn hàng có 1 chi tiết sp (thay vì liên kết tới các bảng color,size và sp)
        public virtual DbOrder order { get; set; }// 1 chi tiết đơn hàng thuộc 1 đơn hàng
    }
}
