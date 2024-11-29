using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class fixdbimg : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbImg_DbProduct_productIdSp",
                table: "DbImg");

            migrationBuilder.DropIndex(
                name: "IX_DbImg_productIdSp",
                table: "DbImg");

            migrationBuilder.DropColumn(
                name: "productIdSp",
                table: "DbImg");

            migrationBuilder.CreateIndex(
                name: "IX_DbImg_IdSp",
                table: "DbImg",
                column: "IdSp");

            migrationBuilder.AddForeignKey(
                name: "FK_DbImg_DbProduct_IdSp",
                table: "DbImg",
                column: "IdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbImg_DbProduct_IdSp",
                table: "DbImg");

            migrationBuilder.DropIndex(
                name: "IX_DbImg_IdSp",
                table: "DbImg");

            migrationBuilder.AddColumn<int>(
                name: "productIdSp",
                table: "DbImg",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_DbImg_productIdSp",
                table: "DbImg",
                column: "productIdSp");

            migrationBuilder.AddForeignKey(
                name: "FK_DbImg_DbProduct_productIdSp",
                table: "DbImg",
                column: "productIdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
