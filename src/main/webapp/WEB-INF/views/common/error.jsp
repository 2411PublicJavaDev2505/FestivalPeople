<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Error</title>
</head>
	<body>
		<div id="error-container">
			<h1>서비스 이용중 문제가 발생했습니다</h1>
			<span class="error-content">발생한 예외 : ${e }</span>
			<p>
				자세한 문제 원인은 이클립스 콘솔을 확인해주세요
			</p>
		</div>
		<div id="btn-area">
			<a href="/">메인페이지</a>
			<button onclick="history.back();">이전페이지</button>
		</div>
	</body>
</html>