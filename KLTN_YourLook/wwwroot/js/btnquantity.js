
$('.checkout-btn').off('click').on('click', function (e) {
    e.preventDefault();
    $.ajax({
        url: '/shoppingcart/payorder',
        type: 'POST',
        success: function (response) {
            if (response.success) {
                window.location.href = '/shoppingcart/payordersuccess';
            } else {
                alert('Có lỗi xảy ra: ' + response.message);
            }
        },
        error: function (xhr, status, error) {
            alert('Có lỗi xảy ra: ' + error);
        }
    });
});