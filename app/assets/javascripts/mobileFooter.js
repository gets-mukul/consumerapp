// var isFixed = true;

// function checkOffset() {

// 	if ($('.list_btn_dark.sticky-footer').length) {
// 		if(isFixed && ($('.list_btn_dark.sticky-footer').offset().top + $('.list_btn_dark.sticky-footer').height() >= $('#fixed-footer').offset().top)) {
// 			$('.list_btn_dark.sticky-footer').css('position', 'relative');
// 			isFixed = false;
// 		}

// 		if(!isFixed && $(document).scrollTop() + window.innerHeight < $('#fixed-footer').offset().top) {
// 			$('.list_btn_dark.sticky-footer').css('position', 'fixed'); // restore when you scroll up
// 			isFixed = true;
// 		}
// 	}

// }


// $(document).scroll(function() {
// 	checkOffset();
// });

// $(document).on('touchmove', function(event) {
//     checkOffset();
// });

// $(function() {
// 	checkOffset();
// });
