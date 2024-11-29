using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class addDbProduct_Quantities : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MaCTSP",
                table: "DbProductDetail");

            migrationBuilder.CreateTable(
                name: "DbProduct_Quantity",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdCTSP = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    productdetailIdCTSP = table.Column<int>(type: "int", nullable: false)
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DbProduct_Quantity");

            migrationBuilder.AddColumn<string>(
                name: "MaCTSP",
                table: "DbProductDetail",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: false,
                defaultValue: "");
        }
    }
}
