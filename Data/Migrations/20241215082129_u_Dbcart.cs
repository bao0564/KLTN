using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class u_Dbcart : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DbCart");

            migrationBuilder.AlterColumn<string>(
                name: "Passwords",
                table: "DbCustomer",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(25)",
                oldMaxLength: 25);
        }
    }
}
