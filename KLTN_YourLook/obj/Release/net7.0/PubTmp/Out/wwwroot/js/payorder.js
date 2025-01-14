$('.checkout-btn').off('click').on('click', function (e) {
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