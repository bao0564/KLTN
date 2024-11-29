$(document).ready(function () {    
    // Thêm vào giỏ hàng
    $('body').on('click', '.btnAddToCart', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        var quantity = 1;
        var tQuantity = $('#quantity_value').val();
        if (tQuantity != '') {
            quantity = parseInt(tQuantity);
        }
        // size/color
        var selectedSize = $('.size-option.selected').data('size');
        var selectedColor = $('.color-option.selected').data('color');

        if (!selectedSize || !selectedColor) {
            alert("Vui lòng chọn size và màu sắc");
            return;
        }
        $.ajax({
            url: '/shoppingcart/addtocart',
            type: 'POST',
            data: { masp: id, quantity: quantity, sizeid: selectedSize, colorid: selectedColor },
            success: function (rs) {
                if (rs.success) {
                    alert(rs.msg);
                    updateCartCount();
                } else {
                    alert("Thêm sản phẩm không thành công");
                }
            }
        });
    });
    // Đưa sản phẩm được chọn,thông tin khách hàng vào trang thanh toán
    $('.pay-btn').off('click').on('click', function (e) {
        e.preventDefault();
        var selectedProducts = [];
        $('.cart-checkbox:checked').each(function () {
            var id = $(this).data('id');
            var sizeid = $(this).data('sizeid');
            var colorid = $(this).data('colorid');
            var quantityElement = $(this).closest('.cart-container').find('.quantity_value-cart');
            var quantity = parseInt(quantityElement.text());
            selectedProducts.push({ ProductId: id, ProductQuantity: quantity, ColorId: colorid, SizeId :sizeid});
        });
        if (selectedProducts.length === 0) {
            alert('Vui lòng chọn một sản phảm để thanh toán');
            return;
        }
        var selectedAdress = $('.address-val:checked');
        if (selectedAdress.length === 0) {
            alert('Địa chỉ không được để trống');
            return;
        }
        var orderInfo = {
            TenKh: $('#TenKh').val(),
            Sdt: $('#Sdt').val(),
            City: $('#City').val(),
            District: $('#District').val(),
            Ward: $('#Ward').val(),
            DiaChi: $('#DiaChi').val(),
            GhiChu: $('#GhiChu').val(),
            Ship: 20000.0
        }; 
        var selectedPayment = $('.pay-checked:checked');
        if (selectedPayment.length === 0) {
            alert("Vui lòng chọn phương thức thanh toán.");
            return;
        }
        orderInfo.PaymentId = $('#payid').text();
        orderInfo.payname = $('#payname').text();
        var selectedVoucher = $('.voucher-checked:checked');
        if (selectedVoucher.length >0) {
            orderInfo.GiamGia = selectedVoucher.first().data('vcvalue');
        }
        else {
            orderInfo.GiamGia = 0; 
        }
        var data = {
            selectedProducts: selectedProducts,
            selectInfors: orderInfo
        };
        $.ajax({
            url: '/shoppingcart/checkout',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                window.location.href = '/shoppingcart/order';
            }
        });
    });
    // Xóa sản phẩm
    $('body').off('click', '.deletebtn').on('click', '.deletebtn', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        var msg = confirm('Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng ?');
        if (msg == true) {
            $.ajax({
                url: '/ShoppingCart/Delete',
                type: 'POST',
                data: { id: id },
                success: function (rs) {
                    if (rs.success) {
                        $('#sp-' + id).remove();
                        calculateTotal();
                    }
                }
            });
        }
    });
    //Cập nhật số lượng sản phẩm trong giỏ hàng
    function updateCartCount() {
        $.ajax({
            url: '/shoppingcart/ViewProductInCart',
            type: 'GET',
            success: function (data) {
                console.log(data); 
                $('#prdcart-count').html(data);
                /*$('#prdcart-count').html($(data).find('#prdcart-count').html());*/
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);  // Kiểm tra nếu có lỗi
            }
        });
    }
    // Tính tổng tiền
    function calculateTotal() {
        var total = 0;
        var discount = 0;
        var finaltotal = 0;
        var ship = 0;
        //tổng tiền sản phẩm đc chọn
        $('.cart-checkbox:checked').each(function () {            
            var price = parseFloat($(this).data('price'));
            var quantity = parseInt($(this).closest('.cart-container').find('.quantity_value-cart').text());
            total += price * quantity;
            ship = 20000.0;
        });
        $('#ship').text(ship.toLocaleString() + 'VND');
        $('#TongTien').text(total.toLocaleString() + ' VND');
        // Tính tiền giảm giá theo voucher được chọn
        $('.voucher-checked:checked').each(function () {
            var selectedDiscountValue = parseInt($(this).data('vcvalue'));
            if (selectedDiscountValue > 0) {
                discount = - (total * selectedDiscountValue) / 100;
            }
        });        

        // Hiển thị giảm giá
        $('#GiamGia').text(discount.toLocaleString() + ' VND');

        // Tính tổng tiền cuối cùng
        finaltotal = total + discount + ship;
        $('#finaltotal').text(finaltotal.toLocaleString() + ' VND');

    }
     //Hàm cập nhật số lượng sản phẩm trong giỏ hàng
    function Update(id, quantity) {
        $.ajax({
            url: '/ShoppingCart/Update',
            type: 'POST',
            data: { id: id, quantity: quantity },
            success: function (rs) {
                if (!rs.success) {
                    alert("Cập nhật số lượng không thành công");
                }
            }
        });
    }

    // Sự kiện thay đổi checkbox thì giá trị sẽ được tính lại(chọn sp /voucher)
    $(document).off('change', '.cart-checkbox').on('change', '.cart-checkbox', function () {
        calculateTotal();
    });   
    $(document).on('change', '.voucher-checked', function () {
        if (this.checked) {
            $('.voucher-checked').not(this).prop('checked', false);
            calculateTotal();
        } else {
            calculateTotal();
        }
    });
    // Sự kiện tăng số lượng
    $(document).off('click', '.plus-cart').on('click', '.plus-cart', function () {
        var quantityElement = $(this).siblings('.quantity_value-cart');
        var newQuantity = parseInt(quantityElement.text()) + 1;
        var id = $(this).data('id');
        quantityElement.text(newQuantity);
        updatePrice($(this), newQuantity);
        calculateTotal();
        Update(id, newQuantity); // Cập nhật số lượng trong giỏ hàng
    });

    // Sự kiện giảm số lượng
    $(document).off('click', '.minus-cart').on('click', '.minus-cart', function () {
        var quantityElement = $(this).siblings('.quantity_value-cart');
        var newQuantity = parseInt(quantityElement.text()) - 1;
        if (newQuantity > 0) {
            var id = $(this).data('id');
            quantityElement.text(newQuantity);
            updatePrice($(this), newQuantity);
            calculateTotal();
            Update(id, newQuantity); // Cập nhật số lượng trong giỏ hàng
        }
    });
    // Cập nhật giá tiền
    function updatePrice(element, newquantity) {
        var priceElement = element.closest('.cart-infor').find('.product_price');
        var unitPrice = parseFloat(priceElement.data('price'));
        var newPrice = unitPrice * newquantity;
        priceElement.text(newPrice.toLocaleString() + ' VND');
    }


    // Tính tổng tiền ban đầu khi tải trang
    calculateTotal();
});
