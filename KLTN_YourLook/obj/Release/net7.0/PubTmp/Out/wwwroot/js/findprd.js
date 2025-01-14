//click tìm
document.getElementById("searchButton").addEventListener("click", function () {
    var keyword = document.getElementById("searchKeyword").value;
    window.location.href = `/Home/KeyWord?keyword=${encodeURIComponent(keyword)}`;
});
//nhấn enter
document.getElementById("searchKeyword").addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
        var keyword = document.getElementById("searchKeyword").value;
        window.location.href = `/Home/KeyWord?keyword=${encodeURIComponent(keyword)}`;
    }
})