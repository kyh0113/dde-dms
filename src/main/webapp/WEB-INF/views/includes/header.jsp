<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* 헤더 디자인 */
    .app-header {
        height: 60px;
        background-color: #2b5ac9; /* 요청하신 파란색 */
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        z-index: 1000;
        position: relative;
    }
    .app-header h1 { font-size: 20px; margin: 0; font-weight: bold; }
    .header-buttons button {
        background: #153d8a; border: 1px solid #4a7be6;
        color: white; padding: 5px 15px; cursor: pointer; border-radius: 4px;
    }
</style>

<div class="app-header">
    <h1>안전보호구 지급 관리 시스템</h1>
    <div class="header-buttons">
        <button>관리자</button>
        <button>사용자</button>
    </div>
</div>
