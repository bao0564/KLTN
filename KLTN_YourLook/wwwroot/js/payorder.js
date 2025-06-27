$(document).ready(function (){
    var Order = (function () {
        function orderSuccess() {
            $('.checkout-btn-ocd').off('click').on('click', function (e) {
                e.preventDefault();
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
                orderSuccess();
            }
        }
    })();
    var PayOrder = (function () {
        function payOrder() {
            $('.checkout-btn').off('click').on('click', function (e) {
                var thanhtoan = $('#tienthanhtoan').val();
                const payData = {
                    tongTien: thanhtoan
                };
                // Lưu vào session
                sessionStorage.setItem("payorderdata", JSON.stringify(payData));
                window.location.href = "/shoppingcart/paymentspace";
            });
        };
        return {
            init: function () {
                payOrder();
            }
        }
    })();
    Order.init();
    PayOrder.init();
})