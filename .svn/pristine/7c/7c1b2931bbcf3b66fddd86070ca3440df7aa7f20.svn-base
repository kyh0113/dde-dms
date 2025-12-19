<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>샘플 페이지1</title>
</head>
<body>
	<h2>
		샘플 페이지1
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
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
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
						<th>사업영역</th>
						<td>
							<input type="radio" name="GSBER_S" id="1100" value="1100" <c:if test="${req_data.GSBER_S eq '1100'}">checked</c:if> ><label for="1100">본사</label> 
							<input type="radio" name="GSBER_S" id="1200" value="1200" <c:if test="${req_data.GSBER_S eq '1200'}">checked</c:if> ><label for="1200">석포</label>
							<input type="radio" name="GSBER_S" id="1400" value="1400" <c:if test="${req_data.GSBER_S eq '1400'}">checked</c:if> ><label for="1400">안성휴게소</label>
						</td>
						<th>집행부서</th>
						<td>
							<input type="text" name="RORG_S" id="RORG_S" style="width:170px;">
							<a href="#" onclick=""><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>입력년월</th>
						<td>
							<input class="calendar dtp" type="text" name="SPMON_S" id="SPMON_S" value="<c:choose><c:when test="${empty req_data.SPMON_S}"><%=toDay%></c:when><c:otherwise>${req_data.SPMON_S}</c:otherwise></c:choose>">
							~
							<input class="calendar dtp" type="text" name="SPMON_E" id="SPMON_E" value="<c:choose><c:when test="${empty req_data.SPMON_E}"><%=toDay%></c:when><c:otherwise>${req_data.SPMON_E}</c:otherwise></c:choose>">
						</td>
					</tr>
					<tr>
						<th>예산계정</th>
						<td>
							<input type="text" name="BACT_S" id="BACT_S" style="width:170px;">
							<a href="#" onclick=""><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>예산조직</th>
						<td>
							<input type="text" name="BORG_S" id="BORG_S" style="width:170px;">
							<a href="#" onclick=""><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">샘플목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="add_btn"     value="추가"/>
				<input type="button" class="btn_g" id="modify_btn"  value="수정"/>
				<input type="button" class="btn_g" id="save_btn"    value="저장"/>
				<input type="button" class="btn_g" id="delete_btn"  value="삭제"/>
			</div>
		</div>
	</div>
	<section>
		<div class="lst">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<tr>
					<th class="center"><input type="checkbox" /></th>
					<th class="center">상태</th>
					<th class="center">승인여부</th>
					<th class="center">전자결재</th>
					<th class="center">전표번호</th>
					<th class="center">연도</th>
					<th class="center">원화금액</th>
					<th class="center">외화금액</th>
					<th class="center">통화</th>
					<th class="center">전표헤더텍스트</th>
					<th class="center">참조</th>
					<th class="center">거래처</th>
					<th class="center">거래처명</th>
					<th class="center">전기일</th>
					<th class="center">입력일</th>
					<th class="center">사원이름</th>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>임시</td>
					<td>미승인</td>
					<td><button type="button" class="btn_s"  onclick="">상신</button></td>
					<td><a href="#">10000000080</a></td>
					<td>2020</td>
					<td>10</td>
					<td>0</td>
					<td>KRW</td>
					<td>Test</td>
					<td>1100110510</td>
					<td>59999</td>
					<td>기타거래처</td>
					<td>2020-06-09</td>
					<td>2020-06-10</td>
					<td>홍길동</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>임시</td>
					<td>미승인</td>
					<td><button type="button" class="btn_s" >상신</button></td>
					<td><a href="#">10000000080</a></td>
					<td>2020</td>
					<td>10</td>
					<td>0</td>
					<td>KRW</td>
					<td>Test</td>
					<td>1100110510</td>
					<td>59999</td>
					<td>기타거래처</td>
					<td>2020-06-09</td>
					<td>2020-06-10</td>
					<td>홍길동</td>
				</tr>
			</table>
		</div>
	</section>



	<script>
$(document).ready(function(){

})
	
</script>
</body>