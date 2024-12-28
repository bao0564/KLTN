using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class _281224 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbCategory_categoryIdDm",
                table: "DbProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbGroup_groupIdNhom",
                table: "DbProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbProduct_categoryIdDm",
                table: "DbProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbProduct_groupIdNhom",
                table: "DbProduct");

            migrationBuilder.DropColumn(
                name: "categoryIdDm",
                table: "DbProduct");

            migrationBuilder.DropColumn(
                name: "groupIdNhom",
                table: "DbProduct");

            migrationBuilder.AlterColumn<string>(
                name: "MaSp",
                table: "DbProduct",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10);

            migrationBuilder.AlterColumn<string>(
                name: "MaColor",
                table: "DbColor",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10);

            migrationBuilder.AddColumn<string>(
                name: "MaHex",
                table: "DbColor",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "MaDm",
                table: "DbCategory",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10);

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_IdDm",
                table: "DbProduct",
                column: "IdDm");

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_NhomId",
                table: "DbProduct",
                column: "NhomId");

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbCategory_IdDm",
                table: "DbProduct",
                column: "IdDm",
                principalTable: "DbCategory",
                principalColumn: "IdDm",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbGroup_NhomId",
                table: "DbProduct",
                column: "NhomId",
                principalTable: "DbGroup",
                principalColumn: "IdNhom",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbCategory_IdDm",
                table: "DbProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbGroup_NhomId",
                table: "DbProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbProduct_IdDm",
                table: "DbProduct");

            migrationBuilder.DropIndex(
                name: "IX_DbProduct_NhomId",
                table: "DbProduct");

            migrationBuilder.DropColumn(
                name: "MaHex",
                table: "DbColor");

            migrationBuilder.AlterColumn<string>(
                name: "MaSp",
                table: "DbProduct",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "categoryIdDm",
                table: "DbProduct",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "groupIdNhom",
                table: "DbProduct",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "MaColor",
                table: "DbColor",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "MaDm",
                table: "DbCategory",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_categoryIdDm",
                table: "DbProduct",
                column: "categoryIdDm");

            migrationBuilder.CreateIndex(
                name: "IX_DbProduct_groupIdNhom",
                table: "DbProduct",
                column: "groupIdNhom");

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbCategory_categoryIdDm",
                table: "DbProduct",
                column: "categoryIdDm",
                principalTable: "DbCategory",
                principalColumn: "IdDm");

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbGroup_groupIdNhom",
                table: "DbProduct",
                column: "groupIdNhom",
                principalTable: "DbGroup",
                principalColumn: "IdNhom");
        }
    }
}
