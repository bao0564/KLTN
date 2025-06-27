$(document).ready(function () {
    //=================================
    var ImgTransfer = (function () {
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
        return {
            init: function () {
                initThumbnail();
            }
        }
    })();
    //=================================
    var ChoosColorSize = (function () {
        //const productId = document.getElementById("product-id").value;
        const sizeOptions = document.querySelectorAll(".size-option");
        const colorOptions = document.querySelectorAll(".color-option");
        const PriceOption = document.getElementById("type_price");
        const msg = document.getElementById("msg");
        let PriceDefault = parseFloat($('#type_price').data('price'));//giá mặc định

        let selectedSize = null;
        let selectedColor = null;
        // Kiểm tra tính hợp lệ của màu sắc dựa trên kích cỡ
        function checkColorForSize(sizeId, colorId) {
            // Đây là nơi kiểm tra logic giữa size và color 
            return productDetails.some(d => d.sizeId === parseInt(sizeId) && d.colorId === parseInt(colorId));
        };
        
        // Kiểm tra tính hợp lệ của kích cỡ dựa trên màu sắc
        function checkSizeForColor(colorId, sizeId) {
            return productDetails.some(d => d.colorId === parseInt(colorId) && d.sizeId === parseInt(sizeId));
        };

        // Cập nhật các nút màu dựa trên kích cỡ
        function updateColorOptions(sizeId) {
            colorOptions.forEach(button => {
                const isValid = checkColorForSize(sizeId, button.getAttribute("data-color"));
                button.disabled = !isValid;
                button.classList.toggle("disabled", !isValid);
                if (!isValid) {
                    button.classList.remove("selected");
                }
            });
        };

        // Cập nhật các nút kích cỡ dựa trên màu sắc
        function updateSizeOptions(colorId) {
            sizeOptions.forEach(button => {
                const isValid = checkSizeForColor(colorId, button.getAttribute("data-size"));
                button.disabled = !isValid;
                button.classList.toggle("disabled", !isValid);
                if (!isValid) {
                    button.classList.remove("selected");
                }
            });
        };
        // Hiển thị giá và số lượng
        function updatePriceAndQuantity() {
            if (!selectedColor && selectedSize) {
                msg.innerText = "chọn thêm màu";
                return;
            }
            if (!selectedSize && selectedColor) {
                msg.innerText = "chọn thêm size";
                return;
            }
            var quantity = $('#quantity_value').val();
            const detail = productDetails.find(d => d.sizeId === parseInt(selectedSize) && d.colorId === parseInt(selectedColor));
            var quantityleft = detail.quantity;
            if (detail) {
                PriceOption.innerText = `${detail.giaLoai.toLocaleString()}`;
                msg.innerText = `Còn lại: ${detail.quantity} sản phẩm`;
                //console.log("SizeId:", sizeId, "ColorId:", colorId);
            }
            if (quantity > quantityleft) {
                msg.innerText = `số lượng mua vượt quá số lượng sản phẩm còn lại`;

                showMess("Số lượng mua vượt quá số lượng còn lại của sản phẩm", false);
                return false;
            }
        };
        // Highlight nút được chọn
        function highlightSelected(selectedButton, allButtons) {
            allButtons.forEach(button => button.classList.remove("selected"));
            selectedButton.classList.add("selected");
        };
        // reset size và color
        function resetColorButtons() {
            colorOptions.forEach(button => {
                button.disabled = false;
                button.classList.remove('disabled');
                button.classList.remove('selected');
            });
            PriceOption.innerText = PriceDefault.toLocaleString("en-US", { maximumFractionDigits: 0 });
            msg.innerText = "";
            selectedColor = null; // Xóa trạng thái màu sắc đã chọn
            selectedSize = null; // Xóa trạng thái màu sắc đã chọn
        };
        function resetSizeButtons() {
            sizeOptions.forEach(button => {
                button.disabled = false; // Bật lại tất cả các nút
                button.classList.remove("disabled");
                button.classList.remove("selected"); // Xóa highlight  
            });
            PriceOption.innerText = PriceDefault.toLocaleString("en-US", { maximumFractionDigits: 0 });
            msg.innerText = "";
            selectedColor = null; // Xóa trạng thái màu sắc đã chọn
            selectedSize = null; // Xóa trạng thái màu sắc đã chọn
        };
        return {
            init: function () {

                // Sự kiện chọn kích cỡ
                sizeOptions.forEach(button => {
                    button.addEventListener("click", () => {
                        // Lấy ID kích cỡ
                        var takeSize = button.getAttribute("data-size");
                        if (selectedSize === takeSize) {
                            selectedSize = null;
                            button.classList.remove("selected"); // Bỏ lớp highlight
                            resetColorButtons();
                        }
                        else {
                            selectedSize = takeSize;
                            updateColorOptions(selectedSize);
                            highlightSelected(button, sizeOptions);
                        }
                        updatePriceAndQuantity();
                    });
                });

                // Sự kiện chọn màu sắc
                colorOptions.forEach(button => {
                    button.addEventListener("click", () => {
                        // Lấy ID màu
                        var takeColor = button.getAttribute("data-color");
                        if (selectedColor === takeColor) {
                            selectedColor = null;
                            button.classList.remove("selected");
                            resetSizeButtons();
                        }
                        else {
                            selectedColor = takeColor;
                            updateSizeOptions(selectedColor);
                            highlightSelected(button, colorOptions);
                        }
                        updatePriceAndQuantity();
                    });
                });
            }
        }
    })();
    //--------------------------------
    ImgTransfer.init();
    ChoosColorSize.init();
});
