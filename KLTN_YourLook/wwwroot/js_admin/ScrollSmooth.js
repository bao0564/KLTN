
//document.querySelector('a[href="#page_top"]').addEventListener('click', function (e) {
//    e.preventDefault(); // chặn hành vi mặc định của a
//    document.querySelector('#page_top').scrollIntoView({
//        behavior: 'smooth', // Hiệu ứng trượt mượt
//        block: 'start' // Đưa phần tử lên đầu màn hình
//    });
//});

$(document).ready(function () {
    var listWrapper = (function () { //show các li conn
        function toggleList() {
            const wrapper = document.getElementById("listWrapper");
            wrapper.classList.toggle("open");
        }
        function ShowClick() {
            document.getElementById("Showclick").addEventListener("click",toggleList)
        }
        function toggleList2() {
            const wrapper = document.getElementById("listWrapper2");
            wrapper.classList.toggle("open");
        }
        function ShowClick2() {
            document.getElementById("Showclick2").addEventListener("click", toggleList2)
        }
        return {
            init: function () {
                ShowClick();
                ShowClick2();
            }
        };
    })();
    listWrapper.init();
})