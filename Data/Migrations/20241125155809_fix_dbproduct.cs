using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class fix_dbproduct : Migration
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

            migrationBuilder.AlterColumn<int>(
                name: "groupIdNhom",
                table: "DbProduct",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "categoryIdDm",
                table: "DbProduct",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "NhomId",
                table: "DbProduct",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbCategory_categoryIdDm",
                table: "DbProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_DbProduct_DbGroup_groupIdNhom",
                table: "DbProduct");

            migrationBuilder.AlterColumn<int>(
                name: "groupIdNhom",
                table: "DbProduct",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "categoryIdDm",
                table: "DbProduct",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "NhomId",
                table: "DbProduct",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbCategory_categoryIdDm",
                table: "DbProduct",
                column: "categoryIdDm",
                principalTable: "DbCategory",
                principalColumn: "IdDm",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbProduct_DbGroup_groupIdNhom",
                table: "DbProduct",
                column: "groupIdNhom",
                principalTable: "DbGroup",
                principalColumn: "IdNhom",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
