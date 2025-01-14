$(document).ready(function () {
    initThumbnail();

    function initThumbnail() {
        if ($('.single_product_thumbnails ul li').length) {
            var thumbs = $('.single_product_thumbnails ul li');
            var singleImage = $('.single_product_image_background');

            thumbs.each(function () {
                var item = $(this);
                item.on('click', function () {
                    thumbs.removeClass('active');
                    item.addClass('active');
                    var img = item.find('img').data('image');
                    singleImage.css('background-image', 'url(' + img + ')');
                });
            });
        }
    }
});
