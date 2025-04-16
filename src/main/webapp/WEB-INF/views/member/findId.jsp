<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	<link rel="stylesheet" href="../resources/css/member/findId.css">
</head>
<body>
	<div id="find-container">
		<div class="find-title">
			<h1>아이디 찾기</h1>
		</div>
		<form action="/member/findid" method="post">
			<ul class="find-ul">
				<li>이름 : <input type="text" name="memberName"></li>
				<li>이메일 주소 : <input type="text" name="email"></li>
				<li><button>이메일 전송</button></li>
			</ul>
		</form>
	</div>
</body>
</html>