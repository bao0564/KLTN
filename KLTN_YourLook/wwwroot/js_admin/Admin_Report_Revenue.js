$(document).ready(function () {    
    var report_revenue_chart = (function () {
        var chartInstance;
        function getQueryUrl(name) {// lấy date,todate từ url
            const url = new URLSearchParams(window.location.search);
            return url.get(name);
        }
        function load_reportChart() {
            //var date = $('#date_revenue').val();
            //var todate = $('#todate_revenue').val();
            const date = getQueryUrl('date');
            const todate = getQueryUrl('todate');
            $.ajax({
                //url: '/admin/api_report_revenue?date=2025-06-04&todate=2025-07-04',
                url: '/admin/api_report_revenue?date=' + date + '&todate=' + todate,
                method: 'GET',
                success: function (data) {
                    const ctx = document.getElementById('Report_Revenue_Chart').getContext('2d');

                    //console.log("Dữ liệu từ API:", data);
                    //console.log("Từ ngày:", date);
                    //console.log("Đến ngày:", todate);
                    if (chartInstance) {
                        chartInstance.destroy(); // Xoá biểu đồ cũ nếu có
                    }

                    chartInstance = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: [
                                {
                                    label: 'Tổng đơn hàng',
                                    data: data.tongdonhang,
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                    fill: false,
                                    tension: 0.3
                                },
                                {
                                    label: 'Tổng Sản phẩm bán ra',
                                    data: data.tongsanpham,
                                    borderColor: 'rgba(255, 99, 132, 1)',
                                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                    fill: false,
                                    tension: 0.3
                                },
                                {
                                    label: 'Tổng tiền thanh toán',
                                    data: data.tongtienthanhtoan,
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                                    fill: false,
                                    tension: 0.3
                                },
                                {
                                    label: 'Giảm giá từ voucher',
                                    data: data.vouchergiam,
                                    borderColor: 'rgba(153, 102, 255, 1)',
                                    backgroundColor: 'rgba(153, 102, 255, 0.5)',
                                    fill: false,
                                    tension: 0.3
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function (value) {
                                            return value.toLocaleString() + ' ₫';
                                        }
                                    }
                                }
                            },
                            plugins: {
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            return context.dataset.label + ': ' + context.formattedValue + ' ₫';
                                        }
                                    }
                                }
                            }
                        }
                    });
                }
            }); 
        }
        return {
            init: function () {
                load_reportChart();
                getQueryUrl();
            }
        }
    })();

    //xuất excel
    var ExcelExport_Revenue = (function () {
        function bindExcelExport_Revenue() {
            //gán sự kiện click xuất excel list product
            document.getElementById("exportRevenueProductExcel").addEventListener('click', function () {
                let currentUrlParams = new URLSearchParams(window.location.search); //lấy chính đường dẫn đang có
                fetch("/admin/revenue_export_excel?" + currentUrlParams.toString())
                    .then(response => response.blob())
                    .then(blob => {
                        var today = new Date();
                        var day = String(today.getDate()).padStart(2, '0');
                        var month = String(today.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
                        var year = today.getFullYear();
                        var formattedDate = `${day}/${month}/${year}`;

                        const url = window.URL.createObjectURL(blob);
                        const a = document.createElement("a");
                        a.href = url;
                        a.download = "Doanh thu cửa hàng xuất ngày" + formattedDate + ".xlsx"; // tên file
                        document.body.appendChild(a);
                        a.click(); // Hiển thị hộp thoại "Save As"
                        document.body.removeChild(a);
                    })
                    .catch(error => console.error("lỗi tải file", error));
            });
        }
        return {
            init: function () {
                bindExcelExport_Revenue();
            }
        };
    })();
    //---------------------------------
    report_revenue_chart.init();
    ExcelExport_Revenue.init();
});
