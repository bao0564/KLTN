/* JS Document */

/******************************

[Table of Contents]

1. Vars and Inits
2. Set Header
3. Init Menu
4. Init Favorite
5. Init Fix Product Border
6. Init Isotope Filtering
7. Init Price Slider
8. Init Checkboxes



******************************/

jQuery(document).ready(function($)
{
	"use strict";

	/* 

	1. Vars and Initsproduct-item

	*/

	var header = $('.header');
	var topNav = $('.top_nav')
	var mainSlider = $('.main_slider');
	var hamburger = $('.hamburger_container');
	var menu = $('.hamburger_menu');
	var menuActive = false;
	var hamburgerClose = $('.hamburger_close');
	var fsOverlay = $('.fs_menu_overlay');

	setHeader();

	$(window).on('resize', function()
	{
		initFixProductBorder();
		setHeader();
	});

	$(document).on('scroll', function()
	{
		setHeader();
	});

	initMenu();
	initFavorite();
	initFixProductBorder();
	initIsotopeFiltering();
	initPriceSlider();
	initCheckboxes();

	/* 

	2. Set Header

	*/

	function setHeader()
	{
		if(window.innerWidth < 992)
		{
			if($(window).scrollTop() > 100)
			{
				header.css({'top':"0"});
			}
			else
			{
				header.css({'top':"0"});
			}
		}
		else
		{
			if($(window).scrollTop() > 100)
			{
				header.css({'top':"-50px"});
			}
			else
			{
				header.css({'top':"0"});
			}
		}
		if(window.innerWidth > 991 && menuActive)
		{
			closeMenu();
		}
	}
	 

	//3. Init Menu

	

	function initMenu()
	{
		if(hamburger.length)
		{
			hamburger.on('click', function()
			{
				if(!menuActive)
				{
					openMenu();
				}
			});
		}

		if(fsOverlay.length)
		{
			fsOverlay.on('click', function()
			{
				if(menuActive)
				{
					closeMenu();
				}
			});
		}

		if(hamburgerClose.length)
		{
			hamburgerClose.on('click', function()
			{
				if(menuActive)
				{
					closeMenu();
				}
			});
		}

		if($('.menu_item').length)
		{
			var items = document.getElementsByClassName('menu_item');
			var i;

			for(i = 0; i < items.length; i++)
			{
				if(items[i].classList.contains("has-children"))
				{
					items[i].onclick = function()
					{
						this.classList.toggle("active");
						var panel = this.children[1];
					    if(panel.style.maxHeight)
					    {
					    	panel.style.maxHeight = null;
					    }
					    else
					    {
					    	panel.style.maxHeight = panel.scrollHeight + "px";
					    }
					}
				}	
			}
		}
	}

	function openMenu()
	{
		menu.addClass('active');
		// menu.css('right', "0");
		fsOverlay.css('pointer-events', "auto");
		menuActive = true;
	}

	function closeMenu()
	{
		menu.removeClass('active');
		fsOverlay.css('pointer-events', "none");
		menuActive = false;
	}

	/* 

	4. Init Favorite

	*/

    function initFavorite()
    {
    	if($('.favorite').length)
    	{
    		var favs = $('.favorite');

    		favs.each(function()
    		{
    			var fav = $(this);
    			var active = false;
    			if(fav.hasClass('active'))
    			{
    				active = true;
    			}

    			fav.on('click', function()
    			{
    				if(active)
    				{
    					fav.removeClass('active');
    					active = false;
    				}
    				else
    				{
    					fav.addClass('active');
    					active = true;
    				}
    			});
    		});
    	}
    }

    /* 

	5. Init Fix Product Border

	*/

    function initFixProductBorder()
    {
    	if($('.product_filter').length)
    	{
			var products = $('.product_filter:visible');
    		var wdth = window.innerWidth;

    		// reset border
    		products.each(function()
    		{
    			$(this).css('border-right', 'solid 1px #e9e9e9');
    		});

    		// if window width is 991px or less

    		if(wdth < 480)
			{
				for(var i = 0; i < products.length; i++)
				{
					var product = $(products[i]);
					product.css('border-right', 'none');
				}
			}

    		else if(wdth < 576)
			{
				if(products.length < 5)
				{
					var product = $(products[products.length - 1]);
					product.css('border-right', 'none');
				}
				for(var i = 1; i < products.length; i+=2)
				{
					var product = $(products[i]);
					product.css('border-right', 'none');
				}
			}

    		else if(wdth < 768)
			{
				if(products.length < 5)
				{
					var product = $(products[products.length - 1]);
					product.css('border-right', 'none');
				}
				for(var i = 2; i < products.length; i+=3)
				{
					var product = $(products[i]);
					product.css('border-right', 'none');
				}
			}

    		else if(wdth < 992)
			{
				if(products.length < 5)
				{
					var product = $(products[products.length - 1]);
					product.css('border-right', 'none');
				}
				for(var i = 2; i < products.length; i+=3)
				{
					var product = $(products[i]);
					product.css('border-right', 'none');
				}
			}

			//if window width is larger than 991px
			else
			{
				if(products.length < 5)
				{
					var product = $(products[products.length - 1]);
					product.css('border-right', 'none');
				}
				for(var i = 3; i < products.length; i+=4)
				{
					var product = $(products[i]);
					product.css('border-right', 'none');
				}
			}	
    	}
    }

    /* 

	6. Init Isotope Filtering

	*/

    function initIsotopeFiltering()
    {
    	var sortTypes = $('.type_sorting_btn');
    	var sortNums = $('.num_sorting_btn');
    	var sortTypesSelected = $('.sorting_type .item_sorting_btn is-checked span');
    	var filterButton = $('.filter_button');

    	if($('.product-grid').length)
		{
			//lọc giá sp
    		$('.product-grid').isotope({
    			itemSelector: '.product-item',
	            getSortData: {
	            	price: function(itemElement)
					{
						var priceEle = $(itemElement).find('.in_product_price').text();
	            		return parseFloat(priceEle);
	            	},
	            	name: '.product_name'
	            },
	            animationOptions: {
	                duration: 750,
	                easing: 'linear',
	                queue: false
	            }
	        });

    		// Short based on the value from the sorting_type dropdown
	        sortTypes.each(function()
	        {
	        	$(this).on('click', function()
	        	{
	        		$('.type_sorting_text').text($(this).text());
	        		var option = $(this).attr('data-isotope-option');
	        		option = JSON.parse( option );
    				$('.product-grid').isotope( option );
	        	});
	        });

	        // Show only a selected number of items
	        sortNums.each(function()
	        {
	        	$(this).on('click', function()
	        	{
	        		var numSortingText = $(this).text();
					var numFilter = ':nth-child(-n+' + numSortingText + ')';
	        		$('.num_sorting_text').text($(this).text());
    				$('.product-grid').isotope({filter: numFilter });
	        	});
	        });	

	        // Filter based on the price range slider
	        filterButton.on('click', function()
	        {
	        	$('.product-grid').isotope({
		            filter: function()
		            {
						var priceRange = $('#amount').val();
						var priceMin = parseFloat(priceRange.split('-')[0].replace('đ', ''));
						var priceMax = parseFloat(priceRange.split('-')[1].replace('đ', ''));
						var itemPrice = $(this).find('.in_product_price').clone().children().remove().end().text();

			        	return (itemPrice > priceMin) && (itemPrice < priceMax);
		            },
		            animationOptions: {
		                duration: 750,
		                easing: 'linear',
		                queue: false
		            }
		        });
			});
			

			//// Lọc sản phẩm theo màu sắc khi checkbox được chọn
			//$('.color-filter').on('change', function () {
			//	$('.color-filter').not(this).prop('checked', false);//chỉ cho chọn 1 loại màu
			//	var selectedColors = [];

			//	// Thu thập tất cả các màu được chọn
			//	$('.color-filter:checked').each(function () {
			//		var color = $(this).next('.box_color').find('p').text().toLowerCase().trim();
			//		selectedColors.push(color);
			//	});

			//	// Nếu không chọn màu nào, hiển thị tất cả sản phẩm
			//	if (selectedColors.length === 0) {
			//		$('.product-grid').isotope({ filter: '*' });
			//		return;
			//	}

			//	// Áp dụng bộ lọc Isotope
			//	$('.product-grid').isotope({
			//		filter: function () {
			//			var $itemColors = $(this).find('.in-color-item').map(function () {
			//				return $(this).text().toLowerCase().trim();
			//			}).get();

			//			// Kiểm tra nếu sản phẩm có chứa bất kỳ màu nào trong danh sách đã chọn
			//			return selectedColors.some(function (color) {
			//				return $itemColors.includes(color);
			//			});
			//		}
			//	});
			//});
			//$('.size-filter').on('change', function () {

			//	$('.size-filter').not(this).prop('checked', false);//chỉ cho chọn 1 loại size

			//	var selectedSizes = [];
			//	$('.size-filter:checked').each(function () {
			//		var size = $(this).siblings('p').text().toLowerCase().trim();
			//		selectedSizes.push(size);
			//	});
			//	if (selectedSizes.length === 0) {
			//		$('.product-grid').isotope({ filter: '*' });
			//		return;
			//	}
			//	$('.product-grid').isotope({
			//		filter: function () {
			//			var itemSizes = $(this).find('.in-size-item').map(function () {
			//				return $(this).text().toLowerCase().trim();
			//			}).get();
			//			return selectedSizes.some(function (size) {
			//				return itemSizes.includes(size);
			//			});
			//		}
			//	});
			//});
			//gộp 2 điều kiện lọc làm 1
			$('.color-filter').on('change', function () {
				$('.color-filter').not(this).prop('checked', false); // Chỉ chọn 1 màu
				filterProducts();
			});

			$('.size-filter').on('change', function () {
				$('.size-filter').not(this).prop('checked', false); // Chỉ chọn 1 size
				filterProducts();
			});
			//z`
			function filterProducts() {
				var selectedColor = $('.color-filter:checked').next('.box_color').find('p').text().toLowerCase().trim() || null;
				var selectedSize = $('.size-filter:checked').siblings('p').text().toLowerCase().trim() || null;

				$('.product-grid').isotope({
					filter: function () {
						var itemColors = $(this).find('.in-color-item').map(function () {
							return $(this).text().toLowerCase().trim();
						}).get();
						var itemSizes = $(this).find('.in-size-item').map(function () {
							return $(this).text().toLowerCase().trim();
						}).get();

						var colorMatch = selectedColor ? itemColors.includes(selectedColor) : true;//xem chọn chưa thì lấy chọn nếu ko trả về true (ko lọc đk đó)
						var sizeMatch = selectedSize ? itemSizes.includes(selectedSize) : true;

						// trả veef điều kiện đã chọn
						return colorMatch && sizeMatch;
					}
				});
			}

    	}
    }
	

	//7. Init Price Slider

	

    function initPriceSlider()
    {
		$( "#slider-range" ).slider(
		{
			range: true,
			min: 0,
			max: 1000000,
			values: [ 0, 500000 ],
			slide: function( event, ui )
			{
				$("#amount").val("đ" + ui.values[0] + " - đ" + ui.values[1]);
				$('#FromAmount').val(ui.values[0]);
				$('#ToAmount').val(ui.values[1]);
			}
			});

		$("#amount").val("đ" + $("#slider-range").slider("values", 0) + " - đ" + $("#slider-range").slider("values", 1));
    }

    /* 

	8. Init Checkboxes

	*/

    function initCheckboxes()
    {
    	if($('.checkboxes li').length)
    	{
    		var boxes = $('.checkboxes li');

    		boxes.each(function()
    		{
    			var box = $(this);

    			box.on('click', function()
    			{
    				if(box.hasClass('active'))
    				{
    					box.find('i').removeClass('fa-square');
    					box.find('i').addClass('fa-square-o');
    					box.toggleClass('active');
    				}
    				else
    				{
    					box.find('i').removeClass('fa-square-o');
    					box.find('i').addClass('fa-square');
    					box.toggleClass('active');
    				}
    				// box.toggleClass('active');
    			});
    		});

    		if($('.show_more').length)
    		{
    			var checkboxes = $('.checkboxes');

    			$('.show_more').on('click', function()
    			{
    				checkboxes.toggleClass('active');
    			});
    		}
    	};
    }
});