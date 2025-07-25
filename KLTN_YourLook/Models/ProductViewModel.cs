﻿using Data.Models;

namespace KLTN_YourLook.Models
{
	public class ProductViewModel
	{
	}
	public class ViewAllDetailRaw
	{
		public int IdSp { get; set; }
		public string MaSp { get; set; }
		public string TenSp { get; set; }
		public string? AnhSp { get; set; }
		public decimal PriceMax { get; set; }
		public int? GiamGia { get; set; }
		public decimal? PriceMin { get; set; }
		public bool IFavorite { get; set; }
		public int? LuotXem { get; set; }
		public string Sizes { get; set; }
		public string Colors { get; set; }
        public int? soluongban { get; set; } // trong 3 tháng
    }
	public class ViewAllDetail
	{
		public int IdSp { get; set; }
		public string MaSp { get; set; }
		public string TenSp { get; set; }
		public string? AnhSp { get; set; }
		public decimal PriceMax { get; set; }
		public int? GiamGia { get; set; }
		public decimal? PriceMin { get; set; }
		public bool IFavorite { get; set; }
		public int? LuotXem { get; set; }
		public List<ViewSize> Sizes { get; set; }
		public List<ViewColor> Colors { get; set; }
        public int? soluongban { get; set; } // trong 3 tháng
    }
	public class ViewColor
	{
		public int ColorId { get; set; }
		public string NameColor { get; set; }
		public string MaColor { get; set; }
		public string MaHex { get; set; }
	}
	public class ViewSize
	{
		public int SizeId { get; set; }
		public string NameSize { get; set; }
	}
	public class ViewSugget
    {        public int IdSp { get; set; }
        public string TenSp { get; set; }
        public string AnhSp { get; set; }
    }

}