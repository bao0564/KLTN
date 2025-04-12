function goBack() {
    if (document.referrer) {
        window.location.href = document.referrer;
    } else {
        //window.location.href = "/danh-sach-san-pham"; // URL mặc định nếu không có trang trước
    }
}