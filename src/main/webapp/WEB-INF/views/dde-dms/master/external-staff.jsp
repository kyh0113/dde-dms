<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>외부 인력 관리</title>
<style>
    /* 공통 스타일 */
    body { margin: 0; padding: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; }
    .main-container { display: flex; } 
    
    .content-area {
        flex: 1; 
        padding: 30px 3%; 
        background-color: #ffffff;
        min-height: 100vh;
    }

    .top-controls {
        display: flex;
        justify-content: space-between; 
        align-items: center;
        margin-bottom: 15px;
        padding: 10px 0;
        border-bottom: 1px solid #eee;
    }

    .search-box {
        display: flex;
        align-items: center;
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 5px;
    }
    .search-select { border: none; outline: none; padding: 5px; font-size: 14px; color: #333; }
    .search-input { border: none; border-left: 1px solid #ddd; outline: none; padding: 5px 10px; font-size: 14px; width: 200px; }
    .search-btn { background-color: #007bff; color: white; border: none; padding: 6px 15px; border-radius: 3px; cursor: pointer; font-size: 14px; margin-left: 5px; }

    .btn-group button { padding: 8px 16px; border: none; cursor: pointer; font-size: 14px; border-radius: 4px; margin-left: 5px; color: white; font-weight: bold; }
    .btn-delete { background-color: #495057; } 
    .btn-edit { background-color: #fd7e14; }    
    .btn-register { background-color: #fd7e14; } 

    .btn-delete:hover { background-color: #343a40; }
    .btn-edit:hover, .btn-register:hover { background-color: #e8590c; }

    .table-container { margin-top: 20px; border-top: 2px solid #333; }
    .custom-table { width: 100%; border-collapse: collapse; font-size: 14px; text-align: center; }
    .custom-table th, .custom-table td { border-bottom: 1px solid #ddd; padding: 10px; }
    .custom-table th { background-color: #f8f9fa; font-weight: bold; color: #555; }
    .custom-table tr:hover { background-color: #f1f3f5; }

    .pagination-container { display: flex; justify-content: center; margin-top: 20px; }
    .page-btn { display: inline-block; margin: 0 4px; padding: 6px 12px; border: 1px solid #ddd; background-color: white; color: #333; cursor: pointer; font-size: 14px; border-radius: 4px; text-decoration: none; }
    .page-btn:hover { background-color: #e9ecef; }
    .page-btn.active { background-color: #007bff; color: white; border-color: #007bff; font-weight: bold; }
    
    .total-count { color: #666; font-size: 15px; margin-bottom: 10px; }
    .total-count strong { color: #007bff; font-size: 18px; }
    
    /* 모달 스타일 */
    .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999; }
    .modal-container { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; width: 500px; padding: 30px; border-radius: 4px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); z-index: 1000; border: 1px solid #ddd; }
    .modal-overlay.show, .modal-container.show { display: block; }

    .modal-header h3 { margin: 0 0 20px 0; font-size: 20px; color: #333; font-weight: bold; }
    
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; color: #333; }
    .form-group input[type="text"], .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 2px; box-sizing: border-box; font-size: 13px; }
    
    .row-group { display: flex; gap: 20px; }
    .half { flex: 1; }

    .modal-footer { text-align: right; margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px; }
    .btn-close-modal { background: #fff; border: 1px solid #ccc; padding: 8px 20px; cursor: pointer; border-radius: 4px; }
    .btn-submit-modal { background: #fd7e14; border: 1px solid #fd7e14; color: #fff; padding: 8px 20px; margin-left: 5px; cursor: pointer; border-radius: 4px; font-weight: bold; }
    .btn-submit-modal:hover { background-color: #e8590c; }
</style>

<script>
    var processMap = {};
    
    // JSP 루프를 통해 JS 객체 생성 (Ex: processMap['배소팀'] = ['사무실', '배소'])
    <c:forEach var="item" items="${processCodeList}">
        (function() {
            var dName = "${fn:escapeXml(item.deptName)}".trim(); 
            var pName = "${fn:escapeXml(item.processName)}".trim();
            
            if(dName) {
                if (!processMap[dName]) {
                    processMap[dName] = [];
                }
                processMap[dName].push(pName);
            }
        })();
    </c:forEach>
    
    // 부서 목록(Key값) 추출 -> 드롭다운 생성용
    var deptList = Object.keys(processMap).sort();
</script>

</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="main-container">
    <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" /> 

    <div class="content-area">
        <h2>외부 인력 관리</h2>
        
        <div class="top-controls">
            <form action="${pageContext.request.contextPath}/dde-dms/master/external-staff" method="get" style="display: flex; align-items: center; width: 100%;">
                
                <div class="search-box">
                    <select class="search-select" name="searchType">
                        <option value="externalstaffCompany" ${param.searchType == 'externalstaffCompany' ? 'selected' : ''}>업체명</option>
                        <option value="externalstaffName" ${param.searchType == 'externalstaffName' ? 'selected' : ''}>성명</option>
                        <option value="externalstaffPhone" ${param.searchType == 'externalstaffPhone' ? 'selected' : ''}>연락처</option>
                        <option value="externalstaffDept" ${param.searchType == 'externalstaffDept' ? 'selected' : ''}>부서</option>
                        <option value="externalstaffProcess" ${param.searchType == 'externalstaffProcess' ? 'selected' : ''}>담당공정</option>
                    </select>
                    
                    <input type="text" class="search-input" name="keyword" value="${param.keyword}" placeholder="검색어를 입력해주세요.">
                    
                    <button type="submit" class="search-btn">검색</button>
                </div>

                <div class="btn-group" style="margin-left: auto;">
                    <button type="button" class="btn-delete" onclick="deleteSelectedItems()">삭제</button>
                    <button type="button" class="btn-edit" onclick="editSelectedItem()">수정</button>
                    <button type="button" class="btn-register" onclick="openRegisterModal()">등록</button>
                </div>
                
            </form>
        </div>

        <p class="total-count">
             총 <strong>${fn:length(list)}</strong>명
        </p>

        <div class="table-container">
            <table class="custom-table" id="staffTable">
                <thead>
                    <tr>
                        <th width="5%"><input type="checkbox" id="checkAll" onclick="toggleAll(this)"></th>
                        <th width="15%">업체명</th>
                        <th width="15%">성명</th>
                        <th width="20%">연락처</th>
                        <th width="15%">부서</th>
                        <th width="15%">담당공정</th>    
                        <th width="15%">등록일</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:if test="${empty list}">
                        <tr class="no-data">
                            <td colspan="7" style="padding: 30px 0; color: #888;">
                                데이터가 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="staff" items="${list}">
                        <tr class="item-row">
                            <td>
                                <input type="checkbox" name="selectedIds" value="${staff.id}"
                                       data-id="${staff.id}"
                                       data-company="${staff.externalstaffCompany}"
                                       data-name="${staff.externalstaffName}"
                                       data-phone="${staff.externalstaffPhone}"
                                       data-dept="${staff.externalstaffDept}"
                                       data-process="${staff.externalstaffProcess}">
                            </td>
                            <td>${staff.externalstaffCompany}</td>
                            <td>${staff.externalstaffName}</td>
                            <td>${staff.externalstaffPhone}</td>
                            <td>${staff.externalstaffDept}</td>
                            <td>${staff.externalstaffProcess}</td>
                            <td>${staff.regDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pagination-container" id="pagination"></div>

    </div>
</div>

<div id="modalOverlay" class="modal-overlay"></div>
<div id="staffModal" class="modal-container">
    <div class="modal-header">
        <h3 id="modalTitle">외부 인력 등록</h3>
    </div>
    
    <div class="modal-body">
        <form id="staffForm" method="post" onsubmit="return validateForm()">
            <input type="hidden" id="id" name="id" value="0">

            <div class="row-group">
                <div class="form-group half">
                    <label for="externalstaffCompany">업체명</label>
                    <input type="text" id="externalstaffCompany" name="externalstaffCompany" placeholder="업체명 입력">
                </div>
                <div class="form-group half">
                    <label for="externalstaffName">성명</label>
                    <input type="text" id="externalstaffName" name="externalstaffName" placeholder="이름 입력">
                </div>
            </div>

            <div class="form-group">
                <label for="externalstaffPhone">연락처</label>
                <input type="text" id="externalstaffPhone" name="externalstaffPhone" placeholder="예: 010-1234-5678" oninput="autoHyphen(this)" maxlength="13">
            </div>
            
            <div class="row-group">
                <div class="form-group half">
                    <label for="externalstaffDept">부서(현장)</label>
                    <select id="externalstaffDept" name="externalstaffDept" onchange="changeProcessList(this.value)">
                        <option value="">부서를 선택하세요</option>
                    </select>
                </div>
                <div class="form-group half">
                    <label for="externalstaffProcess">담당공정</label>
                    <select id="externalstaffProcess" name="externalstaffProcess">
                        <option value="">공정을 선택하세요</option>
                    </select>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-close-modal" onclick="closeModal()">닫기</button>
                <button type="submit" class="btn-submit-modal" id="modalSubmitBtn">등록</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 1. [초기화] 화면 로딩 시 부서 목록 채우기
    document.addEventListener('DOMContentLoaded', function() {
        var deptSelect = document.getElementById("externalstaffDept");
        
        deptList.forEach(function(dept) {
            var option = document.createElement("option");
            option.value = dept;
            option.text = dept;
            deptSelect.appendChild(option);
        });
        
        setupPaginationAndDisplay();
    });

    // 2. [기능] 부서 변경 시 공정 목록 변경
    function changeProcessList(deptName) {
        var procSelect = document.getElementById("externalstaffProcess");
        procSelect.innerHTML = '<option value="">공정을 선택하세요</option>'; 

        if (deptName && processMap[deptName]) {
            var list = processMap[deptName];
            list.forEach(function(proc) {
                var option = document.createElement("option");
                option.value = proc;
                option.text = proc;
                procSelect.appendChild(option);
            });
        }
    }

    // 3. 연락처 자동 하이픈 기능
    function autoHyphen(target) {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
    }

    function toggleAll(source) {
        const checkboxes = document.getElementsByName('selectedIds');
        for(let i=0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }

    function deleteSelectedItems() {
        const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
        
        if (checkboxes.length === 0) {
            alert("삭제할 항목을 선택해주세요.");
            return;
        }

        if (!confirm("선택한 " + checkboxes.length + "명을 정말 삭제하시겠습니까?")) {
            return;
        }

        const selectedIds = Array.from(checkboxes).map(cb => cb.value);

        fetch('${pageContext.request.contextPath}/dde-dms/master/external-staff/delete', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(selectedIds)
        })
        .then(response => {
            if (!response.ok) throw new Error('Network error');
            return response.text();
        })
        .then(result => {
            if (result === "success") {
                alert("삭제되었습니다.");
                location.reload(); 
            } else {
                alert("삭제 실패");
            }
        })
        .catch(error => {
            console.error(error);
            alert("오류가 발생했습니다.");
        });
    }

    function setupPaginationAndDisplay() {
        const rowsPerPage = 15; 
        const rows = document.querySelectorAll('#tableBody .item-row'); 
        const rowsCount = rows.length;
        const pageCount = Math.ceil(rowsCount / rowsPerPage);
        const pagination = document.getElementById('pagination');

        if (rowsCount === 0) return;

        pagination.innerHTML = ""; 
        for (let i = 1; i <= pageCount; i++) {
            let btn = document.createElement('a');
            btn.innerText = i;
            btn.classList.add('page-btn');
            if (i === 1) btn.classList.add('active'); 
            
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                displayRows(i, rows, rowsPerPage); 
                const activeBtn = document.querySelector('.page-btn.active');
                if(activeBtn) activeBtn.classList.remove('active');
                btn.classList.add('active');
            });
            pagination.appendChild(btn);
        }
        displayRows(1, rows, rowsPerPage);
    }

    function displayRows(page, rows, rowsPerPage) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.forEach((row, index) => {
            row.style.display = (index >= start && index < end) ? '' : 'none';
        });
    }

    const modalOverlay = document.getElementById('modalOverlay');
    const modal = document.getElementById('staffModal');
    const form = document.getElementById('staffForm');

    function openModal() {
        modalOverlay.classList.add('show');
        modal.classList.add('show');
    }

    function closeModal() {
        modalOverlay.classList.remove('show');
        modal.classList.remove('show');
        form.reset(); 
    }

    if(modalOverlay) modalOverlay.addEventListener('click', closeModal);

    function openRegisterModal() {
        form.reset();
        document.getElementById('id').value = "0"; 
        document.getElementById('modalTitle').innerText = "외부 인력 등록";
        document.getElementById('modalSubmitBtn').innerText = "등록";
        document.getElementById("externalstaffProcess").innerHTML = '<option value="">공정을 선택하세요</option>';
        form.action = "${pageContext.request.contextPath}/dde-dms/master/external-staff/register";
        openModal();
    }

    function editSelectedItem() {
        const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
        if (checkboxes.length === 0) { alert("수정할 항목을 선택해주세요."); return; }
        if (checkboxes.length > 1) { alert("수정은 한 번에 하나만 가능합니다."); return; }

        const target = checkboxes[0];
        
        document.getElementById('id').value = target.getAttribute('data-id');
        document.getElementById('externalstaffCompany').value = target.getAttribute('data-company');
        document.getElementById('externalstaffName').value = target.getAttribute('data-name');
        document.getElementById('externalstaffPhone').value = target.getAttribute('data-phone');
        
        var savedDept = target.getAttribute('data-dept');
        var savedProcess = target.getAttribute('data-process');

        // 부서 세팅 및 공정 리스트 즉시 업데이트
        document.getElementById('externalstaffDept').value = savedDept;
        changeProcessList(savedDept);
        
        // 공정 값 세팅
        document.getElementById('externalstaffProcess').value = savedProcess;

        document.getElementById('modalTitle').innerText = "외부 인력 수정";
        document.getElementById('modalSubmitBtn').innerText = "수정";
        form.action = "${pageContext.request.contextPath}/dde-dms/master/external-staff/update";
        openModal();
    }

    function validateForm() {
        const name = document.getElementById('externalstaffName').value.trim();
        const company = document.getElementById('externalstaffCompany').value.trim();
        const dept = document.getElementById('externalstaffDept').value;
        const process = document.getElementById('externalstaffProcess').value;
        
        if (name === "" || company === "") {
            alert("업체명과 성명은 필수 입력값입니다.");
            return false;
        }
        if (dept === "" || process === "") {
            alert("부서와 담당 공정을 선택해주세요.");
            return false;
        }
        return true;
    }
</script>

</body>
</html>