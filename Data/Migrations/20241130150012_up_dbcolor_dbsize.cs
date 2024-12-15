using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class up_dbcolor_dbsize : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbOrderDetail_DbColor_DbColorColorId",
                table: "DbOrderDetail");

            migrationBuilder.DropForeignKey(
                name: "FK_DbProductDetail_DbProduct_productIdSp",
                table: "DbProductDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbProductDetail_productIdSp",
                table: "DbProductDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbOrderDetail_DbColorColorId",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "productIdSp",
                table: "DbProductDetail");

            migrationBuilder.DropColumn(
                name: "DbColorColorId",
                table: "DbOrderDetail");

            migrationBuilder.CreateIndex(
                name: "IX_DbProductDetail_IdSp",
                table: "DbProductDetail",
                column: "IdSp");

            migrationBuilder.AddForeignKey(
                name: "FK_DbProductDetail_DbProduct_IdSp",
                table: "DbProductDetail",
                column: "IdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbProductDetail_DbProduct_IdSp",
                table: "DbProductDetail");

            migrationBuilder.DropIndex(
                name: "IX_DbProductDetail_IdSp",
                table: "DbProductDetail");

            migrationBuilder.AddColumn<int>(
                name: "productIdSp",
                table: "DbProductDetail",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "DbColorColorId",
                table: "DbOrderDetail",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DbProductDetail_productIdSp",
                table: "DbProductDetail",
                column: "productIdSp");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrderDetail_DbColorColorId",
                table: "DbOrderDetail",
                column: "DbColorColorId");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrderDetail_DbColor_DbColorColorId",
                table: "DbOrderDetail",
                column: "DbColorColorId",
                principalTable: "DbColor",
                principalColumn: "ColorId");

            migrationBuilder.AddForeignKey(
                name: "FK_DbProductDetail_DbProduct_productIdSp",
                table: "DbProductDetail",
                column: "productIdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
