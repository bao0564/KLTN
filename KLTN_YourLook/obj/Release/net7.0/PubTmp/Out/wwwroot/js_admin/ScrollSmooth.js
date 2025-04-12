
document.querySelector('a[href="#page_top"]').addEventListener('click', function (e) {
    e.preventDefault(); // chặn hành vi mặc định của a
    document.querySelector('#page_top').scrollIntoView({
        behavior: 'smooth', // Hiệu ứng trượt mượt
        block: 'start' // Đưa phần tử lên đầu màn hình
    });
});