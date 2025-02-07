using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class _62 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbRating_DbCustomer_customerIdKh",
                table: "DbRating");

            migrationBuilder.DropIndex(
                name: "IX_DbRating_customerIdKh",
                table: "DbRating");

            migrationBuilder.RenameColumn(
                name: "customerIdKh",
                table: "DbRating",
                newName: "IdDh");

            migrationBuilder.AddColumn<string>(
                name: "ColorSize",
                table: "DbRating",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_DbRating_IdKh",
                table: "DbRating",
                column: "IdKh");

            migrationBuilder.AddForeignKey(
                name: "FK_DbRating_DbCustomer_IdKh",
                table: "DbRating",
                column: "IdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbRating_DbCustomer_IdKh",
                table: "DbRating");

            migrationBuilder.DropIndex(
                name: "IX_DbRating_IdKh",
                table: "DbRating");

            migrationBuilder.DropColumn(
                name: "ColorSize",
                table: "DbRating");

            migrationBuilder.RenameColumn(
                name: "IdDh",
                table: "DbRating",
                newName: "customerIdKh");

            migrationBuilder.CreateIndex(
                name: "IX_DbRating_customerIdKh",
                table: "DbRating",
                column: "customerIdKh");

            migrationBuilder.AddForeignKey(
                name: "FK_DbRating_DbCustomer_customerIdKh",
                table: "DbRating",
                column: "customerIdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
