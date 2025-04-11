<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberDelete.css">
	<title>FePeo-회원탈퇴</title>
</head>
<body>
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="main-login-container">
				<div class="login-header">
					<span>회원탈퇴</span>
				</div>
				<div class="login-main">
					<form action="/member/delete" method="post">
						<div  class="login-input">
							<input type="text" placeholder="비밀번호" name="">
						</div>
						<div class="login-input">
							<input type="text" placeholder="비밀번호 확인" name="" >
						</div>
						<div class="login-btn">
							<button>회원탈퇴</button>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</body>
</html>