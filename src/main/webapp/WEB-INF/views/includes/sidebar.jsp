

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* 사이드바 디자인 */
    .app-sidebar {
        width: 240px;
        background-color: #f8f9fa;
        border-right: 1px solid #ddd;
        min-height: calc(100vh - 60px);
        padding: 20px;
        box-sizing: border-box;
        float: left;
    }
    .menu-group { margin-bottom: 25px; }
    
    .menu-title { 
        font-weight: bold; margin-bottom: 10px; display: block; color: #333; 
        border-bottom: 1px solid #ccc; padding-bottom: 5px;
        cursor: pointer; /* 마우스 올리면 손가락 모양 */
        user-select: none; /* 드래그 방지 */
        display: flex; /* 아이콘과 텍스트 정렬 */
        align-items: center;
    }

    .menu-list { 
        list-style: none; padding-left: 0; margin: 0; 
        /* 부드러운 전환을 위한 설정 (선택사항) */
        transition: all 0.3s ease;
        overflow: hidden;
    }

    .menu-list li { margin-bottom: 5px; }
    .menu-list li a {
        text-decoration: none; color: #555; display: block; padding: 8px 10px; font-size: 14px;
        border-radius: 4px;
    }
    .menu-list li a:hover { background-color: #e9ecef; color: #2b5ac9; font-weight: bold; }

    /* ▼ 토글 기능 관련 CSS 추가 */
    .toggle-icon {
        display: inline-block;
        margin-right: 5px;
        transition: transform 0.3s ease; /* 회전 애니메이션 */
    }

    /* 메뉴가 접혔을 때(.folded 클래스가 붙었을 때) 스타일 */
    .menu-group.folded .menu-list {
        display: none; /* 목록 숨김 */
    }
    
    .menu-group.folded .toggle-icon {
        /* 시계 반대방향 90도 회전 (오른쪽을 보게 됨) */
        transform: rotate(-90deg); 
    }
</style>

<div class="app-sidebar">
    <div class="menu-group">
        <span class="menu-title" onclick="toggleMenu(this)">
            <span class="toggle-icon">▼</span> 보호구 관리
        </span>
        <ul class="menu-list">
            <li><a href="/dde-dms/ppe/register">안전보호구 등록</a></li>
            <li><a href="/dde-dms/ppe/inventory">재고관리</a></li>
        </ul>
    </div>

    <div class="menu-group">
        <span class="menu-title" onclick="toggleMenu(this)">
            <span class="toggle-icon">▼</span> 지급관리
        </span>
        <ul class="menu-list">
            <li><a href="#">보호구 지급 요청 관리</a></li>
            <li><a href="#">보호구 지급 개수 관리</a></li>
            <li><a href="#">지급 현황 조회</a></li>
        </ul>
    </div>

    <div class="menu-group">
        <span class="menu-title" onclick="toggleMenu(this)">
            <span class="toggle-icon">▼</span> 기준정보 관리
        </span>
        <ul class="menu-list">
            <li><a href="/dde-dms/master/dept-personnel">부서 공정별 인원 관리</a></li>
            <li><a href="/dde-dms/master/external-staff">외부업체 직원 관리</a></li>
        </ul>
    </div>
</div>

<script>
    // 메뉴 토글 함수
    function toggleMenu(element) {
        // 클릭된 제목의 부모 요소(.menu-group)를 찾습니다.
        var group = element.parentElement;
        
        // .folded 클래스를 껐다 켰다(toggle) 합니다.
        // folded 클래스가 있으면 CSS에 의해 메뉴가 숨겨지고 화살표가 돌아갑니다.
        group.classList.toggle('folded');
    }
</script>
