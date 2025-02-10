using Data.Models;

namespace KLTN_YourLook.Models
{
    public class ViewModel_User
    {
    }
    public class Product_Rating_Raw //hiển thị các sp cho người dùng đánh giá raw
    {
        public int IdSp { get; set; }
        public int IdDh { get; set; }
        public string AnhSp { get; set; }
        public string TenSp { get; set; }
        public string ColorSizes { get; set; }
        public string DanhGia { get; set; }
        public int Rate { get; set; }
    }
    public class Product_Rating //hiển thị các sp cho người dùng đánh giá 
    {
        public int IdSp { get; set; }
        public int IdDh { get; set; }
        public string AnhSp { get; set;}
        public string TenSp { get; set;}
        public List<Product_Rating_SizeColor> ColorSize { get; set;}
        public string DanhGia { get; set; }
        public int Rate { get; set; }
    }
    public class Product_Rating_SizeColor //các size+color của cùng 1 sp 
    {
        public string ColorSize { get; set; }
    }
    public class RateRequest //chứa các thông tin đánh giá từ frombody
    {
        public int IdDh { get; set; }
        public List<Product_Rating_Raw> Reviews { get; set; }
    }
}
