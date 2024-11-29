using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class AddAllTable_ : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DbAdmin",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaAdmin = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    EmailDn = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    NameDn = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    PasswordDn = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    ChucVu = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Quyen = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    IsExternalAccount = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbAdmin", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DbAds",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaAds = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Url = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Img = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbAds", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DbCategory",
                columns: table => new
                {
                    IdDm = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaDm = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    TenDm = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    AnhDaiDien = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbCategory", x => x.IdDm);
                });

            migrationBuilder.CreateTable(
                name: "DbColor",
                columns: table => new
                {
                    ColorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaColor = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    NameColor = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Img = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbColor", x => x.ColorId);
                });

            migrationBuilder.CreateTable(
                name: "DbCustomer",
                columns: table => new
                {
                    IdKh = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaKh = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    TenKh = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    Img = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    GioiTinh = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    Sdt = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Passwords = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ConfirmPasswords = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    IsExternalAccount = table.Column<bool>(type: "bit", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbCustomer", x => x.IdKh);
                });

            migrationBuilder.CreateTable(
                name: "DbGroup",
                columns: table => new
                {
                    IdNhom = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaNhom = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    GroupName = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbGroup", x => x.IdNhom);
                });

            migrationBuilder.CreateTable(
                name: "DbInforShop",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Sdt = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    Addres = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbInforShop", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DbPayment",
                columns: table => new
                {
                    PaymentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PaymentName = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Icon = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbPayment", x => x.PaymentId);
                });

            migrationBuilder.CreateTable(
                name: "DbSize",
                columns: table => new
                {
                    SizeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaSize = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    NameSize = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbSize", x => x.SizeId);
                });

            migrationBuilder.CreateTable(
                name: "DbVoucher",
                columns: table => new
                {
                    IdVoucher = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaVoucher = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    IconVoucher = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    valueVoucher = table.Column<int>(type: "int", nullable: false),
                    valueMax = table.Column<int>(type: "int", nullable: true),
                    MotaVoucher = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbVoucher", x => x.IdVoucher);
                });

            migrationBuilder.CreateTable(
                name: "DbAddress",
                columns: table => new
                {
                    IdAddress = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    TenNguoiNhan = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    Sdt = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    Address = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    City = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    QuanHuyen = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    PhuongXa = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Idefault = table.Column<bool>(type: "bit", nullable: false),
                    customerIdKh = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbAddress", x => x.IdAddress);
                    table.ForeignKey(
                        name: "FK_DbAddress_DbCustomer_customerIdKh",
                        column: x => x.customerIdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh");
                });

            migrationBuilder.CreateTable(
                name: "DbProduct",
                columns: table => new
                {
                    IdSp = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaSp = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    MaDm = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    TenSp = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    SaoDanhGia = table.Column<int>(type: "int", nullable: true),
                    NhomId = table.Column<int>(type: "int", nullable: false),
                    AnhSp = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    PriceMax = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    GiamGia = table.Column<int>(type: "int", nullable: true),
                    PriceMin = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    LuotXem = table.Column<int>(type: "int", nullable: false),
                    LuotSold = table.Column<int>(type: "int", nullable: false),
                    MotaSp = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IActive = table.Column<bool>(type: "bit", nullable: false),
                    IFavorite = table.Column<bool>(type: "bit", nullable: false),
                    IFeature = table.Column<bool>(type: "bit", nullable: false),
                    IHot = table.Column<bool>(type: "bit", nullable: false),
                    ISale = table.Column<bool>(type: "bit", nullable: false),
                    categoryIdDm = table.Column<int>(type: "int", nullable: false),
                    groupIdNhom = table.Column<int>(type: "int", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbProduct", x => x.IdSp);
                    table.ForeignKey(
                        name: "FK_DbProduct_DbCategory_categoryIdDm",
                        column: x => x.categoryIdDm,
                        principalTable: "DbCategory",
                        principalColumn: "IdDm",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbProduct_DbGroup_groupIdNhom",
                        column: x => x.groupIdNhom,
                        principalTable: "DbGroup",
                        principalColumn: "IdNhom",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbOrder",
                columns: table => new
                {
                    IdDh = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaDh = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    EmailKh = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    Sdt = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    City = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    District = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Ward = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    DiaChi = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    TongTien = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TongTienThanhToan = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    soluong = table.Column<int>(type: "int", nullable: false),
                    PaymentId = table.Column<int>(type: "int", nullable: false),
                    PaymentName = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    IdVoucher = table.Column<int>(type: "int", nullable: true),
                    ValueVoucher = table.Column<int>(type: "int", nullable: true),
                    Giamgia = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Ship = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    ODSuccess = table.Column<bool>(type: "bit", nullable: false),
                    ODReadly = table.Column<bool>(type: "bit", nullable: false),
                    ODTransported = table.Column<bool>(type: "bit", nullable: false),
                    Complete = table.Column<bool>(type: "bit", nullable: false),
                    customerIdKh = table.Column<int>(type: "int", nullable: false),
                    voucherIdVoucher = table.Column<int>(type: "int", nullable: false),
                    DbPaymentPaymentId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbOrder", x => x.IdDh);
                    table.ForeignKey(
                        name: "FK_DbOrder_DbCustomer_customerIdKh",
                        column: x => x.customerIdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbOrder_DbPayment_DbPaymentPaymentId",
                        column: x => x.DbPaymentPaymentId,
                        principalTable: "DbPayment",
                        principalColumn: "PaymentId");
                    table.ForeignKey(
                        name: "FK_DbOrder_DbVoucher_voucherIdVoucher",
                        column: x => x.voucherIdVoucher,
                        principalTable: "DbVoucher",
                        principalColumn: "IdVoucher",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbUser_Voucher",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    IdVoucher = table.Column<int>(type: "int", nullable: false),
                    UsedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    customerIdKh = table.Column<int>(type: "int", nullable: false),
                    voucherIdVoucher = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbUser_Voucher", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DbUser_Voucher_DbCustomer_customerIdKh",
                        column: x => x.customerIdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbUser_Voucher_DbVoucher_voucherIdVoucher",
                        column: x => x.voucherIdVoucher,
                        principalTable: "DbVoucher",
                        principalColumn: "IdVoucher",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbFavoriteProduct",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    productIdSp = table.Column<int>(type: "int", nullable: false),
                    customerIdKh = table.Column<int>(type: "int", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbFavoriteProduct", x => x.id);
                    table.ForeignKey(
                        name: "FK_DbFavoriteProduct_DbCustomer_customerIdKh",
                        column: x => x.customerIdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbFavoriteProduct_DbProduct_productIdSp",
                        column: x => x.productIdSp,
                        principalTable: "DbProduct",
                        principalColumn: "IdSp",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbImg",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    Img = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    IsDefault = table.Column<bool>(type: "bit", nullable: false),
                    Place = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    productIdSp = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbImg", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DbImg_DbProduct_productIdSp",
                        column: x => x.productIdSp,
                        principalTable: "DbProduct",
                        principalColumn: "IdSp",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbProductDetail",
                columns: table => new
                {
                    IdCTSP = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaCTSP = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    SizeId = table.Column<int>(type: "int", nullable: false),
                    ColorId = table.Column<int>(type: "int", nullable: false),
                    SoLuongTon = table.Column<int>(type: "int", nullable: true),
                    productIdSp = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbProductDetail", x => x.IdCTSP);
                    table.ForeignKey(
                        name: "FK_DbProductDetail_DbColor_ColorId",
                        column: x => x.ColorId,
                        principalTable: "DbColor",
                        principalColumn: "ColorId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbProductDetail_DbProduct_productIdSp",
                        column: x => x.productIdSp,
                        principalTable: "DbProduct",
                        principalColumn: "IdSp",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbProductDetail_DbSize_SizeId",
                        column: x => x.SizeId,
                        principalTable: "DbSize",
                        principalColumn: "SizeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbOrderDetail",
                columns: table => new
                {
                    IdCTDH = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaCTDH = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    IdDh = table.Column<int>(type: "int", nullable: false),
                    AnhSp = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    SoLuongSp = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IdProductDetail = table.Column<int>(type: "int", nullable: false),
                    ProductDetailIdCTSP = table.Column<int>(type: "int", nullable: false),
                    orderIdDh = table.Column<int>(type: "int", nullable: false),
                    DbColorColorId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbOrderDetail", x => x.IdCTDH);
                    table.ForeignKey(
                        name: "FK_DbOrderDetail_DbColor_DbColorColorId",
                        column: x => x.DbColorColorId,
                        principalTable: "DbColor",
                        principalColumn: "ColorId");
                    table.ForeignKey(
                        name: "FK_DbOrderDetail_DbOrder_orderIdDh",
                        column: x => x.orderIdDh,
                        principalTable: "DbOrder",
                        principalColumn: "IdDh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbOrderDetail_DbProductDetail_ProductDetailIdCTSP",
                        column: x => x.ProductDetailIdCTSP,
                        principalTable: "DbProductDetail",
                        principalColumn: "IdCTSP",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DbAddress_customerIdKh",
                table: "DbAddress",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_customerIdKh",
                table: "DbFavoriteProduct",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_productIdSp",
                table: "DbFavoriteProduct",
                column: "productIdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbImg_productIdSp",
                table: "DbImg",
                column: "productIdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_customerIdKh",
                table: "DbOrder",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_DbPaymentPaymentId",
                table: "DbOrder",
                column: "DbPaymentPaymentId");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_voucherIdVoucher",
                table: "DbOrder",
                column: "voucherIdVoucher");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_DbColorColorId",
                table: "DbOrderDetail",
                column: "DbColorColorId");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_orderIdDh",
                table: "DbOrderDetail",
                column: "orderIdDh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_ProductDetailIdCTSP",
                table: "DbOrderDetail",
                column: "ProductDetailIdCTSP");

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_categoryIdDm",
                table: "DbProduct",
                column: "categoryIdDm");

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_groupIdNhom",
                table: "DbProduct",
                column: "groupIdNhom");

            migrationBuilder.CreateIndex(
                name: "IX_DbProductDetail_ColorId",
                table: "DbProductDetail",
                column: "ColorId");

            migrationBuilder.CreateIndex(
                name: "IX_DbProductDetail_productIdSp",
                table: "DbProductDetail",
                column: "productIdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbProductDetail_SizeId",
                table: "DbProductDetail",
                column: "SizeId");

            migrationBuilder.CreateIndex(
                name: "IX_DbUser_Voucher_customerIdKh",
                table: "DbUser_Voucher",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbUser_Voucher_voucherIdVoucher",
                table: "DbUser_Voucher",
                column: "voucherIdVoucher");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DbAddress");

            migrationBuilder.DropTable(
                name: "DbAdmin");

            migrationBuilder.DropTable(
                name: "DbAds");

            migrationBuilder.DropTable(
                name: "DbFavoriteProduct");

            migrationBuilder.DropTable(
                name: "DbImg");

            migrationBuilder.DropTable(
                name: "DbInforShop");

            migrationBuilder.DropTable(
                name: "DbOrderDetail");

            migrationBuilder.DropTable(
                name: "DbUser_Voucher");

            migrationBuilder.DropTable(
                name: "DbOrder");

            migrationBuilder.DropTable(
                name: "DbProductDetail");

            migrationBuilder.DropTable(
                name: "DbCustomer");

            migrationBuilder.DropTable(
                name: "DbPayment");

            migrationBuilder.DropTable(
                name: "DbVoucher");

            migrationBuilder.DropTable(
                name: "DbColor");

            migrationBuilder.DropTable(
                name: "DbProduct");

            migrationBuilder.DropTable(
                name: "DbSize");

            migrationBuilder.DropTable(
                name: "DbCategory");

            migrationBuilder.DropTable(
                name: "DbGroup");
        }
    }
}
