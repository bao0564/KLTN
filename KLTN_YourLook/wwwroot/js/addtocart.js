$(document).ready(function () {
    //===================================================
    var AddToCart = (function () {// Thêm sp vào giỏ hàng        
        function btnAddToCart() {
            $('body').on('click', '.btnAddToCart', function (e) {
                e.preventDefault();
                var idsp = $(this).data('idsp');
                var quantity = $('#quantity_value').val();
                if (quantity != '') {
                    quantity = parseInt(quantity);
                    if (quantity==0) {
                        showMess("Số lượng sản phẩm phải lớn hơn 0", false);
                        return false;
                    }
                }
                // size/color
                var selectedSize = $('.size-option.selected').data('size');
                var selectedColor = $('.color-option.selected').data('color');

                if (!selectedSize || !selectedColor) {
                    showMess("Vui lòng chọn size và màu sắc", false);
                    return;
                }
                $.ajax({
                    url: '/shoppingcart/addtocart',
                    type: 'POST',
                    data: { idsp: idsp, quantity: quantity, sizeid: selectedSize, colorid: selectedColor },
                    success: function (rs) {
                        if (rs.success) {
                            showMess(rs.msg, true);// lấy thông báo từ controller
                            location.reload();
                        } else {
                            showMess(rs.msg, false);// lấy thông báo từ controller
                        }
                    },
                    else: function () {
                        showMess("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.", false);
                    }
                });
                return false; // chặn sự kiện khác thực thi
            });
        };

        return {
            init: function () {
                btnAddToCart();
            }
        }
    })();
    //___________________________________
    AddToCart.init();
});