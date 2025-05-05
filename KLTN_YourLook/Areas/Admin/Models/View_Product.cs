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
        public int? Quantity { get; set; }
        public bool IActive { get; set; }
        public bool IHot { get; set; }
        public bool ISale { get; set; }
        public bool IFeature { get; set; }
    }
    public class AddProductViewModel:DbAbstract //view thêm sản phẩm
    {
        public int IdSp { get; set; }
        public string? MaSp { get; set; }
        public string TenSp { get; set; }
        public int IdDm { get; set; }
        public int NhomId { get; set; }
        public int Classify { get; set; }
        public decimal PriceMax { get; set; }
        public int? GiamGia { get; set; }
        public decimal? PriceMin { get; set; }
        public string? AnhSp { get; set; }
        public string MoTaSp { get; set; }
        public bool IActive { get; set; }
        public bool IFeature { get; set; }
        public bool IFavorite { get; set; }
        public bool IHot { get; set; }
        public bool ISale { get; set; }

        public List<DbImg> Imgs { get; set; } = new List<DbImg>();// Danh sách ảnh   
        public List<View_Productdetail> Details { get; set; } = new List<View_Productdetail>();// Chi tiết sản phẩm (size, màu sắc, số lượng tồn, số lượng thực tế)
        public List<DbSize> SizeList { get; set; } = new List<DbSize>();
        public List<DbColor> ColorList { get; set; } = new List<DbColor>();
        public List<int>? SelectedSize { get; set; }=new List<int>();
        public List<int>? SelectedColor { get; set; } = new List<int>();
       }
    public class View_Productdetail
    {
        public int IdSp { get; set; }
        public int SizeId { get; set; }
        public string NameSize { get; set; }
        public int ColorId { get; set; }
        public string NameColor { get; set; }
        public decimal? GiaLoai { get; set; }
        public int Quantity { get; set; }

    }
    public class ProductDetailViewModel //view hiển thị thông tin chi tiết của sp
    {
        public DbProduct Product { get; set; }
        public List<DbImg> Imgs { get; set; }
        public List<View_SP_ProductDetail> Details { get; set; }
    }
    public class View_SP_ProductDetail
    {
        public string NameColor { get; set; }
        public string MaHex { get; set; }
        public string NameSize { get; set; }
        public decimal GiaLoai { get; set; }
        public int Quantity { get; set; }
        public int SoLuongBan { get; set; }

    }
}
