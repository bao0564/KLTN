 //di chuyển ad đầu trang
 const sliderImg = document.querySelector(".img-ad");
 let count = 0;
 function nextSlideImg() {
   count++;
   if (count >= sliderImg.children.length) {
     count = 0;
   }
   updateSliderImg();
 }
 function backSlideImg() {
   count--;
   if (count < 0) {
     count = sliderImg.children.length - 1;
   }
   updateSliderImg();
 }
 function updateSliderImg() {
   const translateValue = -count * 100 + "%";
   sliderImg.style.transform = "translateX(" + translateValue + ")";
 }
 function autoSlideImg() {
   nextSlideImg();
 }
 document.addEventListener("DOMContentLoaded", () => {
   updateSliderImg();
   setInterval(autoSlideImg, 6000); // tự động chạy sau 6s
 });
 document.addEventListener("DOMContentLoaded", updateSliderImg); // Initial position
 document.querySelector(".next").addEventListener("click", nextSlideImg);
document.querySelector(".back").addEventListener("click", backSlideImg);


