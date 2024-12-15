using Microsoft.EntityFrameworkCore;
using System.Data.Common;

namespace Data.Models
{
    public class YourlookContext:DbContext
    {
        public YourlookContext() { }
        public YourlookContext(DbContextOptions<YourlookContext> options) : base(options) { }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Cấu hình quan hệ giữa  DbProduct / DbImg
            modelBuilder.Entity<DbProduct>()
                 .HasMany(sp => sp.imgs)//1sp có nhiều ảnh
                 .WithOne(img => img.product) //Nếu mối quan hệ là một-nhiều thì cấu hình lại
                 .HasForeignKey(img => img.IdSp)
                 .OnDelete(DeleteBehavior.Cascade);
            // Cấu hình quan hệ giữa  DbProductdetail /DbProduct
            modelBuilder.Entity<DbProductDetail>()
                .HasOne(ctsp => ctsp.product)//1 ctsp có 1 sp
                .WithMany(sp=>sp.detailproducts) //1sp có nhiều ctsp
                .HasForeignKey(ctsp => ctsp.IdSp)
                .OnDelete(DeleteBehavior.Cascade);
            // Cấu hình quan hệ giữa DbProductDetail và DbColor
            modelBuilder.Entity<DbProductDetail>()
                .HasOne(ctsp => ctsp.color)//1 ctsp có 1 color
                .WithMany(cl=>cl.productdetails)//1 color có nhiều ctsp
                .HasForeignKey(ctsp => ctsp.ColorId)
                .OnDelete(DeleteBehavior.Cascade);//Restrict
            // Cấu hình quan hệ giữa DbProductDetail / DbSize
            modelBuilder.Entity<DbProductDetail>()
                .HasOne(pd => pd.size)//1 ctsp có 1 size
                .WithMany(sz=>sz.productdetails)  //1 size có nhiều ctsp
                .HasForeignKey(pd => pd.SizeId)
                .OnDelete(DeleteBehavior.Cascade);//Restrict:xóa size thì ctsp ko bị xóa
            // Cấu hình quan hệ giữa DbProduct/ DbCart 
            modelBuilder.Entity<DbProduct>()
                .HasMany(p => p.carts)//1 sp có thể có trong nhiều giỏ hàng với nhiều khách hàng
                .WithOne(cart => cart.product)
                .HasForeignKey(cart => cart.IdSp)
                .OnDelete(DeleteBehavior.Cascade);
            // Cấu hình quan hệ giữa DbCustomer/ DbCart 
            modelBuilder.Entity<DbCustomer>()
                .HasMany(cus => cus.carts)//1 kachs hàng có thể có trong nhiều trong cart vì có nhiều sp trong giỏ hàng
                .WithOne(cart => cart.customer)
                .HasForeignKey(cart => cart.IdKh)
                .OnDelete(DeleteBehavior.Cascade);
            // Cấu hình quan hệ giữa Dbcart và DbColor
            modelBuilder.Entity<DbCart>()
                .HasOne(ctsp => ctsp.color)
                .WithMany(cl => cl.carts)
                .HasForeignKey(ctsp => ctsp.ColorId)
                .OnDelete(DeleteBehavior.Cascade);//Restrict
            // Cấu hình quan hệ giữa DbCart / DbSize
            modelBuilder.Entity<DbCart>()
                .HasOne(pd => pd.size)
                .WithMany(sz => sz.carts)
                .HasForeignKey(pd => pd.SizeId)
                .OnDelete(DeleteBehavior.Cascade);//Restrict:xóa size thì ctsp ko bị xóa
        }
        //DbSet
        public virtual DbSet<DbAds> DbAdss { get; set; } //bảng hình ảnh quảng cáo
        public virtual DbSet<DbAddress> DbAddresss { get; set; } //bảng địa chỉ
        public virtual DbSet<DbAdmin> DbAdmins { get; set; } // bảng admin
        public virtual DbSet<DbOrderDetail> DbOrderDetails { get; set; } //bảng chi tiết đơn đặt hàng
        public virtual DbSet<DbProductDetail> DbProductDetails { get; set; } //bảng chi tiết sản phẩm
        public virtual DbSet<DbColor> DbColors { get; set; }// bảng màu sắc
        public virtual DbSet<DbCategory> DbCategorys { get; set; }//bảng danh mục 
        public virtual DbSet<DbOrder> DbOrders { get; set; }//bảng đơn đặt hàng
        public virtual DbSet<DbGroup> DbGroups { get; set; }// bảng nhóm
        public virtual DbSet<DbImg> DbImgs { get; set; }// bảng chứa ảnh sản phẩm
        public virtual DbSet<DbInforShop> DbInforShops { get; set; }//bảng thông tin cửa hàng
        public virtual DbSet<DbCustomer> DbCustomers { get; set; } //bảng khách hàng
        public virtual DbSet<DbProduct> DbProducts { get; set; }//bảng sản phẩm
        public virtual DbSet<DbSize> DbSizes { get; set; }//bảng size
        //public virtual DbSet<DbTransaction> DbTransactions { get; set; }//bảng thông tin giao dịch
        public virtual DbSet<DbPayment> DbPayments { get; set; }//bảng phương thức thanh toán
        public virtual DbSet<DbVoucher> DbVouchers { get; set; }//bảng mã giảm giá
        public virtual DbSet<DbFavoriteProduct> DbFavoriteProducts { get; set; }// bảng sản phẩm yêu thích
        public virtual DbSet<DbCart> DbCarts { get; set; }// bảng sản phẩm Giỏ hàng 


        //chuỗi kết nối
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlServer("Data Source=ADMIN\\SQLEXPRESS;Initial Catalog=KLTN;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False");
    }
}
