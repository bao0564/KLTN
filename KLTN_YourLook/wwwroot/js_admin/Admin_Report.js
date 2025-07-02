$(document).ready(function () {
    var ExcelExport_Inventory = (function () {
        function bindExcelExport_Inventory() {
            //gán sự kiện click xuất excel list product
            document.getElementById("exportInventoryProductExcel").addEventListener('click', function () {
                let currentUrlParams = new URLSearchParams(window.location.search); //lấy chính đường dẫn đang có
                fetch("/admin/inventory_export_excel?" + currentUrlParams.toString())
                    .then(response => response.blob())
                    .then(blob => {
                        var today = new Date();
                        var day = String(today.getDate()).padStart(2, '0');
                        var month = String(today.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
                        var year = today.getFullYear();
                        var formattedDate = `${day}/${month}/${year}`;

                        const url = window.URL.createObjectURL(blob);
                        const a = document.createElement("a");
                        a.href = url;
                        a.download = "DanhSachSanPhamTonKho" + formattedDate +".xlsx"; // Gợi ý tên file
                        document.body.appendChild(a);
                        a.click(); // Hiển thị hộp thoại "Save As"
                        document.body.removeChild(a);
                    })
                    .catch(error => console.error("lỗi tải file", error));
            });
        }
        return {
            init: function () {
                bindExcelExport_Inventory();
            }
        };
    })();
    ExcelExport_Inventory.init();
});