/*thêm thông tin sản phẩm vào bảng sản phẩm DbProduct*/
//kiểm tra mã sp tối thiểu 5 ký tự
function MaSpLength() {
    const input = document.getElementById('masp').value;
    const error = document.getElementById('error');

    error.textContent = input.length < 7 ? 'Mã Sp ít nhất 7 ký tự! ký tự đầu là viết tắt của phân loại' : '';
}
//kiểm tra tên sp dưới 100 ký tự
function TenSpLength() {
    const input = document.getElementById('tensp').value;
    const error = document.getElementById('error');

    error.textContent = input.length >100 ? 'Tên Sản Phẩm tối đa 100 ký tự' : '';
}
//kiểm tra mã sp (blur: thường được gọi để kiểm tra dl nhập khi rời khỏi ô nhập)
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
        .catch(error => console.error('Error:', error)); // Thêm xử lý lỗi
});


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


//
//kiểm tra mức giảm giá vượt giá trị cho phép
function checkMaxValue(input) {
    const maxValue = parseInt(input.getAttribute("max")); // Lấy giá trị max từ max
    const currentValue = parseInt(input.value);

    if (currentValue > maxValue) {
        document.getElementById("GiamGiaError").innerText = `Giảm giá không được vượt quá ${maxValue}.`;
        input.value = maxValue; // Giới hạn giá trị nhập về max
    } else {
        document.getElementById("GiamGiaError").innerText = ""; // Xóa thông báo lỗi
    }
    calculateGiaMin();
}


//
//tính giá sau khi điền giảm giá
function calculateGiaMin() {
    var giaMax = parseFloat(document.getElementById('GiaMax').value) || 0;
    var giamGia = parseFloat(document.getElementById('GiamGia').value) || 0;
    var giaMin =( giaMax - (giaMax * giamGia / 100) );
    document.getElementById('GiaMin').value = giaMin.toFixed(0); // Giữ lại 0 chữ số thập phân
}

/* thêm chi tiết sản phẩm vào bảng chi tiết sản phẩm DbProductdetail */
// Sự kiện khi nhấn nút "Thêm chi tiết"
document.getElementById("addDetailsBtn").addEventListener("click", function () {
    addDetailsToTable();
});
//Xóa dòng
$('body').on('click', '.btnXoaCell', function () {
    $(this).closest('.cell').remove();
});
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
}
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