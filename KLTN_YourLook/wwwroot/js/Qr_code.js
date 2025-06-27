
$(document).ready(function () {
    var QrCode = (function () {
        function CreatQrCode() {
            let bankCode = "VCB";
            let soTaiKhoan = "1041927725"; // Số tài khoản nhận tiền
            let tenNguoiNhan = "Đang Minh Bao"; // Tên người nhận (bạn)
            let noiDung = "Thanh Toan Don"; // nội dung chuyển khoản
            const detailpayorder = JSON.parse(sessionStorage.getItem("payorderdata"));

            if (!detailpayorder) {
                document.getElementById("orderInfo").innerHTML = "<p>Không tìm thấy dữ liệu đơn hàng.</p>";
            }
            //else {
            //    document.getElementById("orderInfo").innerHTML = `<p><strong>Tổng tiền thanh toán:</strong> ${detailpayorder.tongTien.toLocaleString()} VND</p>`;
            //}
            // Tạo chuỗi VietQR dạng ME
            let qrUrl = `https://img.vietqr.io/image/${bankCode}-${soTaiKhoan}-print.png?amount=${detailpayorder.tongTien}&addInfo=${encodeURIComponent(noiDung)}&accountName=${encodeURIComponent(tenNguoiNhan)}`;

            // Gắn QR vào trang
            document.getElementById("qrcode").innerHTML = `<img src="${qrUrl}" width="300" alt="QR thanh toán"/>`;
        };
        return {
            init: function () {
                CreatQrCode();
            }
        }
    })();
    var PayComplete = (function () {
        function payComplete() {
            $('.pay_complete').off('click').on('click', function (e) {
                e.preventDefault();
                //thêm 1 bước kiểm tra xem chuyển khoản thành công chưa                
                $.ajax({
                    url: '/shoppingcart/payorder',
                    type: 'POST',
                    success: function (response) {
                        if (response.success) {
                            window.location.href = '/shoppingcart/payordersuccess';
                        } else {
                            showMess("Có lỗi xảy ra không đặt được hàng.", false);
                        }
                    },
                    error: function (xhr, status, error) {
                        showMess("Có lỗi xảy ra khi đặt hàng", false);
                    }
                });
            });
        };
        return {
            init: function () {
                payComplete();
            }
        }
    })();
    QrCode.init();
    PayComplete.init();
})