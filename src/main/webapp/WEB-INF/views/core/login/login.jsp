<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>Login</title>
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />

	<style type="text/css">
 		* { 
	   	 -webkit-box-sizing: content-box !important; 
	   	 -moz-box-sizing: content-box !important; 
	   	 box-sizing: content-box !important; 
		} 
		.notactive {pointer-events: none; cursor: default;} 
 		.swal-content{text-align:center;} 
 		.password {padding-left:10px; position:relative; display:block; border:1px solid #d3d3d3; width:100%; height:30px; margin-bottom:10px;}  
		.password:focus{outline:1px;} 
/*   		.modal{position:absolute; left:42%; top:100px;}  */
 		.modal-header .close { 
		    margin-top: -20px; 
 		} 
	</style>
	
	<script src="/resources/icm/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		String.prototype.trim = function() {
			return this.replace(/(^\s*)|(\s*$)/gi, "");
		}
		// Progressbar() open / close
		function progressbarOpen(){
			$("#ajax_loading").dialog({
//				 height: 100
				width: 200 /* 조절안됨 */
				,position: {my: 'center center', at:'center center' ,of: '#decorator_body'}
			    ,modal: true
			    ,resizable:false
			});
		    $("#ajax_loading").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();//상단 타이틀 제거
		    $("#ajax_loading").css("min-height", "");
		}
		function progressbarClose(){
			if(!$("#ajax_loading").parent().is("body")){
				$("#ajax_loading").dialog('destroy');
			}
		}
		function gPostArray(obj){
			var paramArray = {};
			jQuery.each(obj, function(i, obj){
				paramArray[obj.name] = obj.value;
			 });
			 return paramArray;
		}
		function dialogOpen(obj){
			if(obj.height == null){
				$("#"+obj.id).dialog({
					 title: obj.title
					,width: obj.width
					,position: {my: 'center center', at:'center center' ,of: 'body'}
				    ,modal: obj.modal
				    ,buttons : obj.button
				    ,resizable:false
				    ,closeOnEscape: false
				    ,open: function(){
				    	$(".ui-dialog-titlebar-close", $(this).parent()).hide(); 
				    }
				});
			}else{
				$("#"+obj.id).dialog({
					 title: obj.title
					,height: obj.height	 
					,width: obj.width
				    ,position: {my: 'center top', at:'center top' ,of: 'body'}
				    ,modal: obj.modal
				    ,buttons : obj.button
				    ,resizable:false
				    ,closeOnEscape: false
				    ,open: function(){
				    	$(".ui-dialog-titlebar-close", $(this).parent()).hide(); 
				    }
				});	
			}
		}
		$.extend({
			clear_form : function(ele) {
				$(ele).find(':input').each(function() {
					var eleId = $(this).attr("id");
					switch (this.type) {
					case 'password':
					case 'text':
					case 'hidden':
					case 'textarea':
						$(this).val('');
						break;
					case 'select-multiple':
					case 'select-one':
					case 'select': 
						// 2016-11-03 jamerl <select> 엘리먼트에 클래스를 다음과 같이 명시하면, 초기화될때 기본값이 [ "" : "전체"] 세팅된다. 
						if($(this).is(".default-popup")){
							$(this).empty().append("<option value=''>전체</option>").find("option:eq(0)").attr("selected", "selected");	
						}else{
							$(this).find("option:eq(0)").attr("selected", "selected");
						}
						break;
					case 'checkbox': // 이 프레임에서는 checkbox 인 경우 ID를 각각 다르게 생성해 주어야 한다.
						$(this).removeAttr("checked");
						break;
					case 'radio':
						var radioName = $(this).attr("name");
						$("input[name="+radioName+"]:radio:eq(0)").prop("checked", true);
						break;
					}
				});
			},
			addDialog : function(obj){
				if(obj.id == undefined || typeof obj.id == "undefined"){
					alert("[ Argument : 1 ] id 설정 [ DIV ID ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.title == undefined || typeof obj.title == "undefined"){
					alert("[ Argument : 2 ] title 설정 [ \"제목>제목>\" ] 부분이 누락됐습니다.");
					return false;
				}
				if((obj.height != null) && (obj.height == undefined || typeof obj.height == "undefined")){
					alert("[ Argument : 3 ] height 설정 [ 500 / null ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.width == undefined || typeof obj.width == "undefined"){
					alert("[ Argument : 4 ] width 설정 [ 800 ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.position == undefined || typeof obj.position == "undefined"){
					alert("[ Argument : 5 ] position 설정 [ \"center\" ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.modal == undefined || typeof obj.modal == "undefined"){
					alert("[ Argument : 6 ] modal 설정 [ true / false ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.button == undefined || typeof obj.button == "undefined"){
					alert("[ Argument : 7 ] button 설정 [ [{text:'닫기',click : function() {  $(this).dialog('destroy');} } ] ] 부분이 누락됐습니다.");
					return false;
				}
				if(obj.callback == undefined || typeof obj.callback == "undefined"){
					alert("[ Argument : 8 ] callback 설정 [ {} ] 부분이 누락됐습니다.");
					return false;
				}
				var $oThis = $("#"+obj.id);
				if($oThis[0] == undefined){//해당 엘리먼트를 선택하지 않았을 경우 id는 반듯이 한개이므로 여러개 지정 불가
					alert("DIV Element ID : " + $oThis.selector + "\nNot Exists");
					return;
				}
				$.clear_form($("#"+obj.id).find("form:first"));
				dialogOpen(obj);
				obj.callback(true);	
			}
		});
		var ie8_checker = false;
		
		function doSuccess(data){ // ajax 로그인 요청 후 - 20180809하태현
			switch(data.FROM_SERV_CD*1){
			case 1 : goMain(data.FROM_SERV_INIT_PAGE);
				break;
			case -1 : swalWarning(data.FROM_SERV_MSG);
				break;
			case -2 : swalWarning(data.FROM_SERV_MSG);
				break;
			case -3 : swalWarning(data.FROM_SERV_MSG);
				break;
			case -4 : swalWarning(data.FROM_SERV_MSG);
				break;
			case -5 : swal({
						  icon : "warning",
						  text: data.FROM_SERV_MSG,
						  closeOnClickOutside : false,
						  closeOnEsc : false,
						  buttons: {
								confirm: {
								  text: "확인",
								  value: true,
								  visible: true,
								  className: ""
								}
						  }
						})
						.then(function(result){
							  if(result){
								  //document.getElementById("resetPasswordForm").reset();
								  $("#resetPasswordModal2").modal({
										backdrop : true,
										keyboard: false
								  });
							  }
						});
				break;
			case -6 : swal({
							  icon : "warning",
							  text: data.FROM_SERV_MSG,
							  closeOnClickOutside : false,
							  closeOnEsc : false,
							  buttons: {
									confirm: {
									  text: "확인",
									  value: true,
									  visible: true,
									  className: "",
									  closeModal: true
									}
							  }
							})
							.then(function(result){
								  if(result){
									  location.href = "/";
								  }
							});
				
				break;
			case -7 : swal({
						  icon : "warning",
						  text: data.FROM_SERV_MSG,
						  closeOnClickOutside : false,
						  closeOnEsc : false,
						  buttons: {
								confirm: {
								  text: "확인",
								  value: true,
								  visible: true,
								  className: "",
								  closeModal: true
								}
						  }
						})
						.then(function(result){
							  if(result){
								  location.href = "/";
							  }
						});
			
				break;	
			case -8 : swalWarning(data.FROM_SERV_MSG);
				break;
			case -9 : swal({
						  icon : "warning",
						  text: data.FROM_SERV_MSG,
						  closeOnClickOutside : false,
						  closeOnEsc : false,
						  buttons: {
								confirm: {
								  text: "확인",
								  value: true,
								  visible: true,
								  className: ""
								}
						  }
						})
						.then(function(result){
							  if(result){
								  //document.getElementById("resetPasswordForm").reset();
								  $("#resetPasswordModal2").modal({
										backdrop : true,
										keyboard: false
								  });
							  }
						});
				break;	
			}
		}
		
		function goMain(init_page){
	     	var form    = document.createElement("form");
	     	var input   = document.createElement("input");
	     	input.name  = "_csrf";
	     	input.value = "${_csrf.token}";
	     	input.type  = "hidden";
	    	
	     	form.method = "post";
	     	form.action = init_page;
	    	
	     	form.appendChild(input);
	     	document.body.appendChild(form);
	    	
	     	form.submit();
	     	form.remove();
		}
		
		$(document).ready(function(){
			if(parseInt(get_version_of_IE()) > 8){
				$("#browser_version").html("<br>&nbsp;");
			}else{
				$("#browser_version").html("<br>인터넷 익스플로러(IE) 9 미만 버전은 시스템을 사용하실 수 없습니다. 9 버전 이상의 인터넷 익스플로러(IE)로 업데이트 하거나 크롬, 파이어폭스 브라우저를 사용하시기 바랍니다.");
				ie8_checker = true;
			}
			// 숫자만 입력
			$('.vitf-valid-single-quotation').keyup(function(e){
				var k;
				if(window.event){k=window.event.keyCode;}else{k=e.which;}//IE vs others
				//[16:Shift,39:→,37:←,8:Backspace,46:DEL,9:Tab,27:Esc,20:CapsLock,35:end,36:home]
				if(k===16||k===39||k===37||k===8||k===46||k===9||k===27||k===20||k===35||k===36){return;}
				var t = $(this);
				var v = t.val().trim();
				t.val(v.replace(/'/gi,""));
			});
			
			$("#resetPassword_btn").on("click",function(){
				var new_password = document.getElementById("new_password").value;
				var new_password_chk = document.getElementById("new_password_chk").value;
				var emp_code = document.getElementById("uid").value;
				if(new_password == "" || new_password_chk == ""){
					swalWarning("새비밀번호와 비밀번호확인란을 모두 입력해주십시오.");
					return false;
				}				
				if(new_password != new_password_chk){
					swalWarning("새비밀번호가 일치하지 않습니다.");
					return false;
				}
				
				var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
				if(!reg_pwd.test(new_password))	{
					swalWarning("숫자와 영문자 조합으로 6~20자리를 사용해야 합니다.");
					return false;
				}
				
				//20191024_khj RSA
			    // Server로부터 받은 공개키 입력
			    var rsa = new RSAKey();
			    rsa.setPublic("${modulus}", "${exponent}");
			 	//20191024_khj RSA

				var obj = new Object();
				obj.new_password     = rsa.encrypt(new_password);
				obj.new_password_chk = rsa.encrypt(new_password_chk);
				obj.emp_code = emp_code;
				
				//20191023_khj for csrf
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					type: 'POST',
					url: '/core/login/resetPassword',
					data: obj,
					dataType: 'json',
					//async : false,
					success: function(data){
						
						switch(data.FROM_SERV_CD*1){
							case 1 : swalSuccess("비밀번호가 변경 되었습니다.");
									 $("#upwd").val("");
									 $("#resetPasswordModal").modal("toggle");
								break;
							case -1 : swalWarning(data.FROM_SERV_MSG);
								break;
						}

					},
                    beforeSend: function(xhr){
                    	//20191023_khj for csrf
            	        xhr.setRequestHeader(header, token);
                    }
				});
			});
			
			$("#login_btn").click(function(){
				if(ie8_checker){
					alert("인터넷 익스플로러(IE) 9 미만 버전은 시스템을 사용하실 수 없습니다.\n9 버전 이상의 인터넷 익스플로러(IE)로 업데이트 하거나 크롬, 파이어폭스 브라우저를 사용하시기 바랍니다.");
					return false;
				}
				if(isEmpty($("#uid").val())||isEmpty($("#upwd").val())){
					swalWarning("아이디와 비밀번호 모두 입력해 주십시오.");
					return false;
				}
				var target = $(this);
				if(target.hasClass("notactive")){
					return false;
				}
				
				//20191024_khj RSA
			    //var $id = $("#loginFrm input[name='uid']");
			    var $pw = $("#loginFrm input[name='upwd']");
			 
			    // Server로부터 받은 공개키 입력
			    var rsa = new RSAKey();
			    rsa.setPublic("${modulus}", "${exponent}");

			    //$id.val(rsa.encrypt($id.val())); // 아이디 암호화
			    $pw.val(rsa.encrypt($pw.val())); // 비밀번호 암호화
			 	//20191024_khj RSA
				
				var oForm = $("#loginFrm").serializeArray();
				
				//20191023_khj for csrf
			    var token = $("meta[name='_csrf']").attr("content");
			    var header = $("meta[name='_csrf_header']").attr("content");
			 	//20191023_khj for csrf

			 	oForm[2].name = "QSjJEwnV6COzaOemHJfMLA==";

				$.ajax({
					type: 'POST',
					url: '/core/login/ChkId.do',
					data: gPostArray(oForm),
					dataType: 'json',
					success: function(data){
						doSuccess(data);
						target.removeClass("notactive");
						$("#loginFrm input[name='upwd']").val("");
					},
                    beforeSend: function(xhr){
                    	target.addClass("notactive");
                    	//20191023_khj for csrf
            	        xhr.setRequestHeader(header, token);
                    },
                    complete: function(){}
				});
			}).focus();
			
			
			$('.input_box input').keypress(function(e){
				var charCode = (e.which) ? e.which : event.keyCode;
				if(charCode === 13){
					if(ie8_checker){
						alert("인터넷 익스플로러(IE) 9 미만 버전은 시스템을 사용하실 수 없습니다.\n9 버전 이상의 인터넷 익스플로러(IE)로 업데이트 하거나 크롬, 파이어폭스 브라우저를 사용하시기 바랍니다.");
						return false;
					}
					var target = $("#login_btn");
					if(target.hasClass("notactive")){
						return false;
					}
					if($('#remember_id').is(':checked')){
						$.cookie('id', $('[name=employee_cd]').val(), { expires: 365, path: "/core/login/" });
					}else{
						$.removeCookie('id');
					}
					
					//20191024_khj RSA
				    //var $id = $("#loginFrm input[name='uid']");
				    var $pw = $("#loginFrm input[name='upwd']");
				 
				    // Server로부터 받은 공개키 입력
				    var rsa = new RSAKey();
				    rsa.setPublic("${modulus}", "${exponent}");

				    //$id.val(rsa.encrypt($id.val())); // 아이디 암호화
				    $pw.val(rsa.encrypt($pw.val())); // 비밀번호 암호화
				 	//20191024_khj RSA
				 	
					
					var oForm = $("#loginFrm").serializeArray();
					
					//20191023_khj for csrf
				    var token = $("meta[name='_csrf']").attr("content");
				    var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						type: 'POST',
						url: '/core/login/ChkId.do',
						data: gPostArray(oForm),
						dataType: 'json',
						success: function(data){
							doSuccess(data);
							target.removeClass("notactive");
						},
                        beforeSend: function(xhr){
                        	target.addClass("notactive");
                        	//20191023_khj for csrf
                	        xhr.setRequestHeader(header, token);
                        },
                        complete: function(){}
					});
				}else{
					return;
				}
			});
			
			
		});

		function get_version_of_IE () { 

			 var word; 
// 			 var version = "N/A"; 
			 var version = "9999"; 

			 var agent = navigator.userAgent.toLowerCase(); 

			 // IE old version ( IE 10 or Lower ) 
			 if ( navigator.appName == "Microsoft Internet Explorer" ) word = "msie "; 

			 else { 
				 // IE 11 
				 if ( agent.search( "trident" ) > -1 ) word = "trident/.*rv:"; 

				 // Microsoft Edge  
				 else if ( agent.search( "edge/" ) > -1 ) word = "edge/"; 

				 // 그외, IE가 아니라면 ( If it's not IE or Edge )  
				 else return version; 
			 } 

			 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" ); 

// 			 if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2; 
			 if (  reg.exec( agent ) != null  ) version = RegExp.$1; 

			 return version; 
		}
		
		function enter_check(param){		
			// 엔터키의 코드는 13입니다.
		    if(event.keyCode == 13){
		    	$("#login_btn").trigger("click");
		    }
		}
		
		
		</script>
</head>
<body>

<div class="login_w">
	<div class="logo"><h1 style="font-size:33px;font-weight:bold; margin-top:20px;">VIT <span style="color:#2380C7;">Framework</span></h1></div>
    <h1>비큐러스정보기술 프레임워크</h1>
    <div class="login_bg">
    	<div class="login_box">
        <form  id="loginFrm" onSubmit="return false">
        <!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
        	<dl style="min-width: 340px;">
                <dt class="id_icon">User ID</dt>
                <dd><input class="input100" type="text" name="uid" id="uid" onkeydown="enter_check('uid');"></dd>
                <dt class="pass_icon">Password</dt>
                <dd><input class="input100" type="password" name="upwd" id="upwd" onkeydown="enter_check('upwd');" autocomplete="off"></dd>
            </dl>
<!--                 <div class="login_checkbox">
                    <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
                    <label class="label-checkbox100" for="ckb1">
                        Remember me
                    </label>
                </div> -->
            <div class="login_btn_box">
           		<button id="login_btn" class="login_btn">LOGIN</button>
            </div>
         </form>
         <div class="idpass_text">User ID나 password를 분실하신 경우에는 <mark style="color:#3986AC;">관리자</mark>에게 문의하십시오.</div>
        </div>            
    </div>
    <div style="clear:both;"></div>
    <div class="copyright">copyright(c) 2020. All right reserved.</div>
</div>


    
<div class="modal fade" id="resetPasswordModal2" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="resetPasswordForm">
			<div class="form-group">
            <label for="new_password" class="col-form-label">새비밀번호:</label>
            <input type="password" class="form-control" id="new_password" name="new_password" style="box-sizing:border-box!important;" autocomplete="off">
          	</div>
          	<div class="form-group">
            <label for="new_password_chk" class="col-form-label">새비밀번호확인:</label>
            <input type="password" class="form-control" id="new_password_chk" name="new_password_chk" style="box-sizing:border-box!important;" autocomplete="off">
          	</div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="resetPassword_btn" class="btn btn-primary" data-dismiss="modal">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</body>