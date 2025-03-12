using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System.Data.Common;

namespace Data.Models
{
    public class YourlookContext:DbContext
    {
        public YourlookContext() { }
        public YourlookContext(DbContextOptions<YourlookContext> options) : base(options) { }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //khóa ngoại (Cascade/Restrict)
            base.OnModelCreating(modelBuilder);
            // 1 sp có nhiều ảnh chi tiết và ngc lại //nếu sp bị xóa thì các ảnh thuộc sp đó cũng sẽ bị xóa
            modelBuilder.Entity<DbProduct>().HasMany(sp => sp.imgs).WithOne(img => img.product).HasForeignKey(img => img.IdSp)
                 .OnDelete(DeleteBehavior.Cascade);
            // 1 sp có thể có nhiều trong DbCart(vì idkh khác nhau) và ngc lại //nếu sp bị xóa thì toàn bộ sp đó trong dbcart sẽ bị xóa
            modelBuilder.Entity<DbProduct>().HasMany(p => p.carts).WithOne(cart => cart.product).HasForeignKey(cart => cart.IdSp)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 sp có 1 danh mục và ngc lại 
            modelBuilder.Entity<DbProduct>().HasOne(p=>p.category).WithMany(c=>c.products).HasForeignKey(p=>p.IdDm)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 sp có 1 nhóm và ngc lại 
            modelBuilder.Entity<DbProduct>().HasOne(p => p.group).WithMany(c => c.products).HasForeignKey(p => p.NhomId)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 sp có thể có nhiều trong bảng sản phẩm yêu thích và ngược lại// nếu sp bị xóa thì sp trong bảng yêu thichs cũng sẽ bị xóa
            modelBuilder.Entity<DbProduct>().HasMany(p=>p.favoriteproducts).WithOne(fvrp=>fvrp.product).HasForeignKey(p=>p.IdSp)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 sp có thể có nhiều Đánh giá và ngược lại// nếu sp bị xóa thì đánh giá của sp đó trong bảng đánh giá cũng sẽ bị xóa
            modelBuilder.Entity<DbProduct>().HasMany(p => p.ratings).WithOne(rt => rt.product).HasForeignKey(p => p.IdSp)
                .OnDelete(DeleteBehavior.Cascade);

            // 1 ctsp có 1 sp và 1 sp có thể có nhiều ctsp(cùng sp nhưng khác color,size) //nếu sp bị xóa thì ctsp của sp đó sẽ bị xóa
            modelBuilder.Entity<DbProductDetail>().HasOne(ctsp => ctsp.product).WithMany(sp => sp.detailproducts).HasForeignKey(ctsp => ctsp.IdSp)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 ctsp có 1 color và 1 color có thể xuất hiện nhiều trong ctsp(cùng color khác sp) // nếu color bị xóa thì ctsp có color đó sẽ bị xóa
            modelBuilder.Entity<DbProductDetail>().HasOne(ctsp => ctsp.color).WithMany(cl => cl.productdetails).HasForeignKey(ctsp => ctsp.ColorId)
                .OnDelete(DeleteBehavior.Cascade);//Restrict
            // 1 ctsp có 1 size và 1 size có thể xuất hiện nhiều trong ctsp(cùng size khác sp) // nếu size bị xóa thì ctsp có size đó sẽ bị xóa
            modelBuilder.Entity<DbProductDetail>().HasOne(pd => pd.size).WithMany(sz => sz.productdetails).HasForeignKey(pd => pd.SizeId)
                .OnDelete(DeleteBehavior.Cascade);

            // 1 khách hàng có thể xuất hiện nhiều trong DbCart và ngc lại(khách hàng có nhiều sp trong giỏ) //xóa kh thì các sp của kh trong giỏ cũng xóa
            modelBuilder.Entity<DbCustomer>().HasMany(cus => cus.carts).WithOne(cart => cart.customer).HasForeignKey(cart => cart.IdKh)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 khách hàng có 1 địa chỉ và ngược lại //xóa khách hàng thì địa chỉ của khách hàng sẽ bị xóa
            modelBuilder.Entity<DbCustomer>().HasMany(cus => cus.addresses).WithOne(adr => adr.customer).HasForeignKey(adr => adr.IdKh)
                .OnDelete(DeleteBehavior.Cascade);
            //1 khách hàng có thể có nhiều sp yêu thích và ngc lại //tài khoản khách hàng bị xóa thì sp yêu thích trong tk đó cũng sẽ bị xóa
            modelBuilder.Entity<DbCustomer>().HasMany(cus=>cus.favorites).WithOne(fvrp=>fvrp.customer).HasForeignKey(cus=>cus.IdKh)
                .OnDelete(DeleteBehavior.Cascade);
            //1 khách hàng có thể có nhiều đánh giá và ngc lại //khách hàng bị xóa thì các đánh giá thuộc kh đó cũng bị xóa
            modelBuilder.Entity<DbCustomer>().HasMany(cus => cus.rates).WithOne(rate => rate.customer).HasForeignKey(cus => cus.IdKh)
                .OnDelete(DeleteBehavior.Cascade);

            // 1 sp trong giỏ chỉ có 1 color và 1 color có thể xuất hiện nhiều trong giỏ(vì khác sp) //nếu màu bị xóa thì sp có color trong giỏ sẽ bị xóa
            modelBuilder.Entity<DbCart>().HasOne(cr => cr.color).WithMany(cl => cl.carts).HasForeignKey(cr => cr.ColorId)
                .OnDelete(DeleteBehavior.Cascade);
            // 1 sp trong giỏ chỉ có 1 size và 1 color có thể xuất hiện nhiều trong giỏ(vì khác sp)// nếu size bị xóa thì sp có size trong giỏ sẽ bị xóa
            modelBuilder.Entity<DbCart>().HasOne(cr => cr.size).WithMany(sz => sz.carts).HasForeignKey(cr => cr.SizeId)
                .OnDelete(DeleteBehavior.Cascade);

            //1 đơn hàng dùng 1 loại thanh toán ,và 1 loại thanh toán có thể nhiều đơn hàng sử dụng nếu loại thanh toán bị xóa thì đơn hàng không bị xóa
            modelBuilder.Entity<DbOrder>().HasOne(od => od.payment).WithMany(pm => pm.orders).HasForeignKey(od => od.PaymentId)
                .OnDelete(DeleteBehavior.Restrict);
            //1 đơn hàng dùng 1 voucher,và 1 vourcher có thể dùng cho nhiều đơn hàng (nhưng khác idkh) nếu voucher bị xóa thì đươn hàng ko xóa
            modelBuilder.Entity<DbOrder>().HasOne(od=>od.voucher).WithMany(vc=>vc.orders).HasForeignKey(od=> od.IdVoucher)
                .OnDelete(DeleteBehavior.Restrict);
            //1 đơn hàng tạo bởi 1 người dùng,và 1 người dùng có thể tạo nhiều đơn hàng ,nếu người dùng xóa thì đơn hàng ko xóa
            modelBuilder.Entity<DbOrder>().HasOne(od=>od.customer).WithMany(cus => cus.orders).HasForeignKey(od => od.IdKh)
                .OnDelete(DeleteBehavior.Restrict);
            //1 đơn hàng có nhiều dhct,và ngc lại dhct thược 1 đơn hàng // không cho phép xóa đơn hàng /chi tiết đơn hàng (nếu xóa thì cascade)
            modelBuilder.Entity<DbOrder>().HasMany(od => od.orderdetails).WithOne(odd => odd.order).HasForeignKey(od => od.IdDh)
                .OnDelete(DeleteBehavior.Cascade);

            //1 ctdh chỉ có 1 sản phẩm ,1 sp có thể xuất hiện nhiều trong DbOrderDetail, sp bị xóa thì ctdh không bị xóa
            modelBuilder.Entity<DbOrderDetail>().HasOne(odd=>odd.product).WithMany(p=>p.orderdetails).HasForeignKey(odd=>odd.IdSp)
                .OnDelete(DeleteBehavior.Restrict);
        }
        public virtual DbSet<DbAddress> DbAddresss { get; set; } //bảng địa chỉ
        public virtual DbSet<DbAds> DbAdss { get; set; } //bảng ads
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
        public virtual DbSet<DbRating> DbRatings { get; set; }// bảng đánh giá nhận sét sp 
        public virtual DbSet<DbNotification> DbNotifications { get; set; }// bảng thông báo 
        public virtual DbSet<DbHistory> DbHistories { get; set; }//bảng lịch sử thay đổi


        //chuỗi kết nối
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlServer("Data Source=DESKTOP-DB0RLVI;Initial Catalog=KLTN;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False");

        ////chuỗi kết nối
        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //    => optionsBuilder.UseSqlServer("Data Source=SQL1001.site4now.net;Initial Catalog=db_ab14b1_db;User Id=db_ab14b1_db_admin;Password=Thanhmi@123");
    }
}
