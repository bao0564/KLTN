$(document).ready(function () {    
    // Thêm vào giỏ hàng
    $('body').on('click', '.btnAddToCart', function (e) {
        e.preventDefault();
        var idsp = $(this).data('idsp');
        var quantity = $('#quantity_value').val();
        if (quantity != '') {
            quantity = parseInt(quantity);
        }
        // size/color
        var selectedSize = $('.size-option.selected').data('size');
        var selectedColor = $('.color-option.selected').data('color');

        if (!selectedSize || !selectedColor) {
            showMess("Vui lòng chọn size và màu sắc",false);
            return;
        }
        $.ajax({
            url: '/shoppingcart/addtocart',
            type: 'POST',
            data: { idsp: idsp, quantity: quantity, sizeid: selectedSize, colorid: selectedColor },
            success: function (rs) {
                if (rs.success) {
                    showMess(rs.msg, true);
                    //updateCartCount();
                } else {
                    showMess("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.", false);
                }
            }
        });
        return false; // Đảm bảo không có sự kiện khác thực thi
    });
    // Sự kiện tăng số lượng
    $(document).off('click', '.plus-cart').on('click', '.plus-cart', function () {
        var quantityElement = $(this).siblings('.quantity_value-cart');
        var newquantity = parseInt(quantityElement.text()) + 1;
        var newidsp = $(this).data('idsp');
        var newcolorid = $(this).data('colorid');
        var newsizeid = $(this).data('sizeid');
        quantityElement.text(newquantity);
        updatePrice($(this), newquantity);
        calculateTotal();
        updateProductQuantity(newidsp, newcolorid, newsizeid, newquantity); // Cập nhật số lượng trong giỏ hàng
    });

    // Sự kiện giảm số lượng
    $(document).off('click', '.minus-cart').on('click', '.minus-cart', function () {
        var quantityElement = $(this).siblings('.quantity_value-cart');
        var newquantity = parseInt(quantityElement.text()) - 1;
        var newidsp = $(this).data('idsp');
        var newcolorid = $(this).data('colorid');
        var newsizeid = $(this).data('sizeid');
        calculateTotal();
        if (newquantity <= 0) {
            var userConfirmed = confirm("Bạn muốn bỏ sản phẩm này ra khỏi giỏ hàng?");
            if (userConfirmed) {
                $('#sp-' + newidsp).remove();
                updateProductQuantity(newidsp, newcolorid, newsizeid, 0); // Xóa khỏi giỏ hàng
                calculateTotal();
                return;
            } else {
                newquantity = 1; // Giữ nguyên số lượng là 1 nếu không xóa
            }
        }
        quantityElement.text(newquantity);
        updatePrice($(this), newquantity);
        updateProductQuantity(newidsp, newcolorid, newsizeid, newquantity); // Cập nhật số lượng trong giỏ hàng
    });
    // Cập nhật giá tiền
    function updatePrice(element, newquantity) {
        var priceElement = element.closest('.cart-infor').find('.product_price');
        var unitPrice = parseFloat(priceElement.data('price'));
        var newPrice = unitPrice * newquantity;
        priceElement.text(newPrice.toLocaleString() + ' VND');
    }
    //Cập nhật số lượng sản phẩm trong giỏ hàng
    function updateProductQuantity(uidsp, ucolorid, usizeid, uquantity) {
        $.ajax({
            url: '/shoppingcart/updateproductincart',
            type: 'POST',
            data: { idsp: uidsp, colorid: ucolorid, sizeid: usizeid, quantity: uquantity },
            success: function (response) {
                if (response.success) {
                    showMess(response.msg, true);
                }
                else {
                    showMess(response.msg, false);
                }
            },
            error: function () {
                showMess('cập nhật thất bại hãy thử lại', false);  // Kiểm tra nếu có lỗi
            }
        });
    }

    // Xóa sản phẩm
    $('body').off('click', '.deletebtn').on('click', '.deletebtn', function (e) {
        e.preventDefault();
        var didsp = $(this).data('idsp');
        var dcolorid = $(this).data('colorid');
        var dsizeid = $(this).data('sizeid');
        var msg = confirm('Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng ?');
        if (msg == true) {
            $.ajax({
                url: '/ShoppingCart/Delete',
                type: 'POST',
                data: { idsp: didsp, colorid: dcolorid, sizeid: dsizeid },
                success: function (rs) {
                    if (rs.success) {
                        $('#sp-' + didsp).remove();
                        calculateTotal();
                        //location.reload();
                    }
                }
            });
        }
    });
    // Đưa sản phẩm được chọn,thông tin khách hàng vào trang thanh toán
    $('.pay-btn').off('click').on('click', function (e) {
        e.preventDefault();
        //lấy thông tin các sản phẩm được chọn
        var selectedProduct = [];
        $('.cart-checkbox:checked').each(function () {
            var cidsp = $(this).data('idsp');
            var cmasp = $(this).data('masp');
            var cname = $(this).data('name');
            var cimg = $(this).data('img');
            var ccolorid = $(this).data('colorid');
            var cnamecolor = $(this).data('color');
            var csizeid = $(this).data('sizeid');
            var cnamesize = $(this).data('size');
            var cprice = $(this).data('price');
            var cquantity = $(this).data('quantity');
            var ctotal = $(this).data('total');
            selectedProduct.push({
                IdSp: cidsp, MaSp: cmasp, TenSp: cname, AnhSp: cimg,
                ColorId: ccolorid, NameColor: cnamecolor,
                SizeId: csizeid, NameSize: cnamesize,
                GiaLoai: cprice, ProductQuantity: cquantity, Total: ctotal
            });
        });
        if (selectedProduct.length === 0) {
            showMess('Vui lòng chọn một sản phẩm để thanh toán',false);
            return;
        }
        //lấy thông tin địa chỉ được điền           
        var addressInfo = {
            TenKh: $('#TenKh').val(),
            Sdt: $('#Sdt').val(),
            City: $('#City').val(),
            District: $('#District').val(),
            Ward: $('#Ward').val(),
            DiaChi: $('#DiaChi').val(),
            GhiChu: $('#GhiChu').val()
        }; 
        for (var key in addressInfo) {
            if (addressInfo[key] === '' || addressInfo[key] === null) {
                showMess(key + ' không được để trống',false);
                return;
            }
        }
        //lấy thông tin thanh toán đc chọn
        var selectedPayment = $('.pay-checked:checked');
        if (selectedPayment.length === 0) {
            showMess("Vui lòng chọn phương thức thanh toán.",false);
            return;
        }
        var paymentInfo = {
            PaymentId : selectedPayment.data('payid'),
            PayName: selectedPayment.data('payname'),
            Icon:selectedPayment.data('payicon'),
            Ship: 0//chưa tính free trc:))
        }
        //lấy thoongt in voucher đc chọn
        var selectedVoucher = $('.voucher-checked:checked');
        if (selectedVoucher.length >0) {
            var voucherInfo = {
                IdVoucher:selectedVoucher.data('vcid'),
                MaVoucher: selectedVoucher.data('mavc'),
                ValueVoucher : selectedVoucher.data('vcvalue')
            }
        }
        else {
            var voucherInfo = {
                MaVoucher:"",
                GiamGia :0
            }
        }
        //gộp các thông tin vaod chung 1 biến (CheckoutRequest)
        var data = {
            selectedProducts: selectedProduct,
            selectedInfors: addressInfo,
            selectedPayments: paymentInfo,
            selectedVouchers:voucherInfo
        };
        $.ajax({
            url: '/shoppingcart/checkout',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                window.location.href = '/shoppingcart/checkoutorder';
            }
        });
    });
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


    // Tính tổng tiền ban đầu khi tải trang
    calculateTotal();
});
