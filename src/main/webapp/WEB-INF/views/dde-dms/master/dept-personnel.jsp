<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>부서 공정별 인원 관리</title>
    <style>
        body { margin: 0; font-family: 'Malgun Gothic'; background: #f4f6f9; display: flex; flex-direction: column; height: 100vh; }
        .main-container { display: flex; flex: 1; overflow: hidden; }
        
        /* 사이드바 스타일 */
        .sub-sidebar { width: 300px; background: #fff; border-right: 1px solid #ddd; display: flex; flex-direction: column; }
        .dept-list { overflow-y: auto; list-style: none; padding: 0; margin: 0; }
        .dept-item { padding: 15px 20px; border-bottom: 1px solid #f1f1f1; cursor: pointer; display: flex; justify-content: space-between; align-items: center; }
        .dept-item.active { background: #e7f1ff; color: #007bff; font-weight: bold; border-left: 4px solid #007bff; }
        .dept-item .count { font-size: 12px; color: #888; }

        /* 메인 테이블 스타일 */
        .content-area { flex: 1; padding: 25px; background: #fff; overflow-y: auto; }
        .custom-table { width: 100%; border-collapse: collapse; text-align: center; border-top: 2px solid #007bff; }
        .custom-table th { background: #e7f1ff; padding: 12px; border: 1px solid #dee2e6; }
        .custom-table td { padding: 12px; border: 1px solid #dee2e6; }
        .custom-table tr:hover { background: #f8f9fa; cursor: pointer; }
        
        .btn-orange { background: #fd7e14; color: #fff; border: none; padding: 8px 20px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        
        /* 모달 스타일 */
        .modal-backdrop { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999; }
        .modal { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; padding: 25px; border-radius: 8px; z-index: 1000; width: 350px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .modal.show, .modal-backdrop.show { display: block; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <div class="main-container">
        <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" />

        <div class="sub-sidebar">
            <div style="padding:20px; border-bottom:1px solid #eee;">
                <h3>부서 목록</h3>
            </div>
            <ul class="dept-list" id="deptListUl">
                <li class="dept-item active" onclick="selectDept('', this)"><div>전체 보기</div></li>
                <c:set var="prevDept" value="" />
                <c:forEach var="p" items="${processCodeList}">
                    <c:if test="${p.deptName ne prevDept}">
                        <li class="dept-item" onclick="selectDept('${p.deptName}', this)">
                            <div>
                                <div>${p.deptName}</div>
                                <div class="count">총 ${p.empCount}명</div>
                            </div>
                        </li>
                        <c:set var="prevDept" value="${p.deptName}" />
                    </c:if>
                </c:forEach>
            </ul>
        </div>

        <div class="content-area">
            <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
                <h2 style="margin:0;">부서 공정별 인원 관리</h2>
                <div style="display:flex; border:1px solid #ddd; border-radius:4px; overflow:hidden;">
                    <input type="text" id="keyword" placeholder="성명 검색" style="border:none; padding:8px;" onkeyup="if(event.keyCode==13)loadData()">
                    <button onclick="loadData()" style="border:none; background:#fff; cursor:pointer; padding:0 10px;">🔍</button>
                </div>
            </div>

            <table class="custom-table">
                <thead><tr><th>이름</th><th>휴대전화</th><th>부서</th><th>공정</th></tr></thead>
                <tbody id="tableBody"></tbody>
            </table>
        </div>
    </div>

    <div class="modal-backdrop" id="backdrop"></div>
    <div class="modal" id="editModal">
        <h3>공정 변경</h3>
        <input type="hidden" id="modalUsrId">
        <p>이름: <b id="modalName"></b></p>
        <p>부서: <span id="modalDept"></span></p>
        <div style="margin-top:15px;">
            <label>공정 선택:</label>
            <select id="modalProcessSelect" style="width:100%; padding:10px; margin-top:8px;"></select>
        </div>
        <div style="margin-top:25px; text-align:right;">
            <button onclick="closeModal()">취소</button>
            <button class="btn-orange" onclick="saveProcess()">저장</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        var selectedDept = "";
        var processOptions = {}; // 부서별 공정 맵

        $(document).ready(function() {
            // 서버에서 넘어온 전체 부서/공정 리스트를 자바스크립트 객체로 정리
            <c:forEach var="p" items="${processCodeList}">
                if(!processOptions["${p.deptName}"]) processOptions["${p.deptName}"] = [];
                processOptions["${p.deptName}"].push("${p.processName}");
            </c:forEach>
            loadData();
        });

        function selectDept(dept, el) {
            $(".dept-item").removeClass("active");
            $(el).addClass("active");
            selectedDept = dept;
            loadData();
        }

        function loadData() {
            $.ajax({
                url: "${pageContext.request.contextPath}/dde-dms/master/emp-process/search",
                type: "POST",
                data: { deptName: selectedDept, keyword: $("#keyword").val() },
                success: function(res) {
                    var html = "";
                    if(res.data && res.data.length > 0) {
                        res.data.forEach(function(item) {
                            html += "<tr onclick='openModal(\""+item.usrId+"\",\""+item.userName+"\",\""+item.deptName+"\",\""+(item.processNm||"")+"\")'>";
                            html += "<td>"+item.userName+"</td><td>"+(item.cellPhone||"-")+"</td><td>"+item.deptName+"</td>";
                            html += "<td style='color:#007bff; font-weight:bold;'>"+(item.processNm||"사무실")+"</td></tr>";
                        });
                    } else {
                        html = "<tr><td colspan='4'>데이터가 없습니다.</td></tr>";
                    }
                    $("#tableBody").html(html);
                }
            });
        }

        function openModal(id, name, dept, current) {
            $("#modalUsrId").val(id); $("#modalName").text(name); $("#modalDept").text(dept);
            var $sel = $("#modalProcessSelect").empty();
            
            // 해당 부서의 공정 리스트 채우기
            if(processOptions[dept]) {
                processOptions[dept].forEach(function(p) {
                    var sel = (p === current) ? "selected" : "";
                    $sel.append('<option value="'+p+'" '+sel+'>'+p+'</option>');
                });
            } else {
                $sel.append('<option value="사무실">사무실</option>');
            }
            $("#editModal, #backdrop").addClass("show");
        }

        function closeModal() { $("#editModal, #backdrop").removeClass("show"); }

        function saveProcess() {
            $.ajax({
                url: "${pageContext.request.contextPath}/dde-dms/master/emp-process/save",
                type: "POST",
                data: { usrId: $("#modalUsrId").val(), processNm: $("#modalProcessSelect").val() },
                success: function() { alert("저장되었습니다."); closeModal(); loadData(); }
            });
        }
    </script>
</body>
</html>