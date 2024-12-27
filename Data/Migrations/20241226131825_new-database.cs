using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class newdatabase : Migration
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
                    Img = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Place = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
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
                    NameColor = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Img = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
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
                    Passwords = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
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
                    PaymentName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
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
                    Idefault = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbAddress", x => x.IdAddress);
                    table.ForeignKey(
                        name: "FK_DbAddress_DbCustomer_IdKh",
                        column: x => x.IdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DbProduct",
                columns: table => new
                {
                    IdSp = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaSp = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    IdDm = table.Column<int>(type: "int", nullable: false),
                    TenSp = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    SaoDanhGia = table.Column<int>(type: "int", nullable: true),
                    NhomId = table.Column<int>(type: "int", nullable: false),
                    AnhSp = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    PriceMax = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    GiamGia = table.Column<int>(type: "int", nullable: true),
                    PriceMin = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    LuotXem = table.Column<int>(type: "int", nullable: true),
                    LuotSold = table.Column<int>(type: "int", nullable: true),
                    MotaSp = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IActive = table.Column<bool>(type: "bit", nullable: false),
                    IFavorite = table.Column<bool>(type: "bit", nullable: false),
                    IFeature = table.Column<bool>(type: "bit", nullable: false),
                    IHot = table.Column<bool>(type: "bit", nullable: false),
                    ISale = table.Column<bool>(type: "bit", nullable: false),
                    categoryIdDm = table.Column<int>(type: "int", nullable: true),
                    groupIdNhom = table.Column<int>(type: "int", nullable: true),
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
                        principalColumn: "IdDm");
                    table.ForeignKey(
                        name: "FK_DbProduct_DbGroup_groupIdNhom",
                        column: x => x.groupIdNhom,
                        principalTable: "DbGroup",
                        principalColumn: "IdNhom");
                });

            migrationBuilder.CreateTable(
                name: "DbOrder",
                columns: table => new
                {
                    IdDh = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MaDh = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    NguoiNhan = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    EmailKh = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: false),
                    Sdt = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    City = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    District = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Ward = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    DiaChi = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    TongTien = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TongTienThanhToan = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    soluong = table.Column<int>(type: "int", nullable: false),
                    PaymentId = table.Column<int>(type: "int", nullable: false),
                    PaymentName = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    IdVoucher = table.Column<int>(type: "int", nullable: true),
                    ValueVoucher = table.Column<int>(type: "int", nullable: true),
                    Giamgia = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Ship = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ODSuccess = table.Column<bool>(type: "bit", nullable: true),
                    ODReadly = table.Column<bool>(type: "bit", nullable: true),
                    ODTransported = table.Column<bool>(type: "bit", nullable: true),
                    Complete = table.Column<bool>(type: "bit", nullable: true),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbOrder", x => x.IdDh);
                    table.ForeignKey(
                        name: "FK_DbOrder_DbCustomer_IdKh",
                        column: x => x.IdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_DbOrder_DbPayment_PaymentId",
                        column: x => x.PaymentId,
                        principalTable: "DbPayment",
                        principalColumn: "PaymentId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_DbOrder_DbVoucher_IdVoucher",
                        column: x => x.IdVoucher,
                        principalTable: "DbVoucher",
                        principalColumn: "IdVoucher",
                        onDelete: ReferentialAction.Restrict);
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
                name: "DbCart",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    IdKh = table.Column<int>(type: "int", nullable: false),
                    ProductQuantity = table.Column<int>(type: "int", nullable: false),
                    ColorId = table.Column<int>(type: "int", nullable: false),
                    SizeId = table.Column<int>(type: "int", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbCart", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DbCart_DbColor_ColorId",
                        column: x => x.ColorId,
                        principalTable: "DbColor",
                        principalColumn: "ColorId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbCart_DbCustomer_IdKh",
                        column: x => x.IdKh,
                        principalTable: "DbCustomer",
                        principalColumn: "IdKh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbCart_DbProduct_IdSp",
                        column: x => x.IdSp,
                        principalTable: "DbProduct",
                        principalColumn: "IdSp",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbCart_DbSize_SizeId",
                        column: x => x.SizeId,
                        principalTable: "DbSize",
                        principalColumn: "SizeId",
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
                    Place = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbImg", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DbImg_DbProduct_IdSp",
                        column: x => x.IdSp,
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
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    SizeId = table.Column<int>(type: "int", nullable: false),
                    NameSize = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ColorId = table.Column<int>(type: "int", nullable: false),
                    NameColor = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    SoLuongBan = table.Column<int>(type: "int", nullable: true),
                    GiaLoai = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Quantity = table.Column<int>(type: "int", nullable: false)
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
                        name: "FK_DbProductDetail_DbProduct_IdSp",
                        column: x => x.IdSp,
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
                    IdDh = table.Column<int>(type: "int", nullable: false),
                    MaDh = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    IdSp = table.Column<int>(type: "int", nullable: false),
                    MaSp = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    IdColor = table.Column<int>(type: "int", nullable: false),
                    IdSize = table.Column<int>(type: "int", nullable: false),
                    SoLuongSp = table.Column<int>(type: "int", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreateBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ModifiedBy = table.Column<string>(type: "nvarchar(25)", maxLength: 25, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbOrderDetail", x => x.IdCTDH);
                    table.ForeignKey(
                        name: "FK_DbOrderDetail_DbOrder_IdDh",
                        column: x => x.IdDh,
                        principalTable: "DbOrder",
                        principalColumn: "IdDh",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DbOrderDetail_DbProduct_IdSp",
                        column: x => x.IdSp,
                        principalTable: "DbProduct",
                        principalColumn: "IdSp",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DbAddress_IdKh",
                table: "DbAddress",
                column: "IdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbCart_ColorId",
                table: "DbCart",
                column: "ColorId");

            migrationBuilder.CreateIndex(
                name: "IX_DbCart_IdKh",
                table: "DbCart",
                column: "IdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbCart_IdSp",
                table: "DbCart",
                column: "IdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbCart_SizeId",
                table: "DbCart",
                column: "SizeId");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_customerIdKh",
                table: "DbFavoriteProduct",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_productIdSp",
                table: "DbFavoriteProduct",
                column: "productIdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbImg_IdSp",
                table: "DbImg",
                column: "IdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_IdKh",
                table: "DbOrder",
                column: "IdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_IdVoucher",
                table: "DbOrder",
                column: "IdVoucher");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_PaymentId",
                table: "DbOrder",
                column: "PaymentId");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_IdDh",
                table: "DbOrderDetail",
                column: "IdDh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_IdSp",
                table: "DbOrderDetail",
                column: "IdSp");

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
                name: "IX_DbProductDetail_IdSp",
                table: "DbProductDetail",
                column: "IdSp");

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
                name: "DbCart");

            migrationBuilder.DropTable(
                name: "DbFavoriteProduct");

            migrationBuilder.DropTable(
                name: "DbImg");

            migrationBuilder.DropTable(
                name: "DbInforShop");

            migrationBuilder.DropTable(
                name: "DbOrderDetail");

            migrationBuilder.DropTable(
                name: "DbProductDetail");

            migrationBuilder.DropTable(
                name: "DbUser_Voucher");

            migrationBuilder.DropTable(
                name: "DbOrder");

            migrationBuilder.DropTable(
                name: "DbColor");

            migrationBuilder.DropTable(
                name: "DbProduct");

            migrationBuilder.DropTable(
                name: "DbSize");

            migrationBuilder.DropTable(
                name: "DbCustomer");

            migrationBuilder.DropTable(
                name: "DbPayment");

            migrationBuilder.DropTable(
                name: "DbVoucher");

            migrationBuilder.DropTable(
                name: "DbCategory");

            migrationBuilder.DropTable(
                name: "DbGroup");
        }
    }
}
