<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
</head>
<body>
	<h1>비밀번호 찾기</h1>
	<form action="/member/findpw" method="post">
		찾고자 하는 아이디 : <input type="text" name="memberId">
		<button>이메일 전송</button>
	</form>
</body>
</html>