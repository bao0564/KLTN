using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class u_foreignkey : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbAddress_DbCustomer_customerIdKh",
                table: "DbAddress");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbAddress_customerIdKh",
                table: "DbAddress");

            migrationBuilder.DropColumn(
                name: "customerIdKh",
                table: "DbAddress");

            migrationBuilder.CreateIndex(
                name: "IX_DbAddress_IdKh",
                table: "DbAddress",
                column: "IdKh");

            migrationBuilder.AddForeignKey(
                name: "FK_DbAddress_DbCustomer_IdKh",
                table: "DbAddress",
                column: "IdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder",
                column: "PaymentId",
                principalTable: "DbPayment",
                principalColumn: "PaymentId",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbAddress_DbCustomer_IdKh",
                table: "DbAddress");

            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbAddress_IdKh",
                table: "DbAddress");

            migrationBuilder.AddColumn<int>(
                name: "customerIdKh",
                table: "DbAddress",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DbAddress_customerIdKh",
                table: "DbAddress",
                column: "customerIdKh");

            migrationBuilder.AddForeignKey(
                name: "FK_DbAddress_DbCustomer_customerIdKh",
                table: "DbAddress",
                column: "customerIdKh",
                principalTable: "DbCustomer",
                principalColumn: "IdKh");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder",
                column: "PaymentId",
                principalTable: "DbPayment",
                principalColumn: "PaymentId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
