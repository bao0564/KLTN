const containerfls = document.getElementById('prdcontainerfls');
const itemsToShowfls = 5;
const itemsToScrollfls = 2;
let currentIndexfls = 0;

function updateCarouselfls() {
	const itemWidthfls = containerfls.children[0].offsetWidth;
	const offsetfls = -(currentIndexfls * itemWidthfls);
	containerfls.style.transform = `translateX(${offsetfls}px)`;
}

function nextProductfls() {
	currentIndexfls = Math.min(currentIndexfls + itemsToScrollfls, containerfls.children.length - itemsToShowfls);
	updateCarouselfls();
}

function prevProductfls() {
	currentIndexfls = Math.max(currentIndexfls - itemsToScrollfls, 0);
	updateCarouselfls();
}

window.addEventListener('resize', updateCarouselfls);