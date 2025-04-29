

$(document).ready(function () {
    function changecolorbtn() { //đổi màu nút nam nữ
        //$('.new_arrivals_title').click(function () {
        //    setTimeout(function () {
        //        initFixProductBorder();
        //    }, 500);

        //    $('.new_arrivals_title.active').removeClass('active');
        //    $(this).addClass('active');
        //});
        const btn = document.querySelectorAll(".new_arrivals_title");
        btn.forEach(function (a) {
            a.addEventListener('click', function () {
                setTimeout(function () {
                    initFixProductBorder();
                }, 500);
                btn.forEach(function (t) {
                    t.classList.remove('active');
                });
                this.classList.add('active');
            });
        });
    }
    //===============================================
    var SwichListProduct = (function () {
        //_________________
        function newprd() { //sản phẩm mới
            document.getElementById("prd-hot").style.display = "none";
            document.getElementById("prd-new").style.display = "block";
        }                            
        function hotprd() { //sản phẩm hot
            document.getElementById("prd-hot").style.display = "block";
            document.getElementById("prd-new").style.display = "none";
        }
        function SwichBtn() {
            document.getElementById("hotprd").addEventListener("click", hotprd);
            document.getElementById("newprd").addEventListener("click", newprd);
        }
        //__________________
        function menprd_page1() { //sản phẩm nam page 1
            document.getElementById("womenprd_page1").style.display = "none";  
            document.getElementById("menprd_page1").style.display = "block";
        }
        function womenprd_page1() { //sản phẩm nữ page 1
            document.getElementById("womenprd_page1").style.display = "block";
            document.getElementById("menprd_page1").style.display = "none";
        }
        function SwichBtn_page1() {
            document.getElementById("womenprdpage1").addEventListener("click", womenprd_page1);
            document.getElementById("menprdpage1").addEventListener("click", menprd_page1);

            changecolorbtn();
        }
        //__________________
        function menprd_page2() { //sản phẩm nam page 2
            document.getElementById("womenprd_page2").style.display = "none";
            document.getElementById("menprd_page2").style.display = "block";
        }
        function womenprd_page2() { //sản phẩm nữ page 2
            document.getElementById("womenprd_page2").style.display = "block";
            document.getElementById("menprd_page2").style.display = "none";
        }
        function SwichBtn_page2() {
            document.getElementById("womenprdpage2").addEventListener("click", womenprd_page2);
            document.getElementById("menprdpage2").addEventListener("click", menprd_page2);
        }
        //__________________
        function menprd_page3() { //sản phẩm nam page 3
            document.getElementById("womenprd_page3").style.display = "none";
            document.getElementById("menprd_page3").style.display = "block";
        }
        function womenprd_page3() { //sản phẩm nữ page 3
            document.getElementById("womenprd_page3").style.display = "block";
            document.getElementById("menprd_page3").style.display = "none";
        }
        function SwichBtn_page3() {
            document.getElementById("womenprdpage3").addEventListener("click", womenprd_page3);
            document.getElementById("menprdpage3").addEventListener("click", menprd_page3);
        }
        //__________________
        function menprd_page4() { //sản phẩm nam page 4
            document.getElementById("womenprd_page4").style.display = "none";
            document.getElementById("menprd_page4").style.display = "block";
        }
        function womenprd_page4() { //sản phẩm nữ page 4
            document.getElementById("womenprd_page4").style.display = "block";
            document.getElementById("menprd_page4").style.display = "none";
        }
        function SwichBtn_page4() {
            document.getElementById("womenprdpage4").addEventListener("click", womenprd_page4);
            document.getElementById("menprdpage4").addEventListener("click", menprd_page4);
        }
        return {
            init: function () {
                SwichBtn();
                SwichBtn_page1();
                SwichBtn_page2();
                SwichBtn_page3();
                SwichBtn_page4();
            }
        }
    })();
    //================================================
    var NextProductPage1 = (function () {
        const container = document.getElementById('productContainer');
        const itemsToShow = 5;
        const itemsToScroll = 2;
        let currentIndex = 0;

        function updateCarousel() {
            const itemWidth = container.children[0].offsetWidth;
            const offset = -(currentIndex * itemWidth);
            container.style.transform = `translateX(${offset}px)`;
        }
        function nextProducts() {
            currentIndex = Math.min(currentIndex + itemsToScroll, container.children.length - itemsToShow);
            updateCarousel();
        }
        function prevProducts() {
            currentIndex = Math.max(currentIndex - itemsToScroll, 0);
            updateCarousel();
        }
        window.addEventListener('resize', updateCarousel);
        function MoveBtn() {
            document.getElementById("prevProducts").addEventListener("click", prevProducts);
            document.getElementById("nextProducts").addEventListener("click", nextProducts);
        }
        return {
            init: function () {
                MoveBtn();
            }
        }
    })();
    //================================================
    var NextProductPage2 = (function () {
        const containerN = document.getElementById('productcontainer');
        const itemsToShowN = 5;
        const itemsToScrollN = 2;
        let currentIndexN = 0;

        function updateCarouselN() {
        	const itemWidthN = containerN.children[0].offsetWidth;
        	const offsetN = -(currentIndexN * itemWidthN);
        	containerN.style.transform = `translateX(${offsetN}px)`;
        }

        function nextProductsN() {
        	currentIndexN = Math.min(currentIndexN + itemsToScrollN, containerN.children.length - itemsToShowN);
        	updateCarouselN();
        }

        function prevProductsN() {
        	currentIndexN = Math.max(currentIndexN - itemsToScrollN, 0);
        	updateCarouselN();
        }

        window.addEventListener('resize', updateCarouselN);
        function MoveBtn() {
            document.getElementById("prevProductsN").addEventListener("click", prevProductsN);
            document.getElementById("nextProductsN").addEventListener("click", nextProductsN);
        }
        return {
            init: function () {
                MoveBtn();
            }
        }
    })();
    //__________________________________
    SwichListProduct.init();
    NextProductPage1.init();
    NextProductPage2.init();
});
//const containerfls = document.getElementById('prdcontainerfls');
//const itemsToShowfls = 5;
//const itemsToScrollfls = 2;
//let currentIndexfls = 0;

//function updateCarouselfls() {
//    const itemWidthfls = containerfls.children[0].offsetWidth;
//    const offsetfls = -(currentIndexfls * itemWidthfls);
//    containerfls.style.transform = `translateX(${offsetfls}px)`;
//}

//function nextProductfls() {
//    currentIndexfls = Math.min(currentIndexfls + itemsToScrollfls, containerfls.children.length - itemsToShowfls);
//    updateCarouselfls();
//}

//function prevProductfls() {
//    currentIndexfls = Math.max(currentIndexfls - itemsToScrollfls, 0);
//    updateCarouselfls();
//}

//window.addEventListener('resize', updateCarouselfls);