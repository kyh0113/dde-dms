$(document).ready(function () {
    //themes, change CSS with JS
    //default theme(CSS) is cerulean, change it if needed
    var defaultTheme = 'cerulean';
    var msie = navigator.userAgent.match(/msie/i);
    $('.navbar-toggle').click(function (e) {
        e.preventDefault();
        $('.nav-sm').html($('.navbar-collapse').html());
        $('.sidebar-nav').toggleClass('active');
        $(this).toggleClass('active');
    });

    var $sidebarNav = $('.sidebar-nav');

    // Hide responsive navbar on clicking outside
    $(document).mouseup(function (e) {
        if (!$sidebarNav.is(e.target) // if the target of the click isn't the container...
            && $sidebarNav.has(e.target).length === 0
            && !$('.navbar-toggle').is(e.target)
            && $('.navbar-toggle').has(e.target).length === 0
            && $sidebarNav.hasClass('active')
            )// ... nor a descendant of the container
        {
            e.stopPropagation();
            $('.navbar-toggle').click();
        }
    });
    
    //highlight current / active link
    $('ul.main-menu li a').each(function () {
        if ($($(this))[0].href == String(window.location))
            $(this).parent().addClass('active');
    });


    //ajaxify menus
    $(document).on("click","a.ajax-link",function (e) {
    	e.preventDefault();
    	var target = $(e.target);
    	var menu_id = target[0].dataset.menuId;
    	var hierarchy = target[0].dataset.hierarchy;
    	var url = target[0].dataset.url;
    	if(isEmpty(menu_id)&&isEmpty(url)) return false;
    	var form = document.createElement("form");
    	var element = document.createElement("input");
    	
    	form.method = "post";
    	form.action = url;
    	
    	element.name = "menu_id";
    	element.value = menu_id;
    	element.type = "hidden";
    	
    	form.appendChild(element);
    	
    	element.name = "hierarchy";
    	element.value = hierarchy;
    	element.type = "hidden";
    	
    	form.appendChild(element);
    	
    	//20191023_khj for csrf
    	var csrf_element = document.createElement("input");
    	var csrfValue;
    	if(document.getElementById("_csrf")){
    		csrfValue = document.getElementById("_csrf").value;
    	}else{
    		csrfValue = "";
    	}
    	csrf_element.name  = "_csrf";
    	csrf_element.value = csrfValue;
    	csrf_element.type  = "hidden";
    	form.appendChild(csrf_element);
    	//20191023_khj for csrf
    	
    	document.body.appendChild(form);
    	
    	form.submit();
    	
    });

    $(document).on('click','.accordion > a',function (e) {
        e.preventDefault();
        var $ul = $(this).siblings('ul');
        var $li = $(this).parent();
        if ($ul.is(':visible')) $li.removeClass('active');
        else                    $li.addClass('active');
        $ul.slideToggle("fast");
    });

    $('.accordion li.active:first').parents('ul').slideDown("fast");


    //other things to do on document ready, separated for ajax calls
    docReady();
});


function docReady() {
    //prevent # links from moving to top
    $('a[href="#"][data-top!=true]').click(function (e) {
        e.preventDefault();
    });

    //notifications
    $('.noty').click(function (e) {
        e.preventDefault();
        var options = $.parseJSON($(this).attr('data-noty-options'));
        noty(options);
    });

    //tabs
    $('#myTab a:first').tab('show');
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });

    //tooltip
    $('[data-toggle="tooltip"]').tooltip();

    //popover
    $('[data-toggle="popover"]').popover();

    //datatable
    $('.btn-close').click(function (e) {
        e.preventDefault();
        $(this).parent().parent().parent().fadeOut();
    });
    $('.btn-minimize').click(function (e) {
        e.preventDefault();
        var $target = $(this).parent().parent().next('.box-content');
        if ($target.is(':visible')) $('i', $(this)).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
        else                       $('i', $(this)).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
        $target.slideToggle();
    });
    $('.btn-setting').click(function (e) {
        e.preventDefault();
        $('#myModal').modal('show');
    });

}



