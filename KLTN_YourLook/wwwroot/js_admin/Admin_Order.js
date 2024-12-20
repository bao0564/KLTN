function applyFilter() {
    // Lấy giá trị các checkbox
    let odsuccess = document.getElementById("odsuccess").checked;
    let odreadly = document.getElementById("odreadly").checked;
    let odtranport = document.getElementById("odtranport").checked;
    let complete = document.getElementById("complete").checked;

    // Tạo URL với query string
    let url = `order?odsuccess=${odsuccess}&odreadly=${odreadly}&odtranport=${odtranport}&complete=${complete}`;

    // Điều hướng trang
    window.location.href = url;
}