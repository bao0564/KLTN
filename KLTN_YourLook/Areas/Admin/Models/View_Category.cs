﻿namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Category
    {
    }
    public class AllCategoryViewModel
    {
        public int IdDm { get; set; }
        public string MaDm { get; set; }
        public string TenDm { get; set; }
        public string AnhDaiDien { get; set; }
        public int Product { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}