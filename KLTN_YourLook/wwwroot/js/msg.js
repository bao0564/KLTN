function showMess(msg, isSuccess) {
    // Tạo một div thông báo
    var toast = document.createElement("div");
    toast.className = `toast ${isSuccess ? "success" : "error"}`;
    toast.innerText = msg;

    // Thêm vào body
    document.body.appendChild(toast);

    // Tự động ẩn sau 3 giây
    setTimeout(function () {
        toast.style.opacity = 0; // Hiệu ứng mờ dần
        setTimeout(function () {
            toast.remove();
        }, 500); // Đợi hiệu ứng mờ hoàn tất
    }, 1000);
}
