﻿$(document).ready(function () {
    // ================== ==================
    var checkMasp = (function () {
        //kiểm tra mã sp (blur: thường được gọi để kiểm tra dl nhập khi rời khỏi ô nhập)
        function getMasp() {
            document.getElementById("masp").addEventListener("blur", function () {
                var sp = this.value;
                var idsp = document.getElementById("idsp") ? document.getElementById("idsp").value : null; // Lấy ID sản phẩm (nếu có)
                var url = `/admin/productcheck?masp=${encodeURIComponent(sp)}`;
                if (idsp) {
                    url += `&idsp=${encodeURIComponent(idsp)}`;
                }
                fetch(url)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.exists) {
                            alert("Mã sản phẩm đã tồn tại!");
                        }
                    })
                    .catch(error => console.error('Error:', error));
            });
        }
        return {
            init: function () {
                getMasp();
            }
        };
    })();
    // ================== Quản lý giá giảm ==================
    var CalculatePrice = (function () {
        function checkMaxValue(input) {
            if (!input) return;
            const maxValue = parseInt(input.getAttribute("max")) || 100;
            const currentValue = parseInt(input.value) || 0;

            if (currentValue > maxValue) {
                document.getElementById("GiamGiaError").innerText = `Giảm giá không được vượt quá ${maxValue}.`;
                input.value = maxValue;
            } else {
                document.getElementById("GiamGiaError").innerText = "";
            }
            calculateGiaMin();
        }

        function calculateGiaMin() {
            var giaMax = parseFloat(document.getElementById('GiaMax').value) || 0;
            var giamGia = parseFloat(document.getElementById('GiamGia').value) || 0;
            var giaMin = giaMax - (giaMax * giamGia / 100);
            document.getElementById('GiaMin').value = (Math.round(giaMin / 100) * 100);
        }

        function bindPrice() {
            document.getElementById('GiamGia').addEventListener('input', function () {
                checkMaxValue(this);
            });
        }

        return {
            init: function () {
                bindPrice();
            }
        };
    })();
    // ================== Quản lý chi tiết sản phẩm ==================
    var ListDetail = (function () {           
        function isDetailExists(colorValue, sizeValue) {// Kiểm tra trùng lặp chi tiết
            const rows = document.querySelectorAll("#detailTableBody tr");
            for (const row of rows) {
                const existingColor = row.querySelector("input[name*='ColorId']").value;
                const existingSize = row.querySelector("input[name*='SizeId']").value;
                if (existingColor === colorValue && existingSize === sizeValue) {
                    return true;
                }
            }
            return false;
        }     
        function addDetailsToTable() {// Thêm chi tiết vào bảng
            const selectedSizes = document.querySelectorAll('input[name="SelectedSizes"]:checked');
            const selectedColors = document.querySelectorAll('input[name="SelectedColors"]:checked');
            const tableBody = document.getElementById("detailTableBody");

            selectedColors.forEach(color => {
                selectedSizes.forEach(size => {
                    const colorValue = color.value;
                    const sizeValue = size.value;

                    // Kiểm tra trùng lặp
                    if (!isDetailExists(colorValue, sizeValue)) {
                        const row = document.createElement("tr");
                        row.className = "cell";

                        // Thêm dữ liệu vào hàng
                        row.innerHTML = `
                                    <td>
                                        ${color.getAttribute('data-namecolor')}
                                        <input type="hidden" name="Details[${sizeValue}][${colorValue}].ColorId" value="${colorValue}" />
                                        <input type="hidden" name="Details[${sizeValue}][${colorValue}].NameColor" value="${color.getAttribute('data-namecolor')}" />
                                    </td>
                                    <td>
                                        ${size.getAttribute('data-namesize')}
                                        <input type="hidden" name="Details[${sizeValue}][${colorValue}].SizeId" value="${sizeValue}" />
                                        <input type="hidden" name="Details[${sizeValue}][${colorValue}].NameSize" value="${size.getAttribute('data-namesize')}" />
                                    </td>
                                    <td><input type="number" name="Details[${sizeValue}][${colorValue}].GiaLoai" class="form-control" /></td>
                                    <td><input type="number" name="Details[${sizeValue}][${colorValue}].Quantity" class="form-control" /></td>
                                    <td><input type="button" value="Xóa" class="btnXoaCell" /></td>
                                `;

                        tableBody.appendChild(row);
                    }
                });
            });
            // Xóa 
            $('body').on('click', '.btnXoaCell', function () {
                var userConfirmed = confirm("Bạn có chắc chắn muốn xóa phân loại này không?");
                if (userConfirmed) {                    
                    $(this).closest('tr').remove();
                }
            });
        }
        function saveAllDetail() {
            // Xử lý dữ liệu trước khi submit form
            document.getElementById("saveDetailsBtn").addEventListener("click", function () {
                const rows = document.querySelectorAll("#detailTableBody tr");
                let detailsString = "";

                rows.forEach(row => {
                    const idColor = row.querySelector("input[name*='ColorId']").value;
                    const colorName = row.querySelector("input[name*='NameColor']").value;
                    const idSize = row.querySelector("input[name*='SizeId']").value;
                    const sizeName = row.querySelector("input[name*='NameSize']").value;
                    const price = row.querySelector("input[name*='GiaLoai']").value.trim() || 0;
                    const quantity = row.querySelector("input[name*='Quantity']").value.trim() || 0;

                    // Tạo chuỗi định dạng
                    detailsString += `${idColor},${colorName},${idSize},${sizeName},${price},${quantity};`;
                });

                // Gán chuỗi vào input ẩn để gửi về server
                document.getElementById("detailData").value = detailsString;
            });
        }
        function bindPrductDetail() {
            document.getElementById("addDetailsBtn").addEventListener("click", function () {
                addDetailsToTable();
            });
        }
        return {
            init: function () {
                bindPrductDetail();
                saveAllDetail();
            }
        }

    })();   
    //
    checkMasp.init();
    CalculatePrice.init();
    ListDetail.init();
});
// //phân tách hàng nghìn trăm chục
// document.querySelectorAll('.format_number').forEach(function (input) {
//     input.addEventListener('input', function (e) {
//         let value = e.target.value.replace(/\./g, '');
//         if (!isNaN(value) && value !== "") {
//             e.target.value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
//         } else {
//             e.target.value = "";
//         }
//     });
// });
