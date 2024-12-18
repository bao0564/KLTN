using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class u_dbpayment_dborder : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbPayment_DbPaymentPaymentId",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_DbPaymentPaymentId",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "DbPaymentPaymentId",
                table: "DbOrder");

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_PaymentId",
                table: "DbOrder",
                column: "PaymentId");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder",
                column: "PaymentId",
                principalTable: "DbPayment",
                principalColumn: "PaymentId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DbOrder_DbPayment_PaymentId",
                table: "DbOrder");

            migrationBuilder.DropIndex(
                name: "IX_DbOrder_PaymentId",
                table: "DbOrder");

            migrationBuilder.AddColumn<int>(
                name: "DbPaymentPaymentId",
                table: "DbOrder",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DbOrder_DbPaymentPaymentId",
                table: "DbOrder",
                column: "DbPaymentPaymentId");

            migrationBuilder.AddForeignKey(
                name: "FK_DbOrder_DbPayment_DbPaymentPaymentId",
                table: "DbOrder",
                column: "DbPaymentPaymentId",
                principalTable: "DbPayment",
                principalColumn: "PaymentId");
        }
    }
}
