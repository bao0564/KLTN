document.addEventListener('DOMContentLoaded', function () {
    let selectedSize = null;
    let selectedColor = null;

    // Xử lý lựa chọn size
    const sizeOptions = document.querySelectorAll('.size-option');
    sizeOptions.forEach(function (option) {
        option.addEventListener('click', function () {
            sizeOptions.forEach(function (opt) {
                opt.classList.remove('selected');
            });
            option.classList.add('selected');
            selectedSize = option.getAttribute('data-size');
            checkSelection();
        });
    });

    // Xử lý lựa chọn màu sắc
    const colorOptions = document.querySelectorAll('.color-option');
    colorOptions.forEach(function (option) {
        option.addEventListener('click', function () {
            colorOptions.forEach(function (opt) {
                opt.classList.remove('selected');
            });
            option.classList.add('selected');
            selectedColor = option.getAttribute('data-color');
            checkSelection();
        });
    });

    // Kiểm tra nếu cả size và màu đã được chọn
    function checkSelection() {
        const addToCartBtn = document.getElementById('addToCartBtn');
        if (selectedSize && selectedColor) {
            addToCartBtn.disabled = false;
        } else {
            addToCartBtn.disabled = true;
        }
    }

});