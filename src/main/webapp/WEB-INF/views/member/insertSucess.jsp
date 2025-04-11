<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/insertSucess.css">
	<title>Insert title here</title>
</head>
<body>
	<div class="background-image">
    	<img src="../resources/img/member/insertSucess.jpg" alt="바탕화면">
    </div>
    <div class="success-container">
        <main class="success-message">
            <h1>Welcome!!!</h1>
            <p class="username">"###"님</p>
            <div class="button-container">
                <button onclick="location.href='/main'">메인 페이지로</button>
                <button onclick="location.href='/logout'">로그아웃</button>
            </div>
        </main>
    </div>

</body>
</html>