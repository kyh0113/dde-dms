<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회계전표 등록</title>
</head>
<body>
	<h2>
		회계전표 등록
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
	<form id="regfrm" name="regfrm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="CALC_CODE" value="${req_data.FRM[0].CALC_CODE}"/>
		
		<div class="stitle jp_area" style="display: none;">전표등록 정보</div>
		<section class="jp_area" style="display: none;">
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="12%" />
						<col />
					</colgroup>
					<tr>
						<th>전표 번호</th>
						<td id="BELNR">
							<input type=button class="btn_g" id="BELNR_btn" value="결재상신">
							<input type="hidden" name="BELNR" value="">
							<input type="hidden" id="url" value="" />
						</td>
					</tr>
				</table>
			</div>
		</section>
		<div class="stitle">기본정보</div>
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
						<th>전표유형</th>
						<td>
							<input type="radio" id="doc_norm" name="doc_type" class="doc_type" value="1" checked="checked">
							<label for="doc_norm">일반</label>
							<input type="radio" id="doc_sale" name="doc_type" class="doc_type" value="2">
							<label for="doc_sale">판매</label>
							<input type="radio" id="doc_vier" name="doc_type" class="doc_type" value="3">
							<label for="doc_vier">차량</label>
							<input type="radio" id="doc_etc" name="doc_type" class="doc_type" value="4">
							<label for="doc_etc">기타</label>
							<input type="radio" id="doc_imp" name="doc_type" class="doc_type" value="5">
							<label for="doc_imp">수입</label>
						</td>
						<th>전기일</th>
						<td>
							<input type="text" class="calendar dtp" name="BUDAT">
						</td>
						<th>통화</th>
						<td>
							<c:choose>
								<c:when test="${req_data.FRM[0].WAERS != null || !req_data.FRM[0].WAERS eq ''}">
									<input type="text" size="3" name="WAERS" id="currency_type" value="${req_data.FRM[0].WAERS}" readonly="readonly" />
								</c:when>
								<c:otherwise>
									<input type="text" size="3" name="WAERS" id="currency_type" value="KRW" readonly="readonly" />
								</c:otherwise>
							</c:choose>
							<a href="#" style="display: none;" id="cur_sch" onclick="fnSearchPopup('5');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="KURSF" id="currency" value="" style="display: none; text-align: right;" />
						</td>
					</tr>
					<tr>
						<th>사업장</th>
						<td>
							<select name="BUPLA">
								<option value="">-선 택-</option>
								<option value="1100" <c:if test="${req_data.FRM[0].BUPLA eq '1100'}">selected</c:if>>(주)영풍</option>
								<option value="1200" <c:if test="${req_data.FRM[0].BUPLA eq '1200'}">selected</c:if>>(주)영풍석포제련소</option>
								<option value="1400" <c:if test="${req_data.FRM[0].BUPLA eq '1400'}">selected</c:if>>(주)영풍안성휴게소</option>
								<!-- 2020-09-08 jamerl - 백승지 : 사업장 선택 조건 삭제 : 영풍전자, 영풍사업장 -->
								<%-- <option value="1300" <c:if test="${req_data.FRM[0].BUPLA eq '1300'}">selected</c:if>>(주)영풍전자</option> --%>
								<!-- 20200915_khj 전정대 대리 수정으로 다시 활성화 -->
								<option value="1500" <c:if test="${req_data.FRM[0].BUPLA eq '1500'}">selected</c:if>>(주)영풍사업장</option>
								<option value="1600" <c:if test="${req_data.FRM[0].BUPLA eq '1600'}">selected</c:if>>(주)영풍Green메탈캠퍼스</option>
								<option value="1700" <c:if test="${req_data.FRM[0].BUPLA eq '1700'}">selected</c:if>>(주)영풍논현사업장</option>
							</select>
						</td>
						<th>증빙일</th>
						<td>
							<input type="text" class="calendar dtp" name="BLDAT">
						</td>
						<th>전표헤더 텍스트</th>
						<td>
							<input type="text" name="BKTXT" value="${req_data.FRM[0].BKTXT}"/>
						</td>
					</tr>
				</table>
			</div>
		</section>
		<div class="stitle">구매처정보</div>
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
						<th>공급업체</th>
						<td>
							<select class="dt7" name="AGKOA" id="AGKOA" style="display: none;">
								<option value="K">공급업체</option>
								<option value="A">자산</option>
								<option value="D">고객</option>
								<option value="M">자재</option>
								<option value="S">G/L계정</option>
							</select>
							<input type="text" name="LIFNR" size="10" value="${req_data.FRM[0].LIFNR}" />
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="hidden" name="KTOKK" value="">
						</td>
						<th>계정과목</th>
						<td>
							<input type="text" name="HKONT" size="10" value="${req_data.FRM[0].HKONT}" style="width: 100px">
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="TXT_50" size="15" value="${req_data.FRM[0].TXT_50}" style="width: 150px" readonly="readonly">
						</td>
						<th>공급가액</th>
						<td>
							<input type="text" name="ZSUPAMT" style="text-align: right;" onkeyup="fnAutoCompute();" onchange="fnAutoCompute();" value="<fmt:formatNumber  value="${req_data.FRM[0].ZSUPAMT}"/>">
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>
							<input type="text" name="STCD2" size="10" value="${req_data.FRM[0].STCD2}" style="width: 100px" readonly="readonly">
							<input type="text" name="NAME1" size="24" value="${req_data.FRM[0].NAME1}" style="width: 150px" readonly="readonly">
						</td>
						<th>세금코드</th>
						<td>
							<input type="text" name="MWSKZ" size="3" value="${req_data.FRM[0].MWSKZ}" style="width: 100px" onchange="fnAutoCompute();">
							<a href="#" onclick="fnSearchPopup('3');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="TEXT1" size="25" value="${req_data.FRM[0].TEXT1}" style="width: 150px" readonly="readonly">
						</td>
						<th>세액</th>
						<td>
							<input type="text" name="WMWST" style="text-align: right;" onkeyup="fnAutoComputeTaxManual();" onchange="fnAutoComputeTaxManual();" value="${req_data.FRM[0].WMWST}">
						</td>
					</tr>
					<tr>
						<th>은행정보</th>
						<td>
							<input type="text" name="BVTYP" size="3" value="${req_data.FRM[0].BVTYP}" style="width: 100px" readonly="readonly">
							<input type="text" name="BANKN" value="${req_data.FRM[0].BANKN}" style="width: 150px" readonly="readonly">
							<a href="#" onclick="fnSearchPopup('4');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>텍스트</th>
						<td>
							<input type="text" name="SGTXT" value="${req_data.FRM[0].SGTXT}" style="width: 280px;">
						</td>
						<th>추가액</th>
						<td>
							<input type="text" name="ZEXPAMT" style="text-align: right;" onkeyup="fnAutoComputeTaxManual();" onchange="fnAutoComputeTaxManual();" value="${req_data.FRM[0].ZEXPAMT}">
						</td>
					</tr>
					<tr>
						<th>지급조건</th>
						<td>
							<input type="text" name="ZTERM" size="10" value="${req_data.FRM[0].ZTERM}" style="width: 100px;" />
							<a href="#" onclick="fnSearchPopup('19');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="TEXT_ZTERM" size="15" value="${req_data.FRM[0].TEXT_ZTERM}" style="width: 150px;" readonly="readonly">
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
						<th>할인액</th>
						<td>
							<input type="text" name="WSKTO" style="text-align: right;" onkeyup="fnAutoComputeTaxManual();" onchange="fnAutoComputeTaxManual();" value="${req_data.FRM[0].WSKTO}">
						</td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
						<th>총 지급금액</th>
						<td>
							<input type="text" name="ZTOPAY" value="${req_data.FRM[0].ZTOPAY}" style="text-align: right;" readonly="readonly">
						</td>
					</tr>
				</table>
			</div>
		</section>
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">거래처등록</div>
			</div>
			<div class="fr">
				<div class="btn_wrap">
					합계금액: <span id="sum_WRBTR" style="margin-right: 115px; color: red; font-weight: bold;"></span>
					<input type=button class="btn_g" id="sum_btn" value="합계계산">
					<input type=button class="btn_g" id="add_btn" value="항목추가">
					<input type=button class="btn_g" id="remove_btn" value="항목삭제">
				</div>
			</div>
		</div>
		<!-- 	<section class="section"> -->
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 325px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</form>
	<!-- 	</section> -->
	<section>
		<div class="btn_wrap space10">
			<button class="btn btn_save" id="reg_btn" type="">등록</button>
		</div>
	</section>
	<script>
		angular.module('myModule', [ 'ui.bootstrap', 'ui.grid.pinning' ]);
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 100; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;

			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.uiGridConstants = uiGridConstants;

			// 계정 AJAX 이벤트
			$scope.fnAjaxHKONT = function(row) {
				if (row.entity.HKONT != null && row.entity.HKONT.length >= 8) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxHKONT",
						type : "post",
						cache : false,
						async : true,
						data : row.entity,
						dataType : "json",
						success : function(result) {
							if (result.SAKNR == "" || result.SAKNR == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.HKONT = result.SAKNR; //계정과목
								row.entity.ZGLTXT = result.TXT_50; //계정과목 설명
								fnAvailAMT(row);
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 집행부서, 코스트센터 AJAX 이벤트
			$scope.fnAjaxKOSTL = function(type, row) {
				var data = row.entity;
				data.type = type;
				if (type == "Z") {
					if (row.entity.HKONT == "") {
						swalWarningCB("계정을 입력하세요.");
						// $("input[name=HKONT_"+target+"]").focus();
						return false;
					}
					if (row.entity.ZKOSTL != null && row.entity.ZKOSTL.length >= 6) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zfi/doc/retrieveAjaxKOSTL",
							type : "post",
							cache : false,
							async : true,
							data : data,
							dataType : "json",
							success : function(result) {
								if (result.KOST1 == "" || result.KOST1 == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									row.entity.ZKOSTL = result.KOST1; //집행부서 코드
									row.entity.ZKTEXT = result.VERAK; //집행부서 코드설명
									fnAvailAMT(row);
								}
								scope.gridApi.grid.refresh();
							},
							beforeSend : function(xhr) {
								// 2019-10-23 khj - for csrf
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				} else {
					if (row.entity.ZKOSTL == "" && row.entity.HKONT != "43308401") {
						swalWarningCB("집행부서를 입력하세요.");
						// $("input[name=ZKOSTL_"+target+"]").focus();
						return false;
					}
					if (row.entity.KOSTL != null && row.entity.KOSTL.length >= 6) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zfi/doc/retrieveAjaxKOSTL",
							type : "post",
							cache : false,
							async : true,
							data : data,
							dataType : "json",
							success : function(result) {
								if (result.KOST1 == "" || result.KOST1 == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									row.entity.KOSTL = result.KOST1; //코스트센터 코드
									row.entity.LTEXT = result.VERAK; //코스트센터 코드설명
									fnAvailAMT(row);
								}
								scope.gridApi.grid.refresh();
							},
							beforeSend : function(xhr) {
								// 2019-10-23 khj - for csrf
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			};

			// 사업자번호 AJAX 조회
			$scope.fnAjaxSTCD2 = function(row) {
				var data = row.entity;
				if (row.entity.STCD2 != null && row.entity.STCD2.length >= 10) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxSTCD2",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.STCD2 == "" || result.STCD2 == null) {
								//alert(result.STCD2);
								swalWarningCB("일치하는 데이터가 없습니다.");
								//readOnly 풀어주기
								row.entity.NAME1_STATUS = "Y";
							} else {
								row.entity.STCD2 = result.STCD2; //사업자번호
								row.entity.NAME1 = result.NAME1; //거래처명
								//readOnly 해주기
								row.entity.NAME1_STATUS = null;
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// WBS코드 AJAX 조회
			$scope.fnAjaxPOSID = function(row) {
				var data = row.entity;
				if (row.entity.POSID != null && row.entity.POSID.length >= 10) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxPOSID",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.POSID == "" || result.POSID == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.POSID = result.POSID; //WBS코드
								row.entity.POST1 = result.POST1; //WBS명
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 설비오더 AJAX 조회
			$scope.fnAjaxAUFNR = function(row) {
				var data = row.entity;
				if (row.entity.AUFNR != null && row.entity.AUFNR.length >= 6) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxAUFNR",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.MSG != "" && result.MSG != null && result.MSG != "undefined") {
								swalWarningCB(result.MSG);
							} else if (result.AUFNR == "" || result.AUFNR == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.KOSTL = result.KOSTL;
								row.entity.LTEXT = result.LTEXT;
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 판매오더 AJAX 조회
			$scope.fnAjaxVBELN = function(row) {
				var data = row.entity;
				if (row.entity.VBELN != null && row.entity.VBELN.length >= 8) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxVBELN",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.VBELN == "" || result.VBELN == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.VBELN = result.VBELN; //구매오더
								row.entity.VTWEG = result.VTWEG; //유통경로
								row.entity.MVGR1 = result.MVGR1; //자재그룹
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 자재그룹 AJAX 조회
			$scope.fnAjaxMVGR1 = function(row) {
				var data = row.entity;
				if (row.entity.MVGR1 != null && row.entity.MVGR1.length >= 2) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxMVGR1",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.MVGR1 == "" || result.MVGR1 == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
								row.entity.MVGR1 = "";
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 단위 AJAX 조회
			$scope.fnAjaxMEINS = function(row) {
				var data = row.entity;
				if (row.entity.MEINS != null && row.entity.MEINS.length >= 1) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxMEINS",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.MSEHI == "" || result.MSEHI == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
								row.entity.MEINS = "";
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 차량코드 AJAX 조회
			$scope.fnAjaxZCCODE = function(row) {
				var data = row.entity;
				if (row.entity.ZCCODE != null && row.entity.ZCCODE.length >= 5) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveAjaxZCCODE",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.ZCCODE == "" || result.ZCCODE == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.ZCCODE = result.ZCCODE; //차량코드
								row.entity.ZCTEXT = result.ZCTEXT; //차량코드명
							}
							scope.gridApi.grid.refresh();
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			};

			// 추가경비 변경 이벤트
			$scope.fnCHK_V = function(row) {
				console.log(row.entity.CHK_V);
				if(row.entity.CHK_V){
					row.entity.CHK = "X";
				}else{
					row.entity.CHK = null;
				}
			};

			// NCK 변경 이벤트
			$scope.fnNCK_V = function(row) {
				console.log(row.entity.NCK_V);
				if(row.entity.NCK_V){
					row.entity.NCK = "X";
				}else{
					row.entity.NCK = null;
				}
			};

			// 금액 콤마
			$scope.fnAddCommaWRBTR = function(row) {
				var d = row.entity.WRBTR.replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.WRBTR = addComma(num);
			};

			// 수량 콤마
			$scope.fnAddCommaMENGE = function(row) {
				var d = row.entity.MENGE.replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.MENGE = addComma(num);
			};

			// 상세조회
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};

			//차변, 대변
			$scope.SB_BSCHL = [ {
				"code_name" : "차변(40)",
				"code_id" : "40"
			}, {
				"code_name" : "대변(50)",
				"code_id" : "50"
			} ];

			//유통경로
			$scope.SB_VTWEG = [ {
				"code_name" : "-선택-",
				//2020-09-04 smh 
				//""값을 "0"으로 수정
				"code_id" : "0"
			}, {
				"code_name" : "마스터 공통 등록",
				"code_id" : "01"
			}, {
				"code_name" : "내수",
				"code_id" : "10"
			}, {
				"code_name" : "로컬",
				"code_id" : "20"
			}, {
				"code_name" : "로컬수출",
				"code_id" : "30"
			}, {
				"code_name" : "직수출",
				"code_id" : "40"
			} ];

			//매출구분
			$scope.SB_WW002 = [ {
				"code_name" : "-선택-",
				"code_id" : ""
			}, {
				"code_name" : "본사",
				"code_id" : "1"
			}, {
				"code_name" : "석포",
				"code_id" : "2"
			}, {
				"code_name" : "임대",
				"code_id" : "3"
			}, {
				"code_name" : "안성",
				"code_id" : "4"
			},{
				"code_name" : "안산",
				"code_id" : "5"
			} ];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : '차/대',
					field : 'BSCHL',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					pinnedLeft : true,
					cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.BSCHL">' + '	<option ng-repeat="SB_BSCHL in grid.appScope.SB_BSCHL" ng-selected="row.entity.BSCHL == SB_BSCHL.code_id" value="{{SB_BSCHL.code_id}}" >{{SB_BSCHL.code_name}}</option>' + '</select>'
				}, {
					displayName : '계정',
					field : 'HKONT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					pinnedLeft : true,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.HKONT" style="width: 75%;" on-model-change="grid.appScope.fnAjaxHKONT(row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(10, row)">'
				}, {
					displayName : '계정텍스트',
					field : 'ZGLTXT',
					//width : '110',
					minWidth : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : '집행부서',
					field : 'ZKOSTL',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.ZKOSTL" style="width: 75%;" on-model-change="grid.appScope.fnAjaxKOSTL(\'Z\',row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(11, row)">'
				}, {
					displayName : '집행부서명',
					field : 'ZKTEXT',
					width : '110',
					//minWidth : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : '코스트센터',
					field : 'KOSTL',
					width : '120',
					//minWidth : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.KOSTL" style="width: 75%;" on-model-change="grid.appScope.fnAjaxKOSTL(\'C\',row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(12, row)">'
				}, {
					displayName : '코스트센터명',
					field : 'LTEXT',
					width : '120',
					//minWidth : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : '가용예산',
					field : 'AVAIL_AMT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : 'N',
					field : 'NCK',
					width : '70',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="checkbox" ng-model="row.entity.NCK_V" ng-change="grid.appScope.fnNCK_V(row)">'
				}, {
					displayName : '금액',
					field : 'WRBTR',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input class="right" type="text" on-clipboard-pasted ng-model="row.entity.WRBTR" on-model-change="gon-model-changeope.fnAddCommaWRBTR(row)">',
				}, {
					displayName : '추가경비',
					field : 'CHK',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="checkbox" ng-model="row.entity.CHK_V" ng-change="grid.appScope.fnCHK_V(row)">'
				}, {
					displayName : '사업자등록번호',
					field : 'STCD2',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.STCD2" style="width: 75%;" on-model-change="grid.appScope.fnAjaxSTCD2(row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(13, row)">'
				}, {
					displayName : '거래처명',
					field : 'NAME1',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : 
						'<input ng-if="row.entity.NAME1_STATUS != null" type="text" on-clipboard-pasted ng-model="row.entity.NAME1" style="width: 100%;" />' +
						'<input ng-if="row.entity.NAME1_STATUS == null" type="text" on-clipboard-pasted ng-model="row.entity.NAME1" style="width: 100%;" readonly/>'
				}, {
					displayName : '텍스트',
					field : 'SGTXT',
					//width : '100',
					minWidth : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.SGTXT">'
				}, {
					displayName : 'WBS코드',
					field : 'POSID',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.POSID" style="width: 75%;" ng-blur="grid.appScope.fnAjaxPOSID(row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(14, row)">'
				}, {
					displayName : 'WBS코드명',
					field : 'POST1',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : '설비오더',
					field : 'AUFNR',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.AUFNR" style="width: 75%;" on-model-change="grid.appScope.fnAjaxAUFNR(row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(20, row)">'
				}, {
					displayName : '판매오더',
					field : 'VBELN',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.VBELN" style="width: 75%;" on-model-change="grid.appScope.fnAjaxVBELN(row, $event)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(16, row)">'
				}, {
					displayName : '유통경로',
					field : 'VTWEG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.VTWEG">' + '	<option ng-repeat="SB_VTWEG in grid.appScope.SB_VTWEG" ng-selected="row.entity.VTWEG == SB_VTWEG.code_id" value="{{SB_VTWEG.code_id}}" >{{SB_VTWEG.code_name}}</option>' + '</select>'
				}, {
					displayName : '자재그룹',
					field : 'MVGR1',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.MVGR1" style="width: 75%;" on-model-change="grid.appScope.fnAjaxMVGR1(row, $event)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(15, row)">'
				}, {
					displayName : '매출구분',
					field : 'WW002',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.WW002">' + '	<option ng-repeat="SB_WW002 in grid.appScope.SB_WW002" ng-selected="row.entity.WW002 == SB_WW002.code_id" value="{{SB_WW002.code_id}}" >{{SB_WW002.code_name}}</option>' + '</select>'
				}, {
					displayName : '수량',
					field : 'MENGE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input class="right" type="text" on-clipboard-pasted ng-model="row.entity.MENGE" on-model-change="grid.appScope.fnAddCommaMENGE(row)">'
				}, {
					displayName : '단위',
					field : 'MEINS',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.MEINS" style="width: 65%;" on-model-change="grid.appScope.fnAjaxMEINS(row, $event)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(17, row)">'
				}, {
					displayName : '구매오더',
					field : 'ZBSTKD',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.ZBSTKD">'
				}, {
					displayName : '기준일',
					field : 'VALUT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted class="dtp" ng-model="row.entity.VALUT">'
				}, {
					displayName : '지급기산일',
					field : 'ZFBDT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted class="dtp" ng-model="row.entity.ZFBDT">'
				}, {
					displayName : '차량코드',
					field : 'ZCCODE',
					width : '145',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false,
					cellTemplate : '<input type="text" on-clipboard-pasted ng-model="row.entity.ZCCODE" style="width: 120px;" on-model-change="grid.appScope.fnAjaxZCCODE(row, $event)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(18, row)">'
				}, {
					displayName : '차량코드명',
					field : 'ZCTEXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				}, {
					displayName : '거래처명',
					field : 'NAME1_STATUS',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					enableSorting : false
				} ]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(ev) {
					$(this).trigger("change");
					$('.datepicker').hide();
				});
			});

			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC : "Y", // RFC 여부
				RFC_TYPE : "FI", // RFC 구분
				RFC_FUNC : "ZWEB_LIST_DOCUMENT" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			// 복붙영역(앵귤러 이벤트들 가져오기) 끝

			// 전표유형 이벤트
			$(".doc_type").on("change", function() {
				fnDocTypeDisplay($(this).val());
			});

			// 합계계산 이벤트
			$("#sum_btn").on("click", function() {
				var sum_WRBTR = 0;
				$.each(scope.gridOptions.data, function(i,d){
					if(d.WRBTR === null){
						return true;
					}
					sum_WRBTR += Number(d.WRBTR.replace(/[^0-9]/g, ''));
				});
				$("#sum_WRBTR").text(addComma(sum_WRBTR));
			});
			
			// 항목추가 이벤트
			$("#add_btn").on("click", function() {
				scope.addRow({
					BSCHL : "40",
					HKONT : null,
					ZGLTXT : null,
					ZKOSTL : null,
					ZKTEXT : null,
					KOSTL : null,
					LTEXT : null,
					AVAIL_AMT : null,
					//2020-09-04  smh
					//처음 체크박스 풀어주기
					NCK_V : false,
					NCK : null,
					WRBTR : null,
					//2020-09-04  smh
					//처음 체크박스 풀어주기
					CHK_V : false,
					CHK : null,
					STCD2 : null,
					NAME1 : null,
					SGTXT : null,
					POSID : null,
					POST1 : null,
					AUFNR : null,
					VBELN : null,
					VTWEG : null,
					MVGR1 : null,
					WW002 : null,
					MENGE : null,
					MEINS : null,
					ZBSTKD : null,
					VALUT : null,
					ZFBDT : null,
					ZCCODE : null,
					ZCTEXT : null
				}, true, "ASC");
			});

			// 항목삭제 이벤트
			$("#remove_btn").on("click", function() {
				var selectedRows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(selectedRows)) {
					swalWarning("삭제할 항목을 선택하세요.");
					return false;
				}
				$.each(selectedRows, function(i, d) {
					// 선택된 데이터 삭제
					scope.gridOptions.data.splice(scope.gridOptions.data.indexOf(d), 1);
				});
				// 그리드 새로고침
				scope.gridApi.grid.refresh();
			});

			// 전기일 변경 이벤트
			$("input[name=BUDAT]").on("change", function() {
				if ($("input[name=BLDAT]").val() == "") {
					$("input[name=BLDAT]").val($("input[name=BUDAT]").val());
				}
			});

			// 통화 AJAX 조회
			$("input[name=WAERS]").on("keydown", function(e) {
				if ((e.which == 13 || e.which == 9) && !$(this).is("[readonly]")) {
	 				e.preventDefault();
					if ($("input[name=WAERS]").val().length >= 2) {
						if ($("input[name=BUDAT]").val() == "") {
							swalWarningCB("전기일을 입력하세요.");
							return false;
						}
						$.ajax({
							url : "/yp/zfi/doc/retrieveWAERSonblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.WAERS == "" || result.WAERS == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=WAERS]").val(result.WAERS); //통화코드
									$("input[name=KURSF]").val(result.KURSF); //환율
									$("input[name=KURSF]").focus();
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
					var num = unComma($("input[name=KURSF]").val());
					num = num * 1;
					$("input[name=KURSF]").val(addComma(num));
				}
			}).on("focusout", function() {
				if (!$(this).is("[readonly]")) {
					if ($("input[name=WAERS]").val().length >= 2) {
						if ($("input[name=BUDAT]").val() == "") {
							swalWarningCB("전기일을 입력하세요.");
							return false;
						}
						$.ajax({
							url : "/yp/zfi/doc/retrieveWAERSonblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.WAERS == "" || result.WAERS == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=WAERS]").val(result.WAERS); //통화코드
									$("input[name=KURSF]").val(result.KURSF); //환율
									$("input[name=KURSF]").focus();
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
					var num = unComma($("input[name=KURSF]").val());
					num = num * 1;
					$("input[name=KURSF]").val(addComma(num));
				}
			});

			// 공급업체 AJAX 조회
			$("input[name=LIFNR]").on("keydown change", function(e) {
				if (e.which == 13 || e.type === "change") {
					e.preventDefault();
					if ($("input[name=LIFNR]").val().length >= 6) {
						$.ajax({
							url : "/yp/zfi/doc/retrieveLIFNRonblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.LIFNR == "" || result.LIFNR == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=LIFNR]").val(result.LIFNR); //공급업체 코드
									$("input[name=STCD2]").val(result.STCD2); //사업자번호
									$("input[name=NAME1]").val(result.NAME1); //상호명
									$("input[name=HKONT]").val(result.HKONT); //계정과목
									$("input[name=TXT_50]").val(result.TXT_50); //계정과목 설명
									$("input[name=BANKN]").val(result.BANKN); //계좌번호
									$("input[name=BVTYP]").val(result.BVTYP); //은행유형
									$("input[name=KTOKK]").val(result.KTOKK); //계정그룹
									$("input[name=ZTERM]").val(result.ZTERM); //지급조건
									$("input[name=TEXT_ZTERM]").val(result.TEXT1); //지급조건 설명
									//fnBANKNinput();
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			// 지급조건 AJAX 조회
			$("input[name=ZTERM]").on("keydown", function(e) {
				if (e.which == 13) {
					e.preventDefault();
					if ($("input[name=ZTERM]").val().length >= 4) {
						$.ajax({
							url : "/yp/zfi/doc/retrieveZTERMonblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.ZTERM == "" || result.ZTERM == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=ZTERM]").val(result.ZTERM); //지급조건
									$("input[name=TEXT_ZTERM]").val(result.TEXT1); //지급조건 설명
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			// 계정과목 AJAX 조회
			$("input[name=HKONT]").on("keydown change", function(e) {
				if (e.which == 13 || e.type === "change") {
					e.preventDefault();
					if ($("input[name=HKONT]").val().length >= 8) {
						$.ajax({
							url : "/yp/zfi/doc/retrieveSAKNRonblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.ABWHK == "" || result.ABWHK == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=HKONT]").val(result.ABWHK); //계정과목
									$("input[name=TXT_50]").val(result.TXT20); //계정과목 설명
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			// 세금코드 AJAX 조회
			$("input[name=MWSKZ]").on("keydown change", function(e) {
				if (e.which == 13 || e.type === "change") {
					e.preventDefault();
					if ($("input[name=MWSKZ]").val().length >= 2) {
						$.ajax({
							url : "/yp/zfi/doc/retrieveTAXPConblur",
							type : "POST",
							cache : false,
							async : true,
							data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.MWSKZ == "" || result.MWSKZ == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									$("input[name=MWSKZ]").val(result.MWSKZ); //세금코드
									$("input[name=TEXT1]").val(result.TEXT1); //세금코드 설명
									dt10Show();
								}
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			// 은행정보 AJAX 조회
			$("input[name=BVTYP]").on("change", function() {
				if ($("input[name=BVTYP]").val().length >= 3) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zfi/doc/retrieveBANKAonblur",
						type : "POST",
						cache : false,
						async : true,
						data : {
							"BVTYP" : $("input[name=BVTYP]").val()
						},
						dataType : "json",
						success : function(result) {
							if (result.E_FLAG == "S") {
								swalInfoCB(result.BANKA);
							} else {
								swalWarningCB(result.E_MESSAGE);
							}
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete : function() {
							$('.wrap-loading').addClass('display-none');
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});

			// 등록
			$("#reg_btn").click(function() {
				if (fnValidationForm() && fnValidationTr()) {
					if (confirm("등록하시겠습니까?")) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						var data = $("#regfrm").serializeArray();
						data.push({name: "row_no", value: JSON.stringify(scope.gridOptions.data)});
						$.ajax({
							url : "/yp/zfi/doc/createDocument",
							type : "POST",
							cache : false,
							async : true,
							data : data,
							// data : $("#regfrm").serialize(),
							dataType : "json",
							success : function(result) {
								if (result.flag == "S") {
									swalSuccessCB("전표가 등록되었습니다.\n(전표번호 : " + result.msg + ")");
									$("#reg_btn").hide();
									fnAddDocTable(result.msg);
								} else {
									swalWarningCB(result.msg);
								}
							},
							beforeSend : function(xhr) {
								// 2019-10-23 khj - for csrf
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			// 결재상신
			$("#BELNR_btn").on("click", function() {
				fnDocWrite();
			});

			// 전표유형 세팅
			$(".doc_type:eq(0)").trigger("change");

			// 회계전표 목록 > 선택 빠른전표의 경우에 데이터 조회하는 기능
			$("input[name=LIFNR]").trigger("change");
			$("input[name=HKONT]").trigger("change");
			$("input[name=MWSKZ]").trigger("change");
			<c:choose>
			<c:when test="${fn:length(req_data.TRF) >= 1}">
				<c:forEach var="list" items="${req_data.TRF}" varStatus="i">
				$("#add_btn").trigger("click");
				scope.gridOptions.data[${i.index}].BSCHL = "${list.BSCHL}";
				scope.gridOptions.data[${i.index}].HKONT = "${list.HKONT}";
				scope.gridOptions.data[${i.index}].ZGLTXT = "${list.TXT_50}";
				scope.gridOptions.data[${i.index}].ZKOSTL = "${list.ZKOSTL}";
				scope.gridOptions.data[${i.index}].ZKTEXT = "${list.ZKTEXT}";
				scope.gridOptions.data[${i.index}].KOSTL = "${list.KOSTL}";
				scope.gridOptions.data[${i.index}].WRBTR = "${list.WRBTR}";
				scope.gridOptions.data[${i.index}].LTEXT = "${list.LTEXT}";
				scope.gridOptions.data[${i.index}].AVAIL_AMT = "${list.AVAIL_AMT}";
				scope.gridOptions.data[${i.index}].STCD2 = "${list.STCD2}";
				scope.gridOptions.data[${i.index}].NAME1 = "${list.NAME1}";
				scope.gridOptions.data[${i.index}].SGTXT = "${list.SGTXT}";
				scope.gridOptions.data[${i.index}].POSID = "${list.POSID}";
				scope.gridOptions.data[${i.index}].POST1 = "${list.POST1}";
				scope.gridOptions.data[${i.index}].AUFNR = "${list.AUFNR}";
				scope.gridOptions.data[${i.index}].VBELN = "${list.VBELN}";
				//2020-09-04 smh VTWEG값 0을 빈값으로 바꿔줌.
				scope.gridOptions.data[${i.index}].VTWEG = "${list.VTWEG}" == 0 ?"":"${list.VTWEG}";
				scope.gridOptions.data[${i.index}].MVGR1 = "${list.MVGR1}";
				scope.gridOptions.data[${i.index}].MENGE = "${list.MENGE}";
				scope.gridOptions.data[${i.index}].MEINS = "${list.MEINS}";
				scope.gridOptions.data[${i.index}].ZBSTKD = "${list.ZBSTKD}";
				scope.gridOptions.data[${i.index}].VALUT = "${list.VALUT}";
				scope.gridOptions.data[${i.index}].ZFBDT = "${list.ZFBDT}";
				scope.gridOptions.data[${i.index}].ZCCODE = "${list.ZCCODE}";
				scope.gridOptions.data[${i.index}].ZCTEXT = "${list.ZCTEXT}";
				console.log(scope.gridOptions.data[${i.index}].WRBTR);
				</c:forEach>
			</c:when>
			<c:otherwise>
			// 거래처등록 1행 세팅
			$("#add_btn").trigger("click");
			</c:otherwise>
			</c:choose>
			
			<%--
				YPWEBPOTAL-16 차량계량 정산 > 전자결재 상태값 변경 오류 및 전표번호 리턴 오류
				업데이트를 위한 CALC_CODE 키값 parameter 전달
				FI_DOC_NO(전표번호) 업데이트를 위한 신규 메서드 추가 
			--%>
			<c:if test="${req_data.data != null}">
			$(JSON.parse('${req_data.data}')).each(function(idx, item){
				$('input[name=CALC_CODE]').val(item.CALC_CODE);
			});
			</c:if>

		});

		// 등록후 전표정보 표시
		function fnAddDocTable(BELNR) {
			$("#BELNR").prepend("<a style='font-size:large; text-decoration:underline; color:blue;' href='javascript: fnDocumentPop(\""+BELNR+"\")';>"+BELNR+"</a>");
			$("input[name=BELNR]").val(BELNR);
			$('.jp_area').show()
		}

		function fnPreAddZero(num) {
			num = num + "";
			var length = num.length;
			for (var i = 10; i > length; i--) {
				num = "0" + num;
			}
			return num;
		}

		// 전표 조회
		function fnDocumentPop(data) {
			var BELNR = fnPreAddZero(data);
			var BUDAT = $("input[name=BUDAT]").val();

			var w = window.open("about:blank", "회계전표", "width=1200,height=900,location=yes,scrollbars=yes");

			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zfi/doc/select_rtrv_doc",
				type : "post",
				cache : false,
				async : true,
				data : {
					BELNR : BELNR,
					BUDAT : BUDAT
				},
				dataType : "json",
				success : function(result) {
					if (result.docno == "") {
						w.location.href = '<spring:eval expression="@config['gw.url']"/>'+"/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=2018년 본사/전산팀 지출품의 제 xxxxx호";
					} else {
						w.location.href = '<spring:eval expression="@config['gw.url']"/>'+"/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=" + result.docno;
					}
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(xhr, statusText) {
					console.error("code:" + xhr.status + " - " + "message:" + xhr.statusText, xhr);
					swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		};

		// 기본정보, 구매처정보 발리데이션 체크
		function fnValidationForm(){
			var tax_code = $("input[name=MWSKZ]").val();
			if($("select[name=BUPLA]").val() == ""){
				swalWarningCB("사업장을 선택하세요.");
				return false;
			}else if($("input[name=BUDAT]").val() == ""){
				swalWarningCB("전기일을 입력하세요.");
				return false;
			}else if($("input[name=BUDAT]").val() != $("input[name=BLDAT]").val()){
				swalWarningCB("전기일과 증빙일이 일치하지 않습니다.");
				return false;
			}else if($("input[name=LIFNR]").val() == ""){
				swalWarningCB("공급업체를 입력하세요.");
				return false;
			}else if($("input[name=ZTERM]").val() == ""){
				swalWarningCB("지급조건을 입력하세요.");
				return false;
			}else if($("input[name=HKONT]").val() == ""){
				swalWarningCB("계정과목을 입력하세요.");
				return false;
			}else if($("input[name=MWSKZ]").val() == "" && $("input[name=doc_type]:checked").val() != "5"){
				swalWarningCB("세금코드를 입력하세요.");
				return false;
			}else if($("input[name=ZSUPAMT]").val() == ""){
				swalWarningCB("공급가액을 입력하세요.");
				return false;
			}else if($("input[name=BKTXT]").val() == ""){
				swalWarningCB("전표텍스트를 입력하세요.");
				return false;
			}else if($("input[name=SGTXT]").val() == ""){
				swalWarningCB("텍스트를 입력하세요.");
				return false;
			}else if($("input[name=BVTYP]").val() == ""){
				if($("input[name=MWSKZ]").val() == "16" || $("input[name=MWSKZ]").val() == "17" || $("input[name=MWSKZ]").val() == "20"){
					//console.log("계좌번호X:세금코드");
					return true;
				}else if($("input[name=LIFNR]").val().substr(0,1) == "Y" || $("input[name=LIFNR]").val() == "599999"){
					//console.log("계좌번호X:사원코드 or 기타거래처");
					return true;
				}else if($("input[name=ZTERM]").val() == "0100" || $("input[name=ZTERM]").val() == "G100"){
					//console.log("계좌번호X:지급조건");
					return true;
				}else if($("input[name=KTOKK]").val() == "8000"){
					//console.log("계좌번호X:법인카드");
					return true;
				}else if($("input[name=doc_type]:checked").val() == "5"){
					//console.log("수입전표");
					return true;
				}else{
					swalWarningCB("은행정보를 입력하세요.");
					return false;
				}
			//ver.03 추가 ( ||tax_code == "" ver.04추가)
			}else if(tax_code == "14" || tax_code == "15" || tax_code == "17" || tax_code == "19" || tax_code == "20" || tax_code == "22" ||  tax_code == "24" 
				|| tax_code == "32" || tax_code == "34" || tax_code == "35" || tax_code == "40" || tax_code == ""){
				console.log("세액 0원");
			}else{
				var pay = unComma($("input[name=ZSUPAMT]").val().replace(/[^0-9]/g, ''));
				var tax = unComma($("input[name=WMWST]").val().replace(/[^0-9]/g, ''));
				console.log(tax*1 <= pay*0.11);
				console.log(tax*1 >= pay*0.09)
				if(tax*1 <= pay*0.11 && tax*1 >= pay*0.09){
					console.log("세액계산 맞겠지?");
				}else{
					swalWarningCB("공급가액과 세액을 다시 확인해 주세요.");
					return false;
				}
			}
			//ver.03 추가 끝
			return true;
		}

		// 구매처정보 발리데이션 체크
		function fnValidationTr(){
			var d = scope.gridOptions.data;

			var tr_length = d.length;
			for(var i=0; i<tr_length; i++){
				if(d[i].HKONT == ""){
					swalWarningCB((i+1) + "번째 개별항목 계정을 입력하세요.");
					return false;
//				}else if($("input[name=HKONT_"+i+"]").val() == "43308401"){	//19.04 설비오더 관련 추가
//					if($("input[name=AUFNR_"+i+"]").val() == ""){
//						alert("해당계정은 설비오더 필수입력 사항입니다.");
//						return false;
//					}
//				}else if($("input[name=ZKOSTL_"+i+"]").val() == ""){
//					if($("input[name=HKONT_"+i+"]").val() == "43308401"){//19.04 설비오더 관련 추가
//						console.log("집행부서 미입력 허용");
//					}else{
//						alert((i+1) + "번째 개별항목 집행부서를 입력하세요.");
//						return false;
//					}
				}else if(d[i].KOSTL == ""){
					if($("input[name=doc_type]:checked").val() == "4" && d[i].POSID != ""){
						console.log("코스트센터 미입력 허용");
//					}else if($("input[name=HKONT_"+i+"]").val() == "43308401"){//19.04 설비오더 관련 추가
//						console.log("코스트센터 미입력 허용");
					}else{
						swalWarningCB((i+1) + "번째 개별항목 코스트센터를 입력하세요.");
						return false;
					}
				}else if(d[i].WRBTR == ""){
					swalWarningCB((i+1) + "번째 개별항목 금액을 입력하세요.");
					return false;
//				}else if($("input[name=STCD2]").val() == ""){
//					if($("input[name=STCD2_"+i+"]").val() == ""){
//						alert((i+1) + "번째 사업자등록번호를  입력하세요.");
//						return false;
//					}
				}else if(d[i].SGTXT == ""){
					swalWarningCB((i+1) + "번째 개별항목 텍스트를 입력하세요.");
					return false;
				}else if($("input[name=doc_type]:checked").val() == "3"){
					if(d[i].ZCCODE == ""){
						swalWarningCB((i+1) + "번째 개별항목 차량코드를 입력하세요.");
						return false;
					}
				}
			}
			return true;
		}

		// 가용예산 조회
		function fnAvailAMT(row) {
			if (row.entity.HKONT != "" && row.entity.ZKOSTL != "" && row.entity.KOSTL != "") {
				var data = row.entity;
				data.BUPLA = $('[name=BUPLA] :checked').val();
				data.BUDAT = $("input[name=BUDAT]").val();

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zfi/doc/retrieveBUDGET",
					type : "POST",
					cache : false,
					async : true,
					data : data,
					dataType : "json",
					success : function(result) {
						row.entity.AVAIL_AMT = addComma(result.amt);
						scope.gridApi.grid.refresh();
					},
					beforeSend : function(xhr) {
						// 2019-10-23 khj - for csrf
						xhr.setRequestHeader(header, token);
						$('.wrap-loading').removeClass('display-none');
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
						swalDangerCB("가용예산 조회에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
		}

		// 사용안됨
		function fnBANKNinput() {
			//서린상사(해외영업팀) 사용자가 기타거래처 입력시 은행정보 직접입력 활성화 20.02.28
			console.log("$%^" + $("#userDeptCd").val());
			if ($("input[name=LIFNR]").val() == "599999" && $("#userDeptCd").val() == "D188102476") { //운영 D188102476
				$("input[name=BVTYP]").attr("readonly", false);
				$("input[name=BANKN]").attr("readonly", false);
				//				$("#btBA").css("display","inline");
			} else {
				$("input[name=BVTYP]").attr("readonly", true);
				$("input[name=BANKN]").attr("readonly", true);
				//				$("#btBA").css("display","none");
			}
		}

		// 사용안됨
		function fnPreDelZero(num1) {
			var num = num1 + "";
			var length = num.length;
			console.log(length);
			if (num.substring(0, 1) == "0") {
				num = num.substring(1);
			}
			return num;
		}

		//전자결재 문서선택 팝업
		function fnDocWrite() {
			var BELNR = $("input[name=BELNR]").val();
			var BUDAT = $("input[name=BUDAT]").val();

			var w = window.open("about:blank", "임시전표 전자결재 상신", "width=400, height=500");

			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var popForm = document.createElement("form");

			popForm.name = "sndFrm";
			popForm.method = "post";
			popForm.target = "임시전표 전자결재 상신";
			popForm.action = "/yp/popup/zfi/doc/createDocWritePage";

			document.body.appendChild(popForm);

			popForm.appendChild(csrf_element);

			var pr = {
				FROM : "zfi_doc_create",
				BELNR : BELNR,
				BUDAT : BUDAT
			};

			$.each(pr, function(k, v) {
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}

		//전자결재 상신 팝업
		function fnDocWriteGW(url) {
			var newwin = window.open(url, "전자결재 상신하기", "width=800,height=600,scrollbars=yes,resize=yes");
			if (newwin == null) {
				swalDangerCB("팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요.");
			}
		}

		var default_hide = [ 8, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27 ];
		var type_1 = [ 11, 12 ]; // $(".dt5").show();
		var type_2 = [ 11, 12, 17, 18, 19, 20 ]; // $(".dt5,.dt2,.dt6").show();
		var type_3 = [ 11, 12, 20, 26, 27 ]; // $(".dt5,.dt3,.dt6").show();
		var type_4 = [ 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 ]; // $(".dt2,.dt4,.dt5,.dt6").show();
		var type_5 = [ 8, 20 ]; // $(".dt6,.dt7").show();

		function fnDocTypeDisplay(type) {
			dt10Show();

			if (type == "2") {
				type_2_Show();
				$("#pre_sum").attr("colspan", "9");
				$("#post_sum").attr("colspan", "7");
				$("#indiv").css("width", "1630px");
				$("#currency_type").removeAttr("readonly");
				$("#currency").show();
				$("#cur_sch").show();
				$("input[name=ZEXPAMT]").attr("readonly", false);
				$("input[name=WSKTO]").attr("readonly", false);
				$("#AGKOA").hide();
			} else if (type == "3") {
				type_3_Show();
				$("#currency_type").attr("readonly", "readonly");
				$("#currency").hide();
				$("#cur_sch").hide();
				$("input[name=ZEXPAMT]").attr("readonly", false);
				$("input[name=WSKTO]").attr("readonly", false);
				$("#AGKOA").hide();
			} else if (type == "4") {
				type_4_Show();
				$("#currency_type").removeAttr("readonly");
				$("#currency").show();
				$("#cur_sch").show();
				$("input[name=ZEXPAMT]").attr("readonly", false);
				$("input[name=WSKTO]").attr("readonly", false);
				$("#AGKOA").hide();
			} else if (type == "5") {
				type_5_Show();
				$("#currency_type").removeAttr("readonly");
				$("#currency").show();
				$("#cur_sch").show();
				$("input[name=ZEXPAMT]").attr("readonly", true);
				$("input[name=WSKTO]").attr("readonly", true);
				$("#AGKOA").show();
			} else {
				type_1_Show();
				$("#currency_type").attr("readonly", "readonly");
				$("#currency").hide();
				$("#cur_sch").hide();
				$("input[name=ZEXPAMT]").attr("readonly", false);
				$("input[name=WSKTO]").attr("readonly", false);
				$("#AGKOA").hide();
			}
		}

		function dt10Show() {
			if ($("input[name=MWSKZ]").val() == "14" || $("input[name=MWSKZ]").val() == "15") {
				scope.gridOptions.columnDefs[10].visible = true;
			} else {
				scope.gridOptions.columnDefs[10].visible = false;
			}
			scope.gridApi.grid.refresh();
		}
		function type_1_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 전표유형 - 일반
			$.each(type_1, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_2_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 전표유형 - 판매
			$.each(type_2, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_3_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 전표유형 - 차량
			$.each(type_3, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_4_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 전표유형 - 기타
			$.each(type_4, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_5_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 전표유형 - 수입
			$.each(type_5, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function fnAutoCompute() {
			var tax_code = $("input[name=MWSKZ]").val();
			var tax_percent = 10;
			var payment = unComma($("input[name=ZSUPAMT]").val()).replace(/[^0-9]/g, '');
			var discount = $("input[name=WSKTO]").val() == "" ? 0 : unComma($("input[name=WSKTO]").val()).replace(/[^0-9]/g, '');
			var addition_amount = $("input[name=ZEXPAMT]").val() == "" ? 0 : unComma($("input[name=ZEXPAMT]").val()).replace(/[^0-9]/g, '');

			if ($("input[name=doc_type]:checked").val() == "5" && tax_code == "") {
				$("input[name=WMWST]").val(0);
				$("input[name=ZTOPAY]").val(addComma(payment));

			} else if (tax_code == "" || payment == "") {
				$("input[name=ZTOPAY]").val(0);
				//return false;
			} else {
				if (tax_code == "14" || tax_code == "15" || tax_code == "17" || tax_code == "19" || tax_code == "20" || tax_code == "22" || tax_code == "24" || tax_code == "32" || tax_code == "34" || tax_code == "35" || tax_code == "40") {
					tax_percent = 0;
				}
				//2018.12.06 공급가액 변경시 세액 재계산을 위한 주석	
				//				if($("input[name=WMWST]").val() == "" || $("input[name=WMWST]").val() == 0){//세액을 수동입력 했을때 (세금코드 변경시에는 확인불가)
				//					$("input[name=WMWST]").val(addComma(payment * tax_percent / 100));
				//				}
				//2018.12.06 공급가액 변경시 세액 재계산을 위한 추가	
				$("input[name=WMWST]").val(addComma(payment * tax_percent / 100));
				//				$("input[name=ZTOPAY]").val(addComma(payment*1 + addition_amount*1 - discount*1 +(payment * tax_percent / 100)));
			}
			//			$("input[name=WSKTO]").val(addComma(discount));
			//			$("input[name=ZEXPAMT]").val(addComma(addition_amount));
			//			$("input[name=ZSUPAMT]").val(addComma(payment));
			fnAutoComputeTaxManual();
		}
		function fnAutoComputeTaxManual() {
			//var tax = Math.round(unComma($("input[name=WMWST]").val().replace(/[^0-9]/g, '')));
			//var payment = unComma($("input[name=ZSUPAMT]").val().replace(/[^0-9]/g, ''));
			//var discount = unComma($("input[name=WSKTO]").val().replace(/[^0-9]/g, ''));
			//var addition_amount = unComma($("input[name=ZEXPAMT]").val().replace(/[^0-9]/g, ''));
			//$("input[name=WMWST]").val(addComma(tax));
			//$("input[name=WSKTO]").val(addComma(discount));
			//$("input[name=ZEXPAMT]").val(addComma(addition_amount));
			//$("input[name=ZSUPAMT]").val(addComma(payment));
			//$("input[name=ZTOPAY]").val(addComma(payment * 1 + tax * 1 - discount * 1 + addition_amount * 1));

			//2020-09-04 smh
			//소수점 표시를 위해서 위코드를 아래로 수정
			var tax = Math.round(unComma($("input[name=WMWST]").val()));
			var payment = unComma($("input[name=ZSUPAMT]").val());
			var discount = unComma($("input[name=WSKTO]").val());
			var addition_amount = unComma($("input[name=ZEXPAMT]").val());
			$("input[name=WMWST]").val(addComma(tax));
			$("input[name=WSKTO]").val(addComma(discount));
			$("input[name=ZEXPAMT]").val(addComma(addition_amount));
			$("input[name=ZSUPAMT]").val(addComma(payment));
			$("input[name=ZTOPAY]").val(addComma(payment*1 + tax*1 - discount*1 + addition_amount*1));
		}
		function fnSearchPopup(type, target) {
			if (type == "1") {
				window.open("", "업체 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveLIFNR", "업체 검색", {
					type : "F"
				});
			} else if (type == "2") {
				window.open("", "계정과목 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveSAKNR", "계정과목 검색", {});
			} else if (type == "3") {
				var doc = $("input[name=doc_type]:checked").val();
				window.open("", "세금코드 선택", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveTAXPC", "세금코드 선택", {
					doc_type : doc
				});
			} else if (type == "4") {
				var LIFNR = $("input[name='LIFNR']").val();
				window.open("", "은행 선택", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveBANKN", "은행 선택", {
					LIFNR : LIFNR
				});
			} else if (type == "5") {
				if ($("input[name=BUDAT]").val() != "") {
					window.open("", "통화 검색", "width=600, height=800");
					fnHrefPopup("/yp/popup/zfi/doc/retrieveWAERS", "통화 검색", {});
				} else {
					swalWarningCB("전기일을 먼저 입력하세요.");
				}
			} else if (type == "6") {
				// 2020-07-24 jamerl - 사용안됨
				window.open("", "은행번호 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveBANKA", "은행번호 검색", {});
			} else if (type == "10") {
				window.open("", "계정과목 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveHKONT", "계정과목 검색", {
					target : target
				});
			} else if (type == "11") {
				window.open("", "집행부서 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveKOSTL", "집행부서 검색", {
					type : "Z",
					target : target
				});
			} else if (type == "12") {
				window.open("", "코스트센터 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveKOSTL", "코스트센터 검색", {
					type : "C",
					target : target
				});
			} else if (type == "13") {
				window.open("", "업체 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveLIFNR", "업체 검색", {
					type : "T",
					target : target
				});
			} else if (type == "14") {
				window.open("", "WBS코드 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrievePOSID", "WBS코드 검색", {
					target : target
				});
			} else if (type == "15") {
				window.open("", "자재그룹 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveMVGR", "자재그룹 검색", {
					type : "T",
					target : target
				});
			} else if (type == "16") {
				window.open("", "판매오더 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveVBELN", "판매오더 검색", {
					target : target
				});
			} else if (type == "17") {
				window.open("", "단위 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveMEINS", "단위 검색", {
					target : target
				});
			} else if (type == "18") {
				window.open("", "차량 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveZCCODE", "차량 검색", {
					target : target
				});
			} else if (type == "19") {
				window.open("", "지급조건 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveZTERM", "지급조건 검색", {});
			} else if (type == "20") {
				window.open("", "설비오더 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zfi/doc/retrieveAUFNR", "설비오더 검색", {
					target : target
				});
			}
		}
		function fnHrefPopup(url, target, pr) {
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var popForm = document.createElement("form");

			popForm.name = "popForm";
			popForm.method = "post";
			popForm.target = target;
			popForm.action = url;

			document.body.appendChild(popForm);

			popForm.appendChild(csrf_element);

			$.each(pr, function(k, v) {
				// console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}
	</script>
</body>