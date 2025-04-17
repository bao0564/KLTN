
$(document).ready(function () {
    var UploadExcelStock = (function () {
        function fileStock() {
            let fileInput = document.getElementById("fileStock").files[0];
            if (!fileInput) {
                alert("Vui lòng chọn file Excel!");
                return;
            }
            let reader = new FileReader();
            reader.readAsArrayBuffer(fileInput);
            reader.onload = function (e) {
                let data = new Uint8Array(e.target.result);
                let workbook = XLSX.read(data, { type: 'array' });
                let sheetName = workbook.SheetNames[0];
                let sheet = workbook.Sheets[sheetName];

                // Chuyển dữ liệu từ sheet thành JSON
                let rows = XLSX.utils.sheet_to_json(sheet, { header: 1 });
                // Kiểm tra dữ liệu đầu vào
                if (rows.length < 2) {
                    alert("File không có dữ liệu!");
                    return;
                }

                let tableBody = document.querySelector("#previewTableBody");
                tableBody.innerHTML = ""; // Xóa dữ liệu cũ trước khi hiển thị mới

                let products = [];

                for (let i = 1; i < rows.length; i++)  {
                    let row = rows[i];

                    let maSp = row[0];  // Cột A: Mã sản phẩm
                    let colorId = row[1] ?? "0";  // Cột B: Mã màu
                    let sizeId = row[2] ?? "0";  // Cột B: Mã size
                    let quantity = row[3];  // Cột C: Số lượng nhập

                    if (!maSp) continue;

                    // Thêm vào danh sách hiển thị
                    let tr = document.createElement("tr");
                    tr.innerHTML = `<td>${maSp}</td><td>${colorId}</td><td>${sizeId}</td><td>${quantity}</td>`;
                    tableBody.appendChild(tr);

                    // Thêm vào danh sách để gửi lên server
                    let existingProduct = products.find(p => p.MaSp == maSp);
                    if (existingProduct) {
                        existingProduct.ColorQuantities.push({ ColorId: colorId, Quantity: quantity });
                    }
                    else {
                        products.push({
                            MaSp: maSp,
                            ColorQuantities: [{ ColorId: colorId, Quantity: quantity }]
                        });
                    }
                }

                    // Gửi dữ liệu lên server 
                    // let response = await fetch("/api/update-stock", {
                    //     method: "POST",
                    //     headers: { "Content-Type": "application/json" },
                    //     body: JSON.stringify(products)
                    // });

                    // let result = await response.json();
                    // alert(result.message);
            };
        };
        function uploadStock() {
            document.getElementById("uploadstock").addEventListener('click', function () {
                fileStock();
            });
        }
        return {
            init: function () {
                uploadStock();
            }
        };
    })();
    UploadExcelStock.init();
});