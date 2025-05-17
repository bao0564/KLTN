var chartInstance;

function loadChart(year) {
    $.ajax({
        url: '/admin/getrevenuechart?year=' + year,
        method: 'GET',
        success: function (data) {
            const ctx = document.getElementById('revenueChart').getContext('2d');

            if (chartInstance) {
                chartInstance.destroy(); // Xoá biểu đồ cũ nếu có
            }

            chartInstance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Doanh thu năm '+ year,
                        data: data.values,
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function (value) {
                                    return value.toLocaleString('vi-VN');
                                }
                            }
                        }
                    }
                }
            });
        }
    });
}

// Khi trang load, gọi với năm hiện tại
$(document).ready(function () {
    const currentYear = $('#yearSelect').val();
    loadChart(currentYear);

    $('#yearSelect').on('change', function () {
        const selectedYear = $(this).val();
        loadChart(selectedYear);
    });
});