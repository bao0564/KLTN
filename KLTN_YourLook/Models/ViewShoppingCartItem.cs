using Data.Models;

namespace KLTN_YourLook.Models
{
    //public class ViewShoppingCartItem
    //{
    //    public List<ShoppingCartItem> Items { get; set; } = new List<ShoppingCartItem>();
    //    public void AddToCart(ShoppingCartItem item, int Quantity)
    //    {
    //        var checkprd = Items.FirstOrDefault(x => x.ProductId == item.ProductId);
    //        if (checkprd != null)
    //        {
    //            checkprd.ProductQuantity += Quantity;
    //            checkprd.Total = checkprd.ProductPrice * checkprd.ProductQuantity;
    //        }
    //        else
    //        {
    //            Items.Add(item);
    //        }
    //    }
    //    public void Remove(int id)
    //    {
    //        var checkprd = Items.SingleOrDefault(x => x.ProductId == id);
    //        if (checkprd != null)
    //        {
    //            Items.Remove(checkprd);
    //        }
    //    }
    //    public void Update(int id, int quantity)
    //    {
    //        var checkprd = Items.SingleOrDefault(x => x.ProductId == id);
    //        if (checkprd != null)
    //        {
    //            checkprd.ProductQuantity = quantity;
    //            checkprd.Total = checkprd.ProductPrice * checkprd.ProductQuantity;
    //        }
    //    }
    //    public decimal GetTotal()
    //    {
    //        return Items.Sum(x => x.Total);
    //    }
    //    public int GetQuantity()
    //    {
    //        return Items.Sum(x => x.ProductQuantity);
    //    }
    //    public void ClearAll()
    //    {
    //        Items.Clear();
    //    }
    //}
    //sản phẩm thêm vào giỏ hàng
    public class ShoppingCartItem
    {
        public int IdSp { get; set; }
        public string MaSp { get; set; }
        public string TenSp { get; set; }
        public string AnhSp { get; set; }
        public int ColorId { get; set; }
        public string NameColor { get; set; }
        public int SizeId { get; set; }
        public string NameSize { get; set; }
        public decimal GiaLoai { get; set; }
        public int ProductQuantity { get; set; }
        public decimal Total {  get; set; }
    }
    //Địa chỉ người dùng + Sản phẩm thêm vào giỏ hàng + phương thức thanh toán + voucher
    public class ShoppingCartDetail
    {
        public IEnumerable<ShoppingCartItem> Items { get; set; }
        public List<DbAddress> Address { get; set; }
        public List<DbPayment> Payments { get; set; }
        public List<DbVoucher> Vouchers { get; set; }
    }
    //sản phẩm được chọn thêm vào trang thanh toán
    public class CheckOutItem
    {
        public int ProductId { get; set; }
        public string? CategoryName { get; set; }
        public string? ProductName { get; set; }
        public string? ProductImg { get; set; }
        public int ProductQuantity { get; set; }
        public decimal ProductPrice { get; set; }
        public int ColorId { get; set; }
        public string ColorName { get; set; }
        public int SizeId { get; set; }
        public string SizeName { get; set; }
        public decimal Total { get; set; }
        
    }
    public class ViewCheckOutItem
    {
        public string? TenKh { get; set; }
        public string? Sdt { get; set; }
        public string? City { get; set; }
        public string? District { get; set; }
        public string? Ward { get; set; }
        public string? DiaChi { get; set; }
        public decimal? TongTien { get; set; }
        public int? PaymentId { get; set; }
        public string? Icon { get; set; }
        public string? PayName { get; set; }
        public string? GhiChu { get; set; }
        public decimal? GiamGia { get; set; }    // Giảm giá có thể là số thập phân
        public decimal? Ship { get; set; }        // Phí vận chuyển thường là số thập phân
        public List<CheckOutItem>? CheckOutItems { get; set; }
    }
        //lưu thông tin địa chỉ của khách hàng
    public class OrderInforItem
    {
        public int MaKh {  get; set; }
        public string EmailKh { get; set; }
        public string? TenKh { get; set; }
        public string? Sdt { get; set; }
        public string? City { get; set; }
        public string? District { get; set; }
        public string? Ward { get; set; }
        public string? DiaChi { get; set; }
        public decimal? TongTien { get; set; }
        public int? PaymentId { get; set; }
        public string icon {  get; set; }
        public string payname {  get; set; }
        public decimal? GiamGia { get; set; }    // Giảm giá có thể là số thập phân
        public decimal? Ship { get; set; }        // Phí vận chuyển thường là số thập phân

        public string? GhiChu { get; set; }
    }
    public class CheckoutRequest
    {
        public List<CheckOutItem> selectedProducts { get; set; }
        public OrderInforItem selectInfors { get; set; }
    }
}


