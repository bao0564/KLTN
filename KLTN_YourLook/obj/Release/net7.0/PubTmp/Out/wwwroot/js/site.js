let lastScrollTop = 0;
const header = document.getElementById('headerr');

window.addEventListener('scroll', function () {
    const currentScroll = window.pageYOffset || document.documentElement.scrollTop;

    if (currentScroll > lastScrollTop) {
        // ẩn headerr
        header.style.top = '-200px'; 
    } else {
        // hiện header
        header.style.top = '0';
    }

    lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
});

