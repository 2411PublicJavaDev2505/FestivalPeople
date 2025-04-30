<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/insertSucess.css">
	<title>환영합니다!!!</title>
</head>
<body>
	<div class="background-image">
        <img src="../resources/img/intro/intro-background.png" alt="바탕화면">
    </div>
    <div class="success-container">
        <main class="success-message">
            <p class="username">${memberName }님</p>
            <div class="button-container">
                <button onclick="location.href='/'">메인 페이지로</button>
            </div>
        </main>
    </div>

</body>
</html>