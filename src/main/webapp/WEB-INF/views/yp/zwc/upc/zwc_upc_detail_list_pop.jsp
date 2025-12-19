<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>업체별 단가 상세조회</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
</head>
<body style="margin:10px;">
	<h2>
		업체별 단가 상세조회
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				<li>${menu.breadcrumb[0].top_menu_name}</li>
				<c:if test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
					<c:if test="${menu.breadcrumb[0].up_menu_id ne null}">
						<li>${menu.breadcrumb[0].up_menu_name}</li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${menu.breadcrumb[0].menu_id ne null}">
				<li>${menu.breadcrumb[0].menu_name}</li>
			</c:if>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	<!-- 	<div class="stitle">기본정보</div> -->
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th>연도</th>
					<td>
						<input type="text" value="${BASE_YYYY}" disabled />
					</td>
					<th>거래처</th>
					<td>
						<input type="text"  value="${VENDOR_NAME}" disabled />
					</td>
					<th>근무형태</th>
					<td>
						<input type="text"  value="${WORKTYPE_NAME}" disabled />
					</td>
				</tr>
			</table>
		</div>
	</section>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="BASE_YYYY" />
			<input type="hidden" name="VENDOR_CODE" />
			<div class="tbl_box">
				<table border="1"  class="popup_table">
					<thead>
				    	<tr>
					        <th>항목</th>
					        <th>계산식</th>
					        <th>값</th>
					        <th>비고</th>
				    	</tr>
				    </thead>
					<colgroup>
						<col width="3%" />
						<col/>
						<col width="5%" />
						<col width="27%" />
					</colgroup>
					<c:forEach var="data" items="${detail_list}">
						<fmt:formatNumber var="ITEM1" value="${data.ITEM1 }" pattern="#,###" />
						<fmt:formatNumber var="VALUE" value="${data.VALUE }" pattern="#,###" />
						
						<c:if test="${data.COST_CODE == 'C1'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">인원</th>
							<td><input type="text" class="input_data" name="C1" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C2'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">사업소세</th>
							<td>
								<input type="text" class="input_data" name="C2" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="*" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled"/></td>
							<td><span>근무형태별 단가 * 사업소세</span></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C3'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">안전대행료</th>
							<td><input type="text" class="input_data" name="C3" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C4'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">보험대행료</th>
							<td><input type="text" class="input_data" name="C4" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C5'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">교통비</th>
							<td><input type="text" class="input_data" name="C5" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C6'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">KOSAH18001</th>
							<td>
								<input type="text" class="input_data" name="C6" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM3}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td><span>KOSHA18001 / 12 / 인원</span></td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C7'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">관리감독자 교육비</th>
							<td>
								<input type="text" class="input_data" name="C7" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="*" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM3}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM4}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td><span>관리감독자 교육비 * 관리감독자 교육인원 / 12 / 인원</span></td>	
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C8'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">관리감독자 교육인원</th>
							<td><input type="text" class="input_data" name="C8" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>	
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C12'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">유해화학물질 취급자 교육비</th>
							<td>
								<input type="text" class="input_data" name="C12" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="*" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM3}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM4}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td>유해화학물질 취급자 교육비 * 유해화학물질 취금자 교육인원 / 12/ 인원</td>
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C13'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">유해화학물질 취금자 교육인원</th>
							<td><input type="text" class="input_data" name="C13" value="${ITEM1}" style="text-align: right;" disabled="disabled" /></td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>	
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C9'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">세무기장료</th>
							<td>
								<input type="text" class="input_data" name="C9" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td><span>세무기장료 / 인원</span></td>	
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C10'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">사무실운영비</th>
							<td>
								<input type="text" class="input_data" name="C10" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="/" disabled="disabled" />
								<input type="text" class="input_data" value="${data.ITEM2}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td><span>사무실운영비  / 인원</span></td>	
						</tr>
						</c:if>
						
						<c:if test="${data.COST_CODE == 'C11'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">사업주이윤</th>
							<td>
								<input type="text" class="input_data" name="C11" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td></td>	
						</tr>
						</c:if>
						
						<!-- 쿼리에서 UNION을 이용해서 CODST_CODE이름을 danga라고 지어서 조회함 -->
						<c:if test="${data.COST_CODE == 'danga'}">
						<tr>
							<th style="text-align: center; vertical-align: middle;">단가</th>
							<td>
								<input type="text" class = "input_data" name="C12" value="${ITEM1}" style="text-align: right;" disabled="disabled" />
								<input type="text" class="input_operator" value="+" disabled="disabled" />
								<input type="text" class="input_data" value="<fmt:formatNumber value="${data.ITEM2 }" pattern="#,###" />" style="text-align: right;" disabled="disabled" />
							</td>
							<td><input type="text" class="input_data" value="${VALUE}" style="text-align: right;" disabled="disabled" /></td>
							<td><span>근무형태별 단가 + 위 항목 전체 소계<br>(관리감독자 교육인원 제외)</span></td>	
						</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</form>
	</section>
	<script>
		var enable_calc = false; // 계산 여부 - true: 가능, false: 불가
		var enable_save = false; // 저장 가능 여부 - true: 가능, false: 불가
		$(document).ready(function() {
			
			
		});
		
		/*콤마 추가*/
		function addComma(num) {
			var rnum = "0";
			if(num !== null){
				rnum = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			return rnum;
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/[^0-9.]/gi, '');
		}
		
		function fnValidation(){
			var check = true;
			$(".validation").each(function(i, d){
				// 빈 값은 0으로 설정
				if($(d).val().trim() === ""){
					$(d).val(0);
				}
				if($(d).is(".not-null") && $(d).val() === "0"){
					console.log($(d));
					swalWarningCB("인원값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
				if(isNaN(Number(unComma($(d).val())))){
					swalWarningCB("항목값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
			});
// 			console.log("결과", check);
			return check;
		}
	</script>
</body>