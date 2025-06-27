$(document).ready(function () {
    var originalText =( function () {
        function Originaltext() {
            document.getElementById('input1').addEventListener('input', function () {
                const originalText = this.value;
                const slug = removeVietnameseTones(originalText)
                    .toLowerCase()
                    .replace(/\s+/g, '')     // bỏ khoảng trắng
                    .replace(/[^a-z0-9]/g, ''); // bỏ ký tự đặc biệt

                document.getElementById('input2').value = slug;
            });
        }

        // Hàm xóa dấu tiếng Việt
        function removeVietnameseTones(str) {
            return str.normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '') // xóa dấu
                .replace(/đ/g, 'd')
                .replace(/Đ/g, 'D');
        }

        return {
            init: function () {
                Originaltext();
            }
        };
    })();
    originalText.init();
})