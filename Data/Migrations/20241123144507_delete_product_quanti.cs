using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class delete_product_quanti : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DbProduct_Quantity");

            migrationBuilder.RenameColumn(
                name: "SoLuongTon",
                table: "DbProductDetail",
                newName: "SoLuongBan");

            migrationBuilder.AddColumn<decimal>(
                name: "GiaLoai",
                table: "DbProductDetail",
                type: "decimal(18,2)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Quantity",
                table: "DbProductDetail",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "GiaLoai",
                table: "DbProductDetail");

            migrationBuilder.DropColumn(
                name: "Quantity",
                table: "DbProductDetail");

            migrationBuilder.RenameColumn(
                name: "SoLuongBan",
                table: "DbProductDetail",
                newName: "SoLuongTon");

            migrationBuilder.CreateTable(
                name: "DbProduct_Quantity",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    productdetailIdCTSP = table.Column<int>(type: "int", nullable: false),
                    IdCTSP = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DbProduct_Quantity", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DbProduct_Quantity_DbProductDetail_productdetailIdCTSP",
                        column: x => x.productdetailIdCTSP,
                        principalTable: "DbProductDetail",
                        principalColumn: "IdCTSP",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_Quantity_productdetailIdCTSP",
                table: "DbProduct_Quantity",
                column: "productdetailIdCTSP");
        }
    }
}
