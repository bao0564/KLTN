using Data.Models;
using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Models
{
	public class ProductDetailViewModelRaw
	{
		public int IdSp { get; set; }
		public decimal Rate { get; set; }
		public string MaSp { get; set; }
		public string TenDm { get; set; }
		public string TenSp { get; set; }
		public int? SaoDanhGia { get; set; }
		public string AnhSp { get; set; }
		public decimal PriceMax { get; set; }
		public int GiamGia { get; set; }
		public decimal PriceMin { get; set; }
		public int? LuotXem { get; set; }
		public int? LuotSold { get; set; }
		public string MotaSp { get; set; }
		public bool IsFavorite { get; set; }

		public string ImgDetail { get; set; }
		public string Detail { get; set; }
	}
	public class ViewProductDetail
	{
		public int IdSp { get; set; }
        public decimal Rate { get; set; }
        public string MaSp { get; set; }
		public string TenDm { get; set; }
		public string TenSp { get; set; }
		public int? SaoDanhGia { get; set; }
		public string AnhSp { get; set; }
		public decimal PriceMax { get; set; }
		public int GiamGia { get; set; }
		public decimal PriceMin { get; set; }
		public int? LuotXem { get; set; }
		public int? LuotSold { get; set; }
		public string MotaSp { get; set; }
		public bool IsFavorite { get; set; }

		public List<ViewDetailImg>? ImgDetail { get; set; }
		public List<ViewDetail> Detail { get; set; }
	}
	public class ViewDetailImg
	{
		public string? Img {  get; set; }
	}
	public class ViewDetail
	{
		public int SizeId { get; set; }
		public string NameSize { get; set; }
		public int ColorId { get; set; }
		public string NameColor { get; set; }
		public string MaColor { get; set; }
		public string MaHex { get; set; }
		public decimal GiaLoai { get; set; }
		public int Quantity { get; set; }
	}
	public class ViewRattingProduct //view hiển thị các đánh giá của khách hàng
    {
        public string Img { get; set; }
        public string TenKh { get; set; }
        public DateTime CreateDate { get; set; }
        public string DanhGia { get; set; }
        public int Rate { get; set; }
        public string ColorSize { get; set; }
    }
}
