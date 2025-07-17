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

//chọn lọc trạng thái đơn hàng
document.querySelectorAll('input[type="checkbox"]').forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
        if (this.checked) {
            document.querySelectorAll('input[type="checkbox"]').forEach(function (otherCheckbox) {
                if (otherCheckbox !== checkbox) {
                    otherCheckbox.checked = false;
                }
            });
            applyFilter();
        } else {
            applyFilter();
        }
    });
});
function applyFilter() {
    let currentUrlParams = new URLSearchParams(window.location.search);

    // Lấy checkbox duy nhất được chọn
    let selected = document.querySelector('input[name="status"]:checked');

    // Xóa hết các trạng thái trước đó trong URL
    currentUrlParams.delete("odsuccess");
    currentUrlParams.delete("odreadly");
    currentUrlParams.delete("odtranport");
    currentUrlParams.delete("complete");
    currentUrlParams.delete("odhuy");
    currentUrlParams.delete("odreturn");

    if (selected) {
        currentUrlParams.set(selected.id, true);
    }

    window.location.href = "/admin/order?" + currentUrlParams.toString();
}