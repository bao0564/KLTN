using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Data.Migrations
{
    /// <inheritdoc />
    public partial class u_dborder_dborderdetail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MaCTDH",
                table: "DbOrderDetail");

            migrationBuilder.AlterColumn<string>(
                name: "MaSp",
                table: "DbOrderDetail",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<string>(
                name: "CreateBy",
                table: "DbOrderDetail",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreateDate",
                table: "DbOrderDetail",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ModifiedBy",
                table: "DbOrderDetail",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "ModifiedDate",
                table: "DbOrderDetail",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CreateBy",
                table: "DbOrder",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreateDate",
                table: "DbOrder",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ModifiedBy",
                table: "DbOrder",
                type: "nvarchar(25)",
                maxLength: 25,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "ModifiedDate",
                table: "DbOrder",
                type: "datetime2",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CreateBy",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "CreateDate",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "ModifiedBy",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "ModifiedDate",
                table: "DbOrderDetail");

            migrationBuilder.DropColumn(
                name: "CreateBy",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "CreateDate",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "ModifiedBy",
                table: "DbOrder");

            migrationBuilder.DropColumn(
                name: "ModifiedDate",
                table: "DbOrder");

            migrationBuilder.AlterColumn<string>(
                name: "MaSp",
                table: "DbOrderDetail",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10);

            migrationBuilder.AddColumn<string>(
                name: "MaCTDH",
                table: "DbOrderDetail",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                defaultValue: "");
        }
    }
}
