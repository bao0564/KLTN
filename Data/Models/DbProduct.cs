using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
    [Table("DbProduct")]
    public class DbProduct : DbAbstract
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdSp { get; set; }
        [StringLength(10)]
        public string? MaSp { get; set; }
        public int IdDm { get; set; }

        [Required(ErrorMessage = "Tên sản phẩm không được để trống")]
        [StringLength(250)]
        public string TenSp { get; set; }
        public int? SaoDanhGia { get; set; }
        public int NhomId { get; set; }

        [StringLength(250)]
        public string? AnhSp { get; set; }

        [Required]
        public decimal PriceMax { get; set; }
        public int? GiamGia { get; set; }
        public decimal? PriceMin { get; set; }

        public int? LuotXem { get; set; }
        public int? LuotSold { get; set; }

        [Required(ErrorMessage = "Mô tả sản phẩm không được để trống")]
        public string MotaSp { get; set; }

        public bool IActive { get; set; }
        public bool IFavorite { get; set; }
        public bool IFeature { get; set; }
        public bool IHot { get; set; }
        public bool ISale { get; set; }

        public virtual DbCategory? category { get; set; }//1 sp có 1 danh mục
        public virtual DbGroup? group { get; set; }//1 sp có 1 nhóm
        public virtual ICollection<DbImg> imgs { get; set; } = new List<DbImg>();//1 sp có nhiều ảnh
        public virtual ICollection<DbFavoriteProduct> favoriteproducts { get; set; } = new List<DbFavoriteProduct>();// 1 sp có thể xuất hiện nhiều trong bảng sp yêu thích
        public virtual ICollection<DbProductDetail> detailproducts { get; set; } = new List<DbProductDetail>();// 1 sp có thể xuất hiện nhiều trong bảng chi tiết sản phẩm}
        public virtual ICollection<DbCart> carts { get; set; } = new List<DbCart>();//1 sp có thể xuất hiện nhiều trong giỏ hàng
        public virtual ICollection<DbOrderDetail> orderdetails { get; set; } = new List<DbOrderDetail>();//1 sp có thể xuất hiện nhiều trong ctdh
    }
}
