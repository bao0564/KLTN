$(document).ready(function () {
    $('.favorite').click(function () {
        var prdid = $(this).data('id');
        var icon = $(this).find('i');
        $.ajax({
            url: '/User/FavoriteProduct/',
            type: 'POST',
            data: { masp: prdid },
            success: function (response) {
                if (response.success) {
                    if (icon.hasClass('fa-regular')) {
                        icon.removeClass('fa-regular fa-heart').addClass('fa-solid fa-heart');
                    } else {
                        icon.removeClass('fa-solid fa-heart').addClass('fa-regular fa-heart');
                    }
                    alert(response.message);
                }else {
                    alert(response.message);
                }
            },
            error: function () {
                alert('Có lỗi xảy ra khi thêm sản phẩm vào yêu thích.');
            }
        });
    });
});