$(document).ready(function () {
    var suggetion_mactsp = (function () {
        var typingTimer;
        const sugget_place = document.getElementById('suggestions');
        function LoadSugget() {
            $("#input_mctsp").keyup(function () {
                clearTimeout(typingTimer);
                var keyword_ = $(this).val();
                if (keyword_.length >= 1) {
                    sugget_place.style.display = 'block';
                    typingTimer = setTimeout(function () {
                        $.ajax({
                            url: '/admin/api_find_mctsp',
                            data: { keyword:keyword_},
                            success: function (data) {
                                var suggettions = $("#suggestions");
                                suggettions.empty();

                                if (data.length > 0) {
                                    data.forEach(function (item) {
                                        suggettions.append(
                                            `<div class="suggest">
                                                <div class="pd-lr suggest-item">${item.mactsp}</div>
                                            </div>`
                                        )
                                    });
                                    suggestions.show();
                                } else {
                                    suggestions.hide();
                                }
                            },
                            error: function () {
                                $("#suggestions").hide();
                            }
                        });
                    }, 300); // Đợi 300ms sau mỗi lần gõ
                } else {
                    $("#suggestions").hide();
                }
            });

            // Click chọn gợi ý
            $(document).on("click", ".suggest-item", function () {
                var value = $(this).text();
                $("#input_mctsp").val(value);
                $("#suggestions").hide();
            });

            // Ẩn gợi ý khi click bên ngoài
            $(document).click(function (e) {
                if (!$(e.target).closest('#input_mctsp, #suggestions').length) {
                    $("#suggestions").hide();
                }
            });
        }

        return {
            init: function () {
                LoadSugget();
            }
        };
    })();
    //xuất excel
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
                        a.download = "DanhSachSanPhamTonKho" + formattedDate + ".xlsx"; // Gợi ý tên file
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
    suggetion_mactsp.init();
    ExcelExport_Inventory.init();
})