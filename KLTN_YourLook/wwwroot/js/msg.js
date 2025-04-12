function showMess(msg, isSuccess) {
    // Tạo một div thông báo
    var toastt = document.createElement("div");
    toastt.className = `toastt ${isSuccess ? "success" : "error"}`;
    toastt.innerText = msg;

    // Thêm vào body
    document.body.appendChild(toastt);

    // Tự động ẩn sau 3 giây
    setTimeout(function () {
        toastt.style.opacity = 0; // Hiệu ứng mờ dần
        setTimeout(function () {
            toastt.remove();
        }, 500); // Đợi hiệu ứng mờ hoàn tất
    }, 1000);
}
//ẩn thoong báo sau 3s
setTimeout(() => {    
    document.querySelector(".boxmess").style.opacity = "0";
}, 3000);

