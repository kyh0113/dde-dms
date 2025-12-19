<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안전보호구 관리</title>
<style>
    /* 레이아웃 잡기 */
    body { margin: 0; padding: 0; font-family: 'Malgun Gothic', sans-serif; }
    .main-container { display: flex; } 
    .content-area {
        flex: 1; 
        padding: 30px;
        background-color: #ffffff;
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="main-container">
    <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" /> 

    <div class="content-area">
        <h2>재고관리 페이지</h2>
        <p>재고관리</p>
    </div>
</div>
</body>
</html>