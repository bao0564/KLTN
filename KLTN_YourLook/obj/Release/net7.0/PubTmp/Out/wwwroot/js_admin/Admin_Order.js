$(document).ready(function () {
    //================Xuất order excel===================
    var ExportOrderExcel = (function () {
        function bindOrderExcel() {
            //gán sự kiện click xuất excel cho các sự kiện lọc
            document.getElementById("exportOrderExcel").addEventListener("click", function () {
                let currentUrlParams = new URLSearchParams(window.location.search);

                fetch("/admin/orderexportexcel?" + currentUrlParams.toString())
                    .then(response => response.blob()) // Nhận dữ liệu dạng file
                    .then(blob => {
                        const url = window.URL.createObjectURL(blob);
                        const a = document.createElement("a");
                        a.href = url;
                        a.download = "DanhSachDonHang.xlsx"; // Gợi ý tên file
                        document.body.appendChild(a);
                        a.click(); // Hiển thị hộp thoại "Save As"
                        document.body.removeChild(a);
                    })
                    .catch(error => console.error("Lỗi tải file:", error));
            });
        }
        return {
            init: function () {
                bindOrderExcel();
            }
        }
    })();
    //---------------------------------
    ExportOrderExcel.init();
});
//không tự động chạy
//lọc trạng thái đơn hàng
function applyFilter() {
    let currentUrlParams = new URLSearchParams(window.location.search);

    // Lấy giá trị của các checkbox trạng thái đơn hàng
    let odsuccess = document.getElementById("odsuccess").checked;
    let odreadly = document.getElementById("odreadly").checked;
    let odtranport = document.getElementById("odtranport").checked;
    let complete = document.getElementById("complete").checked;
    let odhuy = document.getElementById("odhuy").checked;

    // Cập nhật giá trị trạng thái đơn hàng vào URL
    currentUrlParams.set("odsuccess", odsuccess);
    currentUrlParams.set("odreadly", odreadly);
    currentUrlParams.set("odtranport", odtranport);
    currentUrlParams.set("complete", complete);
    currentUrlParams.set("odhuy", odhuy);

    // Chuyển hướng với đầy đủ tham số
    window.location.href = "/admin/order?" + currentUrlParams.toString();
}

