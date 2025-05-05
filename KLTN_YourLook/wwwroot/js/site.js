$(document).ready(function () {
    //================= cuộn ẩn hiện header =======================
    var ScrollHeader = (function () {
        function crollHeader () {
            let lastScrollTop = 0;
            const header = document.getElementById('headerr');
            const suggetion = document.getElementById('suggestions');// danh sách gọi ý

            window.addEventListener('scroll', function () {
                const currentScroll = window.pageYOffset || document.documentElement.scrollTop;
                if (currentScroll > lastScrollTop) {
                    header.style.top = '-200px';
                    suggetion.style.display = 'none';// ẩn gọi ý
                } else {
                    header.style.top = '0';
                    suggetion.style.display = 'block';
                }
                lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
            });
        }
        return {
            init: function () {
                crollHeader();
            }
        }
    })();
    //================== yêu thích sản phẩm=====================
    var FavoritePrd = (function () {
        function bindFavoritePrd() {
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
                            showMess(response.message, true);
                            //alert(response.message);
                        } else {
                            showMess(response.message, false);
                            //alert(response.message);
                        }
                    },
                    error: function () {
                        showMess('Có lỗi xảy ra khi thêm sản phẩm vào yêu thích.');
                    }
                });
            });
        };
        return {
            init: function () {
                bindFavoritePrd();
            }
        }
    })();
    //_____________________________________________
    ScrollHeader.init();
    FavoritePrd.init();
});

