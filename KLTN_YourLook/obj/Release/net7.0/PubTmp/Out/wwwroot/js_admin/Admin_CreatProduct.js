/*thêm thông tin sản phẩm vào bảng sản phẩm DbProduct*/
////kiểm tra mã sp tối thiểu 5 ký tự
//function MaSpLength() {
//    const input = document.getElementById('masp').value;
//    const error = document.getElementById('error');

//    error.textContent = input.length < 7 ? 'Mã Sp ít nhất 7 ký tự! ký tự đầu là viết tắt của phân loại' : '';
//}
////kiểm tra tên sp dưới 100 ký tự
//function TenSpLength() {
//    const input = document.getElementById('tensp').value;
//    const error = document.getElementById('error');

//    error.textContent = input.length >100 ? 'Tên Sản Phẩm tối đa 100 ký tự' : '';
//}
//
//phân tách hàng nghìn trăm chục
    //document.querySelectorAll('.format_number').forEach(function (input) {
    //    input.addEventListener('input', function (e) {
    //        let value = e.target.value.replace(/\./g, '');
    //        if (!isNaN(value) && value !== "") {
    //            e.target.value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    //        } else {
    //            e.target.value = "";
    //        }
    //    });
//});

//JS trong tạo sản phẩm mới
$(document).ready(function () {
    // ================== Quản lý ảnh ==================
    var ImageUploader = (function () {
        var imgUrls = [];

        function updateImgsInput() {
            var imgUrls = [];
            $('#imagesTable .box img').each(function () {
                var imgSrc = $(this).attr('src');
                imgUrls.push(imgSrc);
            });
            $('#Imgs').val(imgUrls.join(';'));
        }

        function bindImgs() {
            $('#btnUpload').click(function () {
                var files = $('#fileUpload').prop('files');
                var formData = new FormData();

                for (var i = 0; i < files.length; i++) {
                    formData.append('files', files[i]);
                }

                $.ajax({
                    //url: '@Url.Action("UploadImg", "Product")', //nếu đặt trong tệp cshtml
                    url: 'uploadimg',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response.success) {
                            response.filePaths.forEach(function (filePath) {
                                $('#imagesTable #tablei').append(`
                                    <div class="box">
                                        <img src="/img/${filePath}">
                                        <div class="box_btn">
                                            <a href="#" class="btnXoaAnh">
                                                <i class="fa-solid fa-xmark" style="color: #ffffff;"></i>
                                            </a>
                                        </div>
                                    </div>
                                `);
                                imgUrls.push(filePath);
                                updateImgsInput();
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi khi tải ảnh lên:', error);
                    }
                });
            });

            // Xóa ảnh
            $('body').on('click', '.btnXoaAnh', function () {
                var conf = confirm('Bạn có muốn xóa ảnh này không?');
                if (conf) {
                    $(this).closest('.box').remove();
                    updateImgsInput();
                }
            });
        }

        return {
            init: function () {
                bindImgs();
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
        function addDetailsToTable() {
            const selectedSizes = document.querySelectorAll('input[name="SelectedSizes"]:checked');
            const selectedColors = document.querySelectorAll('input[name="SelectedColors"]:checked');
            const tableBody = document.getElementById("detailTableBody");

            selectedColors.forEach(color => {
                selectedSizes.forEach(size => {
                    const colorValue = color.value;
                    const sizeValue = size.value;
                    if (!isDetailExists(colorValue, sizeValue)) {//nếu trả về false thì thực hiện thêm

                        const row = document.createElement("tr");
                        row.className = "cell";

                        // Màu sắc
                        const colorCell = document.createElement("td");//tạo cột td để chứa thoongt in màu sác
                        colorCell.textContent = color.getAttribute('data-namecolor');//tên màu được hiển thị trên giao diện

                        const colorIdInput = document.createElement("input");//tạo input chứa id màu
                        colorIdInput.type = "hidden";//đặt type ẩn cho colorIdInput
                        colorIdInput.name = `Details[${size.value}][${color.value}].IdColor`;//đặt name="" colorIdInput, dùng để truyền dữ liệu lên server
                        colorIdInput.value = color.value;// Gán giá trị ID của màu sắc được chọn
                        colorCell.appendChild(colorIdInput);// Thêm input này vào ô (cell) chứa thông tin màu sắc

                        const colorNameInput = document.createElement("input");
                        colorNameInput.type = "hidden";
                        colorNameInput.name = `Details[${size.value}][${color.value}].ColorName`;
                        colorNameInput.value = color.getAttribute('data-namecolor');
                        colorCell.appendChild(colorNameInput);

                        // Size
                        const sizeCell = document.createElement("td");
                        sizeCell.textContent = size.getAttribute('data-namesize');

                        const sizeIdInput = document.createElement("input");
                        sizeIdInput.type = "hidden";
                        sizeIdInput.name = `Details[${size.value}][${color.value}].IdSize`;
                        sizeIdInput.value = size.value;
                        sizeCell.appendChild(sizeIdInput);

                        const sizeNameInput = document.createElement("input");
                        sizeNameInput.type = "hidden";
                        sizeNameInput.name = `Details[${size.value}][${color.value}].SizeName`;
                        sizeNameInput.value = size.getAttribute('data-namesize');
                        sizeCell.appendChild(sizeNameInput);

                        // Giá
                        const priceCell = document.createElement("td");
                        const priceInput = document.createElement("input");
                        priceInput.type = "number";
                        priceInput.name = `Details[${size.value}][${color.value}].GiaLoai`;
                        priceInput.className = "form-control";
                        priceCell.appendChild(priceInput);

                        // Số lượng
                        const quantityCell = document.createElement("td");
                        const quantityInput = document.createElement("input");
                        quantityInput.type = "number";
                        quantityInput.name = `Details[${size.value}][${color.value}].Quantity`;
                        quantityInput.className = "form-control";
                        quantityCell.appendChild(quantityInput);

                        //cột thao tác
                        const deleteCell = document.createElement("td");
                        const deleteButton = document.createElement("input");
                        deleteButton.type = "button";
                        deleteButton.value = "Xóa";
                        deleteButton.className = "btnXoaCell";
                        deleteCell.appendChild(deleteButton);

                        row.appendChild(colorCell);
                        row.appendChild(sizeCell);
                        row.appendChild(priceCell);
                        row.appendChild(quantityCell);
                        row.appendChild(deleteCell);

                        tableBody.appendChild(row);
                    }
                });
            });
            //Xóa dòng
            $('body').on('click', '.btnXoaCell', function () {
                var userConfirmed = confirm("Bạn có chắc chắn muốn xóa phân loại này không?");
                if (userConfirmed) {
                    $(this).closest('tr').remove();
                }
            });
        }
        //kiểm tra trùng lặp:
        function isDetailExists(colorValue, sizeValue) {
            const rows = document.querySelectorAll("#detailTableBody tr");
            for (const row of rows) {
                const existingColor = row.querySelector(`input[name*="IdColor"]`).value;//màu hiện tại có
                const existingSize = row.querySelector(`input[name*="IdSize"]`).value;//size hiện tại có
                if (existingColor === colorValue && existingSize === sizeValue) {
                    return true;//có thì trả về true
                }
            }
            return false;
        };
        function saveAllDetail() {
            // Xử lý dữ liệu trước khi submit form
            document.getElementById("saveDetailsBtn").addEventListener("click", function () {
                const rows = document.querySelectorAll("#detailTableBody tr");
                let detailsString = "";
                rows.forEach(row => {
                    const idColor = row.cells[0].querySelector("input[name*='IdColor']").value;       // ID màu
                    const colorName = row.cells[0].querySelector("input[name*='ColorName']").value;   // Tên màu
                    const idSize = row.cells[1].querySelector("input[name*='IdSize']").value;         // ID size
                    const sizeName = row.cells[1].querySelector("input[name*='SizeName']").value;     // Tên size

                    // Lấy giá và số lượng, gán giá trị mặc định nếu để trống
                    const priceInput = row.cells[2].querySelector("input");
                    const price = priceInput.value.trim() === "" ? 0 : priceInput.value;

                    const quantityInput = row.cells[3].querySelector("input");
                    const quantity = quantityInput.value.trim() === "" ? 0 : quantityInput.value;

                    // Tạo chuỗi định dạng: idColor,colorName,idSize,sizeName,price,quantity;
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
    // ================== chạy tất cả ==================
    ImageUploader.init();
    CalculatePrice.init();
    ListDetail.init();
});
  