document.getElementById("searchButton-2").addEventListener("click", function () {
    var keyword = document.getElementById("searchKeyword-2").value;
    window.location.href = `/Home/KeyWord?keyword=${encodeURIComponent(keyword)}`;
});
document.getElementById("searchKeyword-2").addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
        var keyword = document.getElementById("searchKeyword-2").value;
        window.location.href = `/Home/KeyWord?keyword=${encodeURIComponent(keyword)}`;
    }
})