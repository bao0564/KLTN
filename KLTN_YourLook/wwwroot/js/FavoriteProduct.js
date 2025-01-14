//import { error } from "jquery";

$(document).ready(function () {
    $('.favorite').click(function () {
        var prdid = $(this).data('id');
        var icon = $(this).find('i');
        $.ajax({
            url: '/User/FavoriteProduct/',
            type: 'POST',
            data: { idsp: prdid },
            success: function (response) {
                if (response.success) {
                    if (icon.hasClass('fa-regular fa-heart')) {
                        icon.removeClass('fa-regular fa-heart').addClass('fa-solid fa-heart');
                    } else {
                        icon.removeClass('fa-solid fa-heart').addClass('fa-regular fa-heart');
                    }
                    showMess(response.message,true);
                    //alert(response.message);
                } else {
                    showMess(response.message,false);
                    //alert(response.message);
                }
            },
            error: function () {
                showMess('Có lỗi xảy ra khi thêm sản phẩm vào yêu thích.');
            }
        });
    });
});
