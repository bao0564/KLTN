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