var map = L.map('map').setView([21.006558, 105.935715], 13); // Tọa độ của TP.HCM

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

// Thêm marker vào bản đồ
L.marker([21.006558, 105.935715]).addTo(map)
    .bindPopup('Số nhà 55 ngõ 62 Trâu Quỳ.')
    .openPopup();
