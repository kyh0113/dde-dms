<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags />
<title>전표생성</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/yp/css/style.css">
<style type="text/css">
/* 로딩바 관련 */
.wrap-loading { /* background darkness*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000'); /* ie */
	z-index: 9000;
}

.wrap-loading div { /*loading img*/
	position: fixed;
	top: 50%;
	left: 50%;
	margin-left: -21px;
	margin-top: -21px;
	z-index: 9000;
}

.display-none { /*loading_bar hidden*/
	display: none;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){

		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		 });
		
		// 부트스트랩 날짜객체
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				if(ev.viewMode != "months" && ev.viewMode != "years"){
					$(this).trigger("change");
					$('.datepicker').hide();
				}
			});
		});
		
		// 전기일 변경 이벤트
		$("input[name=BUDAT]").on("change", function() {
			if ($("input[name=BLDAT]").val() == "") {
				$("input[name=BLDAT]").val($("input[name=BUDAT]").val());
			}
		});
	});
	
	function fnSave(){
		
		if (confirm("전표생성을 진행하시겠습니까?")) {
			
			var data = $("#frm").serializeArray();
			data.push({name: "rows", value: '${list}'});
			
			if(fnRegValidation()){
				$.ajax({
					url: "/yp/zwc/rst/zwc_rst_doc_create_save",
					type : "POST",
					dataType:"json",
					data : data,
					success: function(data){
						if(data.flag == "E"){	//전표생성 실패
							swalWarning(data.msg);
						}else{					//전표생성 성공
							swalSuccessCB("전표번호 "+data.msg+" 생성을 완료하였습니다.", function(){
								window.opener.$('#search_btn').trigger('click');
								window.open('', '_self').close();
							});	
						}
					},
					error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("전표생성중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    },
				    beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        setTimeout(function() {
							$('.wrap-loading').addClass('display-none');
						}, 1000); //1초
				    },
				});
			}
		}
	}
	
	function fnRegValidation(){
		if("" == $("input[name=BUDAT]").val()){
			swalWarningCB("전기일을 입력해주세요.", function(){
				$("input[name=BUDAT]").focus();
			}); 
			return false;
		}else if("" == $("input[name=BLDAT]").val()){
			swalWarningCB("증빙일을 입력해주세요.", function(){
				$("input[name=BLDAT]").focus();
			}); 
			return false;
		}else if($("input[name=BUDAT]").val() != $("input[name=BLDAT]").val()){
			swalWarningCB("전기일과 증빙일은 동일해야 합니다.", function(){
				$("input[name=BLDAT]").focus();
			}); 
			return false;
		}else if("" == $("input[name=BKTXT]").val()){
			swalWarningCB("전표헤더텍스트를 입력해주세요.", function(){
				$("input[name=BKTXT]").focus();
			}); 
			return false;
		}
		return true;
	}
	
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			전표생성
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<!-- 도급비 조회 key -->
				<input type="hidden" name="CHECK_YYYYMM" id="CHECK_YYYYMM" value="${BASE_YYYY}"/>
				<input type="hidden" name="VENDOR_CODE" id="VENDOR_CODE" value="${VENDOR_CODE}"/>
				<input type="hidden" name="GUBUN_CODE" id="GUBUN_CODE" value="${GUBUN_CODE}"/>
				<!-- 전표 헤더 Parameter -->
				<input type="hidden" name="BUKRS" id="BUKRS" value="1000"/>			<!-- 회사코드 -->
				<input type="hidden" name="GJAHR" id="GJAHR" value="${BASE_YYYY}"/>	<!-- 회계연도 -->
				<input type="hidden" name="BLART" id="BLART" value="1"/>			<!-- 전표유형 -->
				<input type="hidden" name="WAERS" id="WAERS" value="KRW"/>			<!-- 통화 키 -->	
				<input type="hidden" name="LIFNR" id="LIFNR" value="${SAP_CODE}"/>	<!-- 업체 SAP코드 -->
				<input type="hidden" name="HKONT" id="HKONT" value="${HKONT}"/>		<!-- 총계정원장계정 : 저장품 43307115, 저장품 외 43204101, 부가세ROW 11404101 -->
				<input type="hidden" name="BUPLA" id="BUPLA" value="1200"/>			<!-- 사업장 : (주)영풍석포제련소 -->
				<input type="hidden" name="GSBER" id="GSBER" value="1200"/>			<!-- 사업장 : (주)영풍석포제련소 -->
				<input type="hidden" name="DMBTR" id="DMBTR" value="${TOTAL}"/>		<!-- 현지통화금액 : 소급비 집계표의 합계 -->
				<input type="hidden" name="ZSUPAMT" id="ZSUPAMT" value="${SUB_TOTAL}"/>	<!-- 공급가액 : 도급비 집계표의 소계 -->
				<input type="hidden" name="WMWST"   id="WMWST"   value="${VAT}"/>		<!-- 세액 : 도급비 집계표의 부가세 -->
				<input type="hidden" name="ZTOPAY"  id="ZTOPAY"  value="${TOTAL}"/>		<!-- 총지급금액 : 공급가액 + 세액 -->
				
				<section>
					<table width="100%" class="tbl-basic">
						<colgroup>
                       		<col />
                       	 	<col />
                        	<col />
                        	<col />
                    	</colgroup>
						<tr>
							<th>업체명</th>
							<td colspan="3">
								${VENDOR_NAME}
							</td>
						</tr>
						<tr>
							<th>전기일<span class="require">*</span></th>
							<td>
								<input name="BUDAT" id="BUDAT" class="dtp calendar" style="width:165px;" value=""/>
							</td>
							<th>증빙일<span class="require">*</span></th>
							<td>
								<input name="BLDAT" id="BLDAT" class="dtp calendar" style="width:165px;" value=""/>
							</td>
						</tr>
						<tr>
							<th>전표헤더 텍스트<span class="require">*</span></th>
							<td colspan="3">
								<input type="text" name="BKTXT" id="BKTXT" style="width:90%;" value=""/>
							</td>
						</tr>
					</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript:fnSave();">전표생성</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
	<div id="wrap-loading" class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
</body>
</html>