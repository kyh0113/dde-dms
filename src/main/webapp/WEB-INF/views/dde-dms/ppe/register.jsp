<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안전보호구 관리</title>
<style>
    /* 레이아웃 스타일 */
    body { margin: 0; padding: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; }
    .main-container { display: flex; } 
    
    .content-area {
        flex: 1; 
        padding: 30px 3%; 
        background-color: #ffffff;
        min-height: 100vh;
    }

    /* 상단 검색 및 버튼 영역 */
    .top-controls {
        display: flex;
        justify-content: space-between; 
        align-items: center;
        margin-bottom: 15px;
        padding: 10px 0;
        border-bottom: 1px solid #eee;
    }

    /* 검색창 스타일 */
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

    /* 버튼 그룹 스타일 */
    .btn-group button { padding: 8px 16px; border: none; cursor: pointer; font-size: 14px; border-radius: 4px; margin-left: 5px; color: white; font-weight: bold; }
    .btn-delete { background-color: #495057; } 
    .btn-edit { background-color: #fd7e14; }    
    .btn-register { background-color: #fd7e14; } 

    .btn-delete:hover { background-color: #343a40; }
    .btn-edit:hover, .btn-register:hover { background-color: #e8590c; }

    /* 테이블 디자인 */
    .table-container { margin-top: 20px; border-top: 2px solid #333; }
    .custom-table { width: 100%; border-collapse: collapse; font-size: 14px; text-align: center; }
    .custom-table th, .custom-table td { border-bottom: 1px solid #ddd; padding: 10px; }
    .custom-table th { background-color: #f8f9fa; font-weight: bold; color: #555; }
    .custom-table tr:hover { background-color: #f1f3f5; }
    .stock-warning { color: #e03131; font-weight: bold; }

    /* 페이지 버튼 디자인 */
    .pagination-container { display: flex; justify-content: center; margin-top: 20px; }
    .page-btn { display: inline-block; margin: 0 4px; padding: 6px 12px; border: 1px solid #ddd; background-color: white; color: #333; cursor: pointer; font-size: 14px; border-radius: 4px; text-decoration: none; }
    .page-btn:hover { background-color: #e9ecef; }
    .page-btn.active { background-color: #007bff; color: white; border-color: #007bff; font-weight: bold; }
    
    /* 총 개수 텍스트 스타일 */
    .total-count { color: #666; font-size: 15px; margin-bottom: 10px; }
    .total-count strong { color: #007bff; font-size: 18px; }
    
    /* 모달 팝업 스타일 */
    .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999; }
    .modal-container { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; width: 500px; padding: 30px; border-radius: 4px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); z-index: 1000; border: 1px solid #ddd; }
    .modal-overlay.show, .modal-container.show { display: block; }

    .modal-header h3 { margin: 0 0 20px 0; font-size: 20px; color: #333; font-weight: bold; }
    
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; color: #333; }
    .form-group input[type="text"], .form-group input[type="number"], .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 2px; box-sizing: border-box; font-size: 13px; }
    .form-group textarea { height: 80px; resize: none; }

    .row-group { display: flex; gap: 20px; }
    .half { flex: 1; }

    .radio-box { margin-top: 5px; }
    .radio-box label { display: inline-block; margin-right: 15px; font-weight: normal; cursor: pointer; }
    .radio-box input { margin-right: 5px; }

    .modal-footer { text-align: right; margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px; }
    .btn-close-modal { background: #fff; border: 1px solid #ccc; padding: 8px 20px; cursor: pointer; border-radius: 4px; }
    .btn-submit-modal { background: #fd7e14; border: 1px solid #fd7e14; color: #fff; padding: 8px 20px; margin-left: 5px; cursor: pointer; border-radius: 4px; font-weight: bold; }
    .btn-submit-modal:hover { background-color: #e8590c; }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="main-container">
    <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" /> 

    <div class="content-area">
        <h2>안전보호구 현황</h2>
        
        <div class="top-controls">
            <form action="${pageContext.request.contextPath}/dde-dms/ppe/register" method="get" style="display: flex; align-items: center; width: 100%;">
                
                <div class="search-box">
                    <select class="search-select" name="searchType">
                        <option value="name" ${searchType == 'name' ? 'selected' : ''}>제품명</option>
                        <option value="code" ${searchType == 'code' ? 'selected' : ''}>제품코드</option>
                    </select>
                    
                    <input type="text" class="search-input" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요.">
                    
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
             총 <strong>${fn:length(gearList)}</strong>개
        </p>

        <div class="table-container">
            <table class="custom-table" id="gearTable">
                <thead>
                    <tr>
                        <th width="5%"><input type="checkbox" id="checkAll" onclick="toggleAll(this)"></th>
                        <th width="10%">제품코드</th>
                        <th width="25%">제품명</th>
                        <th width="20%">상세정보</th>
                        <th width="10%">구분</th>    
                        <th width="10%">사용여부</th> 
                        <th width="10%">재고수량</th>
                        <th width="10%">등록일</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:if test="${empty gearList}">
                        <tr class="no-data">
                            <td colspan="8" style="padding: 30px 0; color: #888;">
                                <c:choose>
                                    <c:when test="${not empty keyword}">
                                        검색 결과가 없습니다.
                                    </c:when>
                                    <c:otherwise>
                                        등록된 안전보호구 데이터가 없습니다.
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="gear" items="${gearList}">
                        <tr class="item-row">
                            <td>
                                <input type="checkbox" name="selectedIds" value="${gear.gearCode}"
                                       data-code="${gear.gearCode}"
                                       data-name="${gear.gearName}"
                                       data-standard="${gear.gearStandard}"
                                       data-type="${gear.gearType}"
                                       data-use="${gear.useYn}"
                                       data-stock="${gear.currentStock}">
                            </td>
                            <td>${gear.gearCode}</td>
                            <td>${gear.gearName}</td>
                            <td>${gear.gearStandard}</td>
                            <td>${gear.gearType}</td>
                            <td style="font-weight: bold; color: ${gear.useYn == 'Y' ? '#2b8a3e' : '#c92a2a'};">
                                ${gear.useYn}
                            </td>
                            <td>
                                <span class="${gear.currentStock == 0 ? 'stock-warning' : ''}">
                                    ${gear.currentStock}
                                </span>
                            </td>
                            <td>${gear.regDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pagination-container" id="pagination"></div>

    </div>
</div>

<div id="modalOverlay" class="modal-overlay"></div>

<div id="registerModal" class="modal-container">
    <div class="modal-header">
        <h3 id="modalTitle">안전보호구 등록</h3>
    </div>
    
    <div class="modal-body">
        <form id="registerForm" action="${pageContext.request.contextPath}/dde-dms/ppe/register/add" method="post" onsubmit="return validateForm()">
            <div class="row-group">
                <div class="form-group half">
                    <label for="gearCode">제품코드</label>
                    <input type="text" id="gearCode" name="gearCode" placeholder="제품 코드를 입력해주세요.">
                </div>
                <div class="form-group half">
                    <label for="gearName">제품명</label>
                    <input type="text" id="gearName" name="gearName" placeholder="제품 명을 입력해주세요.">
                </div>
            </div>

            <div class="form-group">
                <label for="currentStock">재고수량</label>
                <input type="number" id="currentStock" name="currentStock" placeholder="숫자만 입력 (예: 100)" min="0">
            </div>

            <div class="form-group">
                <label for="gearStandard">상세정보 (선택)</label>
                <textarea id="gearStandard" name="gearStandard" placeholder="제품의 상세 정보를 입력해주세요."></textarea>
            </div>

            <div class="row-group">
                <div class="form-group half">
                    <label>구분</label>
                    <div class="radio-box">
                        <label><input type="radio" name="gearType" value="월간" checked> 월간</label>
                        <label><input type="radio" name="gearType" value="연간"> 연간</label>
                    </div>
                </div>
                <div class="form-group half">
                    <label>상태</label>
                    <div class="radio-box">
                        <label><input type="radio" name="useYn" value="Y" checked> 사용</label>
                        <label><input type="radio" name="useYn" value="N"> 미사용</label>
                    </div>
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
    // 1. 전체 선택 기능
    function toggleAll(source) {
        const checkboxes = document.getElementsByName('selectedIds');
        for(let i=0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
    
    // 2. 삭제 기능 로직 (AJAX)
    function deleteSelectedItems() {
        const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
        
        if (checkboxes.length === 0) {
            alert("삭제할 항목을 최소 1개 이상 선택해주세요.");
            return;
        }

        if (!confirm("선택한 " + checkboxes.length + "개의 항목을 정말 삭제하시겠습니까?")) {
            return;
        }

        const selectedIds = Array.from(checkboxes).map(cb => cb.value);

        // ★ [수정됨] URL을 /register/delete 로 변경
        fetch('${pageContext.request.contextPath}/dde-dms/ppe/register/delete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(selectedIds)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.status);
            }
            return response.text();
        })
        .then(result => {
            if (result === "success") {
                alert("성공적으로 삭제되었습니다.");
                location.reload(); 
            } else {
                alert("삭제 실패: " + result);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("삭제 요청 중 오류가 발생했습니다.\n(관리자 도구 Console을 확인해주세요)");
        });
    }

    // 3. 페이지네이션 스크립트
    document.addEventListener('DOMContentLoaded', function() {
        const rowsPerPage = 15; 
        const rows = document.querySelectorAll('#tableBody .item-row'); 
        const rowsCount = rows.length;
        const pageCount = Math.ceil(rowsCount / rowsPerPage);
        const pagination = document.getElementById('pagination');

        if (rowsCount === 0) return;

        function setupPagination() {
            pagination.innerHTML = ""; 
            
            for (let i = 1; i <= pageCount; i++) {
                let btn = document.createElement('a');
                btn.innerText = i;
                btn.classList.add('page-btn');
                if (i === 1) btn.classList.add('active'); 
                
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    displayRows(i); 
                    
                    let currentBtn = document.querySelector('.page-btn.active');
                    if(currentBtn) currentBtn.classList.remove('active');
                    btn.classList.add('active');
                });
                
                pagination.appendChild(btn);
            }
        }

        function displayRows(page) {
            const start = (page - 1) * rowsPerPage;
            const end = start + rowsPerPage;

            rows.forEach((row, index) => {
                if (index >= start && index < end) {
                    row.style.display = ''; 
                } else {
                    row.style.display = 'none'; 
                }
            });
        }

        setupPagination();
        displayRows(1); 
    });

    // 4. 모달 관련 함수
    const modalOverlay = document.getElementById('modalOverlay');
    const registerModal = document.getElementById('registerModal');
    const registerForm = document.getElementById('registerForm');

    function openModal() {
        if(modalOverlay && registerModal) {
            modalOverlay.classList.add('show');
            registerModal.classList.add('show');
        }
    }

    function closeModal() {
        if(modalOverlay && registerModal) {
            modalOverlay.classList.remove('show');
            registerModal.classList.remove('show');
            if(registerForm) registerForm.reset(); 
        }
    }
    
    if(modalOverlay) {
        modalOverlay.addEventListener('click', closeModal);
    }
    
    // ★ [등록] 버튼 클릭 (모드 초기화)
    function openRegisterModal() {
        const form = document.getElementById('registerForm');
        form.reset(); 

        document.getElementById('modalTitle').innerText = "안전보호구 등록";
        document.getElementById('modalSubmitBtn').innerText = "등록"; 
        
        // ★ [수정됨] URL을 /register/add 로 변경
        form.action = "${pageContext.request.contextPath}/dde-dms/ppe/register/add";
        
        const codeInput = document.getElementById('gearCode');
        codeInput.readOnly = false;
        codeInput.style.backgroundColor = "white";
        
        openModal();
    }

    // ★ [수정] 버튼 클릭 (데이터 채우기 + 모드 변경)
    function editSelectedItem() {
        const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
        if (checkboxes.length === 0) { alert("수정할 항목을 선택해주세요."); return; }
        if (checkboxes.length > 1) { alert("수정은 한 번에 하나의 항목만 가능합니다."); return; }

        const target = checkboxes[0];
        const code = target.getAttribute('data-code');
        const name = target.getAttribute('data-name');
        const standard = target.getAttribute('data-standard');
        const type = target.getAttribute('data-type');
        const use = target.getAttribute('data-use');
        const stock = target.getAttribute('data-stock');

        document.getElementById('gearCode').value = code;
        document.getElementById('gearName').value = name;
        document.getElementById('currentStock').value = stock;
        document.getElementById('gearStandard').value = standard;

        const typeRadios = document.getElementsByName('gearType');
        for(let r of typeRadios) { if(r.value === type) r.checked = true; }
        const useRadios = document.getElementsByName('useYn');
        for(let r of useRadios) { if(r.value === use) r.checked = true; }

        const form = document.getElementById('registerForm');
        document.getElementById('modalTitle').innerText = "안전보호구 수정";
        document.getElementById('modalSubmitBtn').innerText = "수정"; 

        // ★ [수정됨] URL을 /register/update 로 변경
        form.action = "${pageContext.request.contextPath}/dde-dms/ppe/register/update"; 

        const codeInput = document.getElementById('gearCode');
        codeInput.readOnly = true;
        codeInput.style.backgroundColor = "#e9ecef";

        openModal();
    }

    // 5. 유효성 검사
    function validateForm() {
        const gearCode = document.getElementById('gearCode').value.trim();
        const gearName = document.getElementById('gearName').value.trim();
        const currentStock = document.getElementById('currentStock').value.trim();
        
        if (gearCode === "" || gearName === "" || currentStock === "") {
            alert("필수 값을 모두 입력해주세요. (제품코드, 제품명, 재고수량)");
            return false;
        }
        return true;
    }
</script>

</body>
</html>