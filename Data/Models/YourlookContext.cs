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
            //
            modelBuilder.Entity<DbProduct>()
                 .HasMany(sp => sp.imgs)
                 .WithOne(img => img.product)
                 .HasForeignKey(img => img.IdSp)
                 .OnDelete(DeleteBehavior.Cascade);

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


        //chuỗi kết nối
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlServer("Data Source=ADMIN\\SQLEXPRESS;Initial Catalog=KLTN;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False");
    }
}
