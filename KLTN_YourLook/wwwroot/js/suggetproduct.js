$(document).ready(function () {

    //===============================================
    var OpenFormSearch = (function () {
        //_________________
        function open() { 
            document.getElementById("header_search").style.display = "none";
            document.getElementById("form_search_active").style.display = "block";
        }
        function close() { 
            document.getElementById("header_search").style.display = "block";
            document.getElementById("form_search_active").style.display = "none";
        }
        function SwichBtn() {
            document.getElementById("searchKeyword").addEventListener("click", open);
            document.getElementById("close_form_search").addEventListener("click", close);
        }

        return {
            init: function () {
                SwichBtn();  
            }
        };
    })();
    var SuggetSearch = (function () {
        var typingTimer;
        const sugget_place = document.getElementById('suggestions');
        function LoadSugget() {
            $("#searchKeyword-1").keyup(function () {
                clearTimeout(typingTimer);
                var keyword = $(this).val();

                if (keyword.length >= 1) {
                    sugget_place.style.display = 'block';
                    typingTimer = setTimeout(function () {
                        $.ajax({
                            url: '/home/suggetresult',
                            data: { keyword: keyword },
                            success: function (data) {
                                var suggestions = $("#suggestions_list");
                                //var product_lable = $("#suggestions");
                                suggestions.empty();

                                if (data.length > 0) {
                                    //product_lable.append(
                                    //    `<lable class="fw600">Sản Phẩm:</lable>`
                                    //);
                                    data.forEach(function (item) {
                                        suggestions.append(
                                            `<a href="/Home/ProductDetail?idsp=${item.idSp}">
                                                <div class="suggestion_item flcl gap">                                                
                                                    <img class="suggest-img" src="/img/${item.anhSp}"/>
                                                    <div class="suggest-item">${item.tenSp}</div>
                                                </div>
                                            </a>`
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
    OpenFormSearch.init();
    SuggetSearch.init();
});