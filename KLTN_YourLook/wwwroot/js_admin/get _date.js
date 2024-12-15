
    const currentDate = new Date();
    
    // Lấy các thành phần ngày, tháng, năm
    const day = String(currentDate.getDate()).padStart(2, '0');
    const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
    const year = currentDate.getFullYear();
    
    // Định dạng ngày theo 'dd/MM/yyyy'
    const formattedDate = `${day}/${month}/${year}`;
    
    // Hiển thị vào ô input
    document.getElementById('dateInput').value = formattedDate;