
//chọn địa chỉ +Hinhf thuwcs Thanh toans
$(document).on('change', '.address-val', function () {
    $('.address-val').not(this).prop('checked', false);
    // Kiểm tra
    if (this.checked) {
        // Lấy dữ liệu
        var name = $(this).data('name');
        var phone = $(this).data('phone');
        var city = $(this).data('city');
        var district = $(this).data('district');
        var ward = $(this).data('ward');
        var address = $(this).data('address');

        // Gán dữ liệu 
        $('#TenKh').val(name);
        $('#Sdt').val(phone);
        $('#City').val(city);
        $('#District').val(district);
        $('#Ward').val(ward);
        $('#DiaChi').val(address);
    }
});
//chỉ chọn 1 hình thức thanh toán
$(document).on('change', '.pay-checked', function () {
    $('.pay-checked').not(this).prop('checked', false);
    if (this.checked) {
        var name = $(this).data('payname');
        var id = $(this).data('payid');
        
        $('#payid').text(id);
        $('#payname').text(name);
    }
});
//Api load danh sách tỉnh thành phố
$(document).ready(function () {
    $.get("https://provinces.open-api.vn/api/?depth=1", function (data) {
        data.forEach(function (item) {
            // Sử dụng data-code để lưu mã code, nhưng value là tên thành phố
            $('#City').append(`<option value="${item.name}" data-code="${item.code}">${item.name}</option>`);
        });
    });

    // Khi chọn thành phố, nạp danh sách quận/huyện
    $('#City').on('change', function () {
        var cityCode = $(this).find('option:selected').data('code'); // Lấy code của thành phố
        $('#District').empty().append('<option value="">Chọn Quận/Huyện</option>').prop('disabled', true);
        $('#Ward').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);

        if (cityCode) {
            // Truy vấn API dựa trên code của thành phố
            $.get(`https://provinces.open-api.vn/api/p/${cityCode}?depth=2`, function (data) {
                data.districts.forEach(function (district) {
                    // Sử dụng data-code để lưu mã code quận/huyện, nhưng value là tên
                    $('#District').append(`<option value="${district.name}" data-code="${district.code}">${district.name}</option>`);
                });
                $('#District').prop('disabled', false); // Mở khóa Quận/Huyện
            });
        }
    });

    // Khi chọn quận/huyện, nạp danh sách phường/xã
    $('#District').on('change', function () {
        var districtCode = $(this).find('option:selected').data('code'); // Lấy code của quận/huyện
        $('#Ward').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);

        if (districtCode) {
            // Truy vấn API dựa trên code của quận/huyện
            $.get(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`, function (data) {
                data.wards.forEach(function (ward) {
                    // Sử dụng data-code để lưu mã code phường/xã, nhưng value là tên
                    $('#Ward').append(`<option value="${ward.name}" data-code="${ward.code}">${ward.name}</option>`);
                });
                $('#Ward').prop('disabled', false); // Mở khóa Phường/Xã
            });
        }
    });
});