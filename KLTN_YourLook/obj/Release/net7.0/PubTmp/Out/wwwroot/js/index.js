

$(document).ready(function () {
    //===============================================
    var SwichListProduct = (function () {
        function newprd() {
            document.getElementById("prd-hot").style.display = "none";
            document.getElementById("prd-new").style.display = "block";
        }                            
        function hotprd() {
            document.getElementById("prd-hot").style.display = "block";
            document.getElementById("prd-new").style.display = "none";
        }
        function SwichBtn() {
            document.getElementById("hotprd").addEventListener("click", hotprd);
            document.getElementById("newprd").addEventListener("click", newprd);
        }
        return {
            init: function () {
                SwichBtn();
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