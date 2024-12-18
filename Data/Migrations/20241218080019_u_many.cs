using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class u_many : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbCustomer_customerIdKh",
                table: "DbOrder");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbVoucher_voucherIdVoucher",
                table: "DbOrder");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrderDetail_DbOrder_orderIdDh",
                table: "DbOrderDetail");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrderDetail_DbProductDetail_ProductDetailIdCTSP",
                table: "DbOrderDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbOrderDetail_ProductDetailIdCTSP",
                table: "DbOrderDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_customerIdKh",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_voucherIdVoucher",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "AnhSp",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "customerIdKh",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "voucherIdVoucher",
                table: "DbOrder");

            migrationBuilder.RenameColumn(
                name: "orderIdDh",
                table: "DbOrderDetail",
                newName: "IdSp");

            migrationBuilder.RenameColumn(
                name: "ProductDetailIdCTSP",
                table: "DbOrderDetail",
                newName: "IdSize");

            migrationBuilder.RenameColumn(
                name: "IdProductDetail",
                table: "DbOrderDetail",
                newName: "IdColor");

            migrationBuilder.RenameIndex(
                name: "IX_DbOrderDetail_orderIdDh",
                table: "DbOrderDetail",
                newName: "IX_DbOrderDetail_IdSp");

            migrationBuilder.AlterColumn<string>(
                name: "MaCTDH",
                table: "DbOrderDetail",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10);

            migrationBuilder.AddColumn<string>(
                name: "MaDh",
                table: "DbOrderDetail",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "MaSp",
                table: "DbOrderDetail",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "MaDh",
                table: "DbOrder",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(25)",
                oldMaxLength: 25);

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_IdDh",
                table: "DbOrderDetail",
                column: "IdDh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_IdKh",
                table: "DbOrder",
                column: "IdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_IdVoucher",
                table: "DbOrder",
                column: "IdVoucher");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbCustomer_IdKh",
                table: "DbOrder",
                column: "IdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbVoucher_IdVoucher",
                table: "DbOrder",
                column: "IdVoucher",
                principalTable: "DbVoucher",
                principalColumn: "IdVoucher",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrderDetail_DbOrder_IdDh",
                table: "DbOrderDetail",
                column: "IdDh",
                principalTable: "DbOrder",
                principalColumn: "IdDh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrderDetail_DbProduct_IdSp",
                table: "DbOrderDetail",
                column: "IdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbCustomer_IdKh",
                table: "DbOrder");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbVoucher_IdVoucher",
                table: "DbOrder");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrderDetail_DbOrder_IdDh",
                table: "DbOrderDetail");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrderDetail_DbProduct_IdSp",
                table: "DbOrderDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbOrderDetail_IdDh",
                table: "DbOrderDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_IdKh",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_IdVoucher",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "MaDh",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "MaSp",
                table: "DbOrderDetail");

            migrationBuilder.RenameColumn(
                name: "IdSp",
                table: "DbOrderDetail",
                newName: "orderIdDh");

            migrationBuilder.RenameColumn(
                name: "IdSize",
                table: "DbOrderDetail",
                newName: "ProductDetailIdCTSP");

            migrationBuilder.RenameColumn(
                name: "IdColor",
                table: "DbOrderDetail",
                newName: "IdProductDetail");

            migrationBuilder.RenameIndex(
                name: "IX_DbOrderDetail_IdSp",
                table: "DbOrderDetail",
                newName: "IX_DbOrderDetail_orderIdDh");

            migrationBuilder.AlterColumn<string>(
                name: "MaCTDH",
                table: "DbOrderDetail",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(500)",
                oldMaxLength: 500);

            migrationBuilder.AddColumn<string>(
                name: "AnhSp",
                table: "DbOrderDetail",
                type: "nvarchar(250)",
                maxLength: 250,
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "Price",
                table: "DbOrderDetail",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AlterColumn<string>(
                name: "MaDh",
                table: "DbOrder",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(500)",
                oldMaxLength: 500);

            migrationBuilder.AddColumn<int>(
                name: "customerIdKh",
                table: "DbOrder",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "voucherIdVoucher",
                table: "DbOrder",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_ProductDetailIdCTSP",
                table: "DbOrderDetail",
                column: "ProductDetailIdCTSP");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_customerIdKh",
                table: "DbOrder",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_voucherIdVoucher",
                table: "DbOrder",
                column: "voucherIdVoucher");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbCustomer_customerIdKh",
                table: "DbOrder",
                column: "customerIdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbVoucher_voucherIdVoucher",
                table: "DbOrder",
                column: "voucherIdVoucher",
                principalTable: "DbVoucher",
                principalColumn: "IdVoucher",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrderDetail_DbOrder_orderIdDh",
                table: "DbOrderDetail",
                column: "orderIdDh",
                principalTable: "DbOrder",
                principalColumn: "IdDh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrderDetail_DbProductDetail_ProductDetailIdCTSP",
                table: "DbOrderDetail",
                column: "ProductDetailIdCTSP",
                principalTable: "DbProductDetail",
                principalColumn: "IdCTSP",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
