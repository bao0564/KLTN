$(document).ready(function () {    
    //===================================================
    var ShoppingCart = (function () {

        // Cập nhật giá tiền, mỗi sp có một .product_price riêng biệt,element là để đảm bảo cập nhật đúng giá của sản phẩm đó.
        function updatePrice(element, newquantity) {
            var priceElement = element.closest('.cart-infor').find('.product_price');
            var unitPrice = parseFloat(priceElement.data('price'));
            var newPrice = unitPrice * newquantity;
            priceElement.text(newPrice.toLocaleString() + ' VND');
        };

        // Tính tổng tiền
        function calculateTotal() {
            var total = 0;
            var discount = 0;
            var finaltotal = 0;
            var ship = 0;//chưa tính free trc:))
            
            $('.cart-checkbox:checked').each(function () {//tổng tiền sản phẩm đc chọn
                var price = parseFloat($(this).data('price'));
                var quantity = parseInt($(this).closest('.cart-container').find('.quantity_value-cart').text());
                total += price * quantity;
                ship = 0;
            });
            $('#ship').text(ship.toLocaleString() + 'VND');
            $('#TongTien').text(total.toLocaleString() + ' VND');
            
            $('.voucher-checked:checked').each(function () {// Tính tiền giảm giá theo voucher được chọn
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
        //Cập nhật số lượng sản phẩm trong giỏ hàng
        function updateProductQuantity(uidsp, ucolorid, usizeid, uquantity) {
            $.ajax({
                url: '/shoppingcart/updateproductincart',
                type: 'POST',
                data: { idsp: uidsp, colorid: ucolorid, sizeid: usizeid, quantity: uquantity },
                success: function (response) {
                    if (response.success) {
                        //showMess(response.msg, true);
                    }
                    else {
                        //showMess(response.msg, false);
                    }
                },
                error: function () {
                    showMess('cập nhật thất bại hãy thử lại', false);  // Kiểm tra nếu có lỗi
                }
            });
        };

        // Sự kiện tăng số lượng
        $(document).off('click', '.plus-cart').on('click', '.plus-cart', function () {
            var newidsp = $(this).data('idsp');
            var newcolorid = $(this).data('colorid');
            var newsizeid = $(this).data('sizeid');
            var quantityElement = $(this).siblings('.quantity_value-cart');

            var newquantity = parseInt(quantityElement.text()) + 1;
            quantityElement.text(newquantity);
            // Cập nhật data-quantity
            $(this).closest('.data_checkbox').find('.cart-checkbox').data('data-quantity', newquantity);

            updatePrice($(this), newquantity);//cập nhật giá từng sp
            updateProductQuantity(newidsp, newcolorid, newsizeid, newquantity); // Cập nhật số lượng trong csdl
            calculateTotal();//tính giá sp chọn
        });

        // Sự kiện giảm số lượng
        $(document).off('click', '.minus-cart').on('click', '.minus-cart', function () {
            var quantityElement = $(this).siblings('.quantity_value-cart');
            var newquantity = parseInt(quantityElement.text()) - 1;
            var newidsp = $(this).data('idsp');
            var newcolorid = $(this).data('colorid');
            var newsizeid = $(this).data('sizeid');
            if (newquantity <= 0) {
                var userConfirmed = confirm("Bạn muốn bỏ sản phẩm này ra khỏi giỏ hàng?");
                if (userConfirmed) {
                    $('#sp-' + newidsp).remove();
                    updateProductQuantity(newidsp, newcolorid, newsizeid, 0); // Xóa khỏi giỏ hàng
                    calculateTotal();
                    return;
                } else {
                    newquantity = 1; //đặt số lượng là 1
                    // Cập nhật data-quantity
                    $(this).closest('.data_checkbox').find('.cart-checkbox').data('quantity', newquantity);
                }
            } else {
                quantityElement.text(newquantity);
                // Cập nhật data-quantity
                $(this).closest('.data_checkbox').find('.cart-checkbox').data('quantity', newquantity);

                updatePrice($(this), newquantity);
                updateProductQuantity(newidsp, newcolorid, newsizeid, newquantity);
                calculateTotal();
            }
            calculateTotal();
        });

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
                        } else {
                            showMess(response.msg || 'Xóa sản phẩm thất bại!', false);
                        }
                    },
                    error: function (error) {
                        console.error('Lỗi khi xóa sản phẩm:', error);
                        showMess('Xóa sản phẩm thất bại!',false);
                    }
                });
            }
        });

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

        return {
            init: function () {
                calculateTotal();
            }
        }
    })();
    var CheckOrder = (function () {
        function orderDetail() {
            // Đưa sản phẩm được chọn,thông tin khách hàng vào trang thanh toán
            $('.pay-btn').off('click').on('click', function (e) {
                e.preventDefault();
                //lấy thông tin các sản phẩm được chọn
                var selectedProduct = [];
                $('.cart-checkbox:checked').each(function () {
                    //var quantity = parseInt($(this).closest('.cart-container').find('.quantity_value-cart').text());

                    var cidsp = $(this).data('idsp');
                    var cmasp = $(this).data('masp');
                    var cname = $(this).data('name');
                    var cimg = $(this).data('img');
                    var ccolorid = $(this).data('colorid');
                    var cnamecolor = $(this).data('color');
                    var csizeid = $(this).data('sizeid');
                    var cnamesize = $(this).data('size');
                    var cprice = $(this).data('price');
                    var cquantity = parseInt($(this).closest('.cart-container').find('.quantity_value-cart').text());
                    var ctotal = cprice * cquantity;
                    selectedProduct.push({
                        IdSp: cidsp, MaSp: cmasp, TenSp: cname, AnhSp: cimg,
                        ColorId: ccolorid, NameColor: cnamecolor,
                        SizeId: csizeid, NameSize: cnamesize,
                        GiaLoai: cprice, ProductQuantity: cquantity, Total: ctotal
                    });
                });
                if (selectedProduct.length === 0) {
                    showMess('Vui lòng chọn một sản phẩm để thanh toán', false);
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
                        showMess('các mục thông tin địa chỉ không được để trống', false);
                        return;
                    }
                }
                //lấy thông tin thanh toán đc chọn
                var selectedPayment = $('.pay-checked:checked');
                if (selectedPayment.length === 0) {
                    showMess("Vui lòng chọn phương thức thanh toán.", false);
                    return;
                }
                var paymentInfo = {
                    PaymentId: selectedPayment.data('payid'),
                    PayName: selectedPayment.data('payname'),
                    Icon: selectedPayment.data('payicon'),
                    Ship: 0//chưa tính free trc:))
                }
                //lấy thoongt in voucher đc chọn
                var selectedVoucher = $('.voucher-checked:checked');
                if (selectedVoucher.length > 0) {
                    var voucherInfo = {
                        IdVoucher: selectedVoucher.data('vcid'),
                        MaVoucher: selectedVoucher.data('mavc'),
                        ValueVoucher: selectedVoucher.data('vcvalue')
                    }
                }
                else {
                    var voucherInfo = {
                        MaVoucher: "",
                        GiamGia: 0
                    }
                }
                //gộp các thông tin vaod chung 1 biến (CheckoutRequest)
                var data = {
                    selectedProducts: selectedProduct,
                    selectedInfors: addressInfo,
                    selectedPayments: paymentInfo,
                    selectedVouchers: voucherInfo
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
        }
        return {
            init: function () {
                orderDetail();
            }
        }
    })();
    //___________________________________
    ShoppingCart.init();
    CheckOrder.init();
});   
        