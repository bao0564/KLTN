
$(document).ready(function () {
    var UploadExcelStock = (function () {

        let tableBody = document.querySelector("#previewTableBody");
        let products = [];
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

                tableBody.innerHTML = ""; // Xóa dữ liệu cũ trước khi hiển thị mới

                for (let i = 1; i < rows.length; i++)  {
                    let row = rows[i];

                    let maSp = row[0];  // Cột A: Mã sản phẩm
                    //let tenSp = row[1];  // Cột b: Tên sản phẩm
                    //let mactsp = row[2] ?? "0";  // Cột c: Mã màu
                    let colorId = row[3];  // Cột c: Mã màu
                    let sizeId = row[4];  // Cột d: Mã size
                    let quantity = row[5] ?? "0";  // Cột e: Số lượng nhập

                    if (!maSp) continue;
                    fetch(`/Admin/getstockinfor?masp=${maSp}&idcl=${colorId}&idsize=${sizeId}`)
                        .then(r => r.ok ? r.json() : { maCTsp: "lỗi", tenSp: "lỗi", tenColor: "lỗi", tenSize:"lỗi" })
                        .then((ctsp) => {
                            let tr = document.createElement("tr");
                            tr.innerHTML = `
                                <td>${maSp}</td>
                                <td>${ctsp.tenSp}</td>
                                <td>${ctsp.maCTsp}</td>
                                <td>${ctsp.tenColor}</td>
                                <td>${ctsp.tenSize}</td>
                                <td>${quantity}</td>
                                <td></td>
                            `;
                            tableBody.appendChild(tr);
                            if (ctsp.maCTsp !== "error") {
                                const existingProduct = products.find(p => p.MaCTSP === ctsp.maCTsp);
                                if (existingProduct) {
                                    existingProduct.Quantity += parseInt(quantity);
                                } else {
                                    products.push({
                                        MaCTSP: ctsp.maCTsp,
                                        Quantity: parseInt(quantity)
                                    });
                                }
                            }
                    });

                    // Thêm vào danh sách để gửi lên server
                }
            };
        };
        function uploadStock() {
            document.getElementById("uploadstock").addEventListener('click', function () {
                fileStock();
            });
        }
        function sendStockToServer() {
            document.getElementById("saveStockBtn").addEventListener('click', function () {
                if (products.length === 0) {
                    alert("Không có dữ liệu để lưu!");
                    return;
                }

                fetch('/Admin/insertstock', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(products)
                })
                    .then(rs => rs.json())
                    .then(data => {
                        showMess(data.msg, true);
                        tableBody.innerHTML = ""; 
                    })
                    .catch(error => {
                        showMess(error.msg, false);
                    });
            });
        }
        return {
            init: function () {
                uploadStock();
                sendStockToServer();
            }
        };
    })();
    UploadExcelStock.init();
});