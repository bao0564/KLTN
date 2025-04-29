$(document).ready(function () {
    var SuggetSearch = (function () {
        var typingTimer;

        function LoadSugget() {
            $("#searchKeyword").keyup(function () {
                clearTimeout(typingTimer);
                var keyword = $(this).val();

                if (keyword.length > 1) {
                    typingTimer = setTimeout(function () {
                        $.ajax({
                            url: '/home/suggetresult',
                            data: { keyword: keyword },
                            success: function (data) {
                                var suggestions = $("#suggestions");
                                suggestions.empty();

                                if (data.length > 0) {
                                    data.forEach(function (item) {
                                        suggestions.append(
                                            `<div class="suggest-item" data-value="${item}">${item}</div>`
                                        );
                                    });
                                    suggestions.show();
                                } else {
                                    suggestions.hide();
                                }
                            },
                            error: function () {
                                $("#suggestions").hide();
                            }
                        });
                    }, 300); // Đợi 300ms sau mỗi lần gõ
                } else {
                    $("#suggestions").hide();
                }
            });

            // Click chọn gợi ý
            $(document).on("click", ".suggest-item", function () {
                var value = $(this).data("value");
                $("#searchKeyword").val(value);
                $("#suggestions").hide();
            });

            // Ẩn gợi ý khi click bên ngoài
            $(document).click(function (e) {
                if (!$(e.target).closest('#searchKeyword, #suggestions').length) {
                    $("#suggestions").hide();
                }
            });
        }

        return {
            init: function () {
                LoadSugget();
            }
        };
    })();

    SuggetSearch.init();
});