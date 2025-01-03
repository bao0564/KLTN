using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class _1125 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbFavoriteProduct_DbCustomer_customerIdKh",
                table: "DbFavoriteProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_DbFavoriteProduct_DbProduct_productIdSp",
                table: "DbFavoriteProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbFavoriteProduct_customerIdKh",
                table: "DbFavoriteProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbFavoriteProduct_productIdSp",
                table: "DbFavoriteProduct");

            migrationBuilder.DropColumn(
                name: "customerIdKh",
                table: "DbFavoriteProduct");

            migrationBuilder.DropColumn(
                name: "productIdSp",
                table: "DbFavoriteProduct");

            migrationBuilder.AlterColumn<string>(
                name: "Passwords",
                table: "DbCustomer",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(25)",
                oldMaxLength: 25);

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_IdKh",
                table: "DbFavoriteProduct",
                column: "IdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_IdSp",
                table: "DbFavoriteProduct",
                column: "IdSp");

            migrationBuilder.AddForeignKey(
                name: "FK_DbFavoriteProduct_DbCustomer_IdKh",
                table: "DbFavoriteProduct",
                column: "IdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbFavoriteProduct_DbProduct_IdSp",
                table: "DbFavoriteProduct",
                column: "IdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbFavoriteProduct_DbCustomer_IdKh",
                table: "DbFavoriteProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_DbFavoriteProduct_DbProduct_IdSp",
                table: "DbFavoriteProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbFavoriteProduct_IdKh",
                table: "DbFavoriteProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbFavoriteProduct_IdSp",
                table: "DbFavoriteProduct");

            migrationBuilder.AddColumn<int>(
                name: "customerIdKh",
                table: "DbFavoriteProduct",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "productIdSp",
                table: "DbFavoriteProduct",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<string>(
                name: "Passwords",
                table: "DbCustomer",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(25)",
                oldMaxLength: 25,
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_customerIdKh",
                table: "DbFavoriteProduct",
                column: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbFavoriteProduct_productIdSp",
                table: "DbFavoriteProduct",
                column: "productIdSp");

            migrationBuilder.AddForeignKey(
                name: "FK_DbFavoriteProduct_DbCustomer_customerIdKh",
                table: "DbFavoriteProduct",
                column: "customerIdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbFavoriteProduct_DbProduct_productIdSp",
                table: "DbFavoriteProduct",
                column: "productIdSp",
                principalTable: "DbProduct",
                principalColumn: "IdSp",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
