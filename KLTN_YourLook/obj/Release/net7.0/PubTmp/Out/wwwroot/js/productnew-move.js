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