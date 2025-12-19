
function lnb() {
	var menu = $('#lnb a');
	$(document).on("click",'#lnb a',function(){
	//menu.on('click', function() {
		var $this = $(this);
		if($this.next('.subMenu').length > 0) {
			if($this.parent().hasClass('open')) {
				$this.next('.subMenu').slideUp(200)
				.parent().removeClass('open');
			} else {
				$this.next('.subMenu').slideDown(200)
				.parent().addClass('open')
				.siblings().removeClass('open')
				.find('.subMenu').slideUp(200)
				.find('li').removeClass('open');
			}
			return false;
		}
	});
}

function dropDown(obj) {
	var $this = $(obj);
	var list = $this.next('.list');
	var listBtn = list.find('a');

	list.slideToggle(200);
	listBtn.on('click', function(){
		var txt = $(this).html();
		$this.html(txt);
		list.slideUp(200);
	});
}

$("#termListView_btn").mouseleave(function(){
	console.log("focusout");
});