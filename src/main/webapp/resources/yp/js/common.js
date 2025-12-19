$(document).ready(function(){
	
		$(".aside ul").css("display","none");
	
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".l_menu>a").click(function(){
//        	$(this).next("ul").toggleClass("hide"); // a 옆의 태그중 ul 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
        	
        	// submenu 가 화면상에 보일때는 위로 부드럽게 접고 아니면 아래로 부드럽게 펼치기
        	var submenu = $(this).next("ul");
        	if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
        
        $("#top_fi").click(function(){
        	//$("#l_fi").css("display","block");
        	leftmenu_disable('l_fi');
        	//$("#fi").slideDown()
        });
        $("#top_tm").click(function(){
        	//$("#l_tm").css("display","block");
        	leftmenu_disable('l_tm');
        	//$("#tm").slideDown()
        });
        $("#top_hr").click(function(){
        	//$("#l_hr").css("display","block"); 
        	leftmenu_disable('l_hr');
        	//$("#hr").slideDown()
        });
        $("#top_pp").click(function(){
        	leftmenu_disable('l_pp');
        	//$("#pp").slideDown()
        });
        $("#top_cm").click(function(){
        	leftmenu_disable('l_cm');
        	//$("#cm").slideDown()
        });
        $("#top_pm").click(function(){
        	leftmenu_disable('l_pm');
        	//$("#cm").slideDown()
        });
        $("#top_dart").click(function(){
        	leftmenu_disable('l_dart');
        	//$("#cm").slideDown()
        });
        
        $("#aside h1").click(function(){
        	location.replace('/main');
        });
        //
        $("#logout").click(function(){
//        	console.log("111");
        	location.replace('/login/logOut');
        });
        
    });

function call_contents(action){
	
	//20191023_khj for csrf
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
	
//	$('#main_body').load(action);
	$.ajax({
	    url: action,
	    type: "POST",
	    cache:false,
	    async:true, 
//	    data:$("#frm").serialize(),
	    success: function(result) {
	    	$("#popup").empty();
	    	$("#popup").html(result);
		},
		beforeSend:function(xhr){
			xhr.setRequestHeader(header, token);
	        xhr.setRequestHeader("AJAX", true);
			$('.wrap-loading').removeClass('display-none');
		},
		complete:function(){
	        $('.wrap-loading').addClass('display-none');
	    },
	    error:function(request,status,error){
	    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
	    	alert("메뉴이동 실패!\n관리자에게 문의해주세요.");
	    }
 });	
}

function leftmenu_disable (active_menu){
	$("#l_fi").css("display","none");
	$("#l_tm").css("display","none");
	$("#l_hr").css("display","none"); 
	$("#l_pp").css("display","none"); 
	$("#l_dart").css("display","none"); 
	$("#l_cm").css("display","none");
	$("#l_pm").css("display","none");
	
	$("#" + active_menu).css("display","block");
	$("#" + active_menu + " .hide").css("display","block");
}

//20200804_khj 엑셀다운로드 공통 펑션 추가
function excelDownload(url, searchParams, excelParams) {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", url);
 
    //엑셀다운시 필수 파라메터 세팅
    for(var key in excelParams) {
    	searchParams.push({name:key, value:excelParams[key]});
    }
    
    //엑셀다운시 쿼리 조회조건 파라메터 세팅
	for(var key in searchParams) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", searchParams[key].name);
        hiddenField.setAttribute("value", searchParams[key].value);
 
        form.appendChild(hiddenField);
	}

    document.body.appendChild(form);
    form.submit();
    form.remove();
}