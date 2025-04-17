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
			<div>
				<span>아이디 찾기</<span>
			</div>
		</div>
		<form action="/member/findid" method="post">
			<ul class="find-ul">
				<li><input type="text" name="memberName" placeholder="이름을 입력해주세요"></li>
				<li><input type="text" name="email" placeholder="이메일을 입력해주세요"></li>
				<li><button class="submit">이메일 전송</button></li>
			</ul>
		</form>
	</div>
</body>
</html>