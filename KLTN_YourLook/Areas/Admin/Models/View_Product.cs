using Data.Models;
using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Product{}
    public class AllProductViewModel //view show all sp
    {
        public int IdSp {  get; set; }
        public string MaSp { get; set; }
        public string AnhSp { get; set; }
        public string TenSp { get; set; }
        public decimal PriceMax { get; set; }
        public decimal PriceMin { get; set; }
        public decimal GiamGia { get; set; }
        public string? TenDm { get; set; } // Tên danh mục
        public string? GroupName { get; set; } // Tên nhóm
        public int? LuotSold { get; set; }
        public bool IActive { get; set; }
        public bool IHot { get; set; }
        public bool ISale { get; set; }
        public bool IFeature { get; set; }
    }
    public class AddProductViewModel //view thêm sản phẩm
    {
        public int IdSp { get; set; }

        [Required(ErrorMessage = "Mã sản phẩm không được để trống")]
        [StringLength(10)]
        public string MaSp { get; set; }
        [Required(ErrorMessage = "Tên sản phẩm không được để trống")]
        [StringLength(100)]
        public string TenSp { get; set; }
        public int IdDm { get; set; }
        public int? NhomId { get; set; }
        public int? SaoDanhGia { get; set; }
        public decimal PriceMax { get; set; }
        public int? GiamGia { get; set; }
        public decimal? PriceMin { get; set; }
        [StringLength(250)]
        public string? AnhSp { get; set; }
        [Required(ErrorMessage = "Mô tả sản phẩm không được để trống")]
        public string MoTaSp { get; set; }
        public bool IActive { get; set; }
        public bool IFavorite { get; set; }
        public bool IFeature { get; set; }
        public bool IHot { get; set; }
        public bool ISale { get; set; }

        public List<DbImg> Imgs { get; set; } = new List<DbImg>();// Danh sách ảnh   
        //public List<DbProductDetail> Details { get; set; } = new List<DbProductDetail>();// Chi tiết sản phẩm (size, màu sắc, số lượng tồn, số lượng thực tế)
        //public string? DetailData { get; set; } 
        //public List<DbSize> SizeList { get; set; } = new List<DbSize>();
        //public List<DbColor> ColorList { get; set; } = new List<DbColor>();
        //public List<int> SelectedSizes { get; set; } = new List<int>();// Danh sách các size được chọn ko lưu csdl
        //public List<int> SelectedColors { get; set; } = new List<int>(); // Danh sách các màu sắc được chọn ko lưu csdl
    }

}
