﻿using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Home
    {
    }
    public class View_Admin_Register
    {
        public string EmailDn { get; set; }
        public string NameDn { get; set; }
        public string PasswordDn { get; set; }
        public string ChucVu { get; set; }
        public string Quyen { get; set; }
    }
    //view modell doanh thu raw
    public class View_Revenue_Raw
    {
        public int Thang { get; set; }
        public int Nam { get; set; }
        public int Thangtrc { get; set; }
        public int NamTrc { get; set; }
        public int CoutDH { get; set; }
        public decimal DoanhThu { get; set; }
        public decimal PrevDoanhThu { get; set; }
        public int DHTranpost { get; set; }
        public int DHComplete { get; set; }
        public int DHHuy { get; set; }
        public string DoanhThuTongHop { get; set; }
    }
    
    //view modell doanh thu
    public class View_Revenue
    {
        public int Thang { get; set; }
        public int Nam { get; set; }
        public int Thangtrc { get; set; }
        public int NamTrc { get; set; }
        public int CoutDH { get; set; }
        public decimal DoanhThu { get; set; }
        public decimal PrevDoanhThu { get; set; }
        public int DHTranpost { get; set; }
        public int DHComplete { get; set; }
        public int DHHuy { get; set; }
        // Doanh thu từng ngày/tháng (để vẽ biểu đồ đường)
        public List<DoanhThuChartItem> DoanhThuThangTheoNam { get; set; }
        public List<SanPhamBanChayItem> TopSanPhamBanChay { get; set; }
        //public List<SanPhamTonKhoItem> TopSanPhamTonKho { get; set; }
    }

    public class DoanhThuChartItem
    {
        public int Thang { get; set; }  
        public decimal DoanhThu { get; set; }
    }

    public class SanPhamBanChayItem
    {
        public string TenSp { get; set; }
        public int SoLuongBan { get; set; }
    }

    public class SanPhamTonKhoItem
    {
        public string TenSp { get; set; }
        public int SoLuongTon { get; set; }
    }
}
