<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/login.css">
	<title>FePeo-login</title>
</head>
<body>
	<div class="background-image">
    	 <img src="../resources/img/mainback.jpg" alt="바탕화면">
    </div>
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="main-login-container">
				<div class="login-header">
					<span>로그인</span>
				</div>
				<div class="login-main">
					<form action="/member/login" method="post">
						<div  class="login-input">
							<input type="text" placeholder="아이디를 입력하세요" name="memberId">
						</div>
						<div class="login-input">
							<input type="text" placeholder="비밀번호를 입력하세요" name="memberPw">
						</div>
						<div class="login-btn">
							<button>로그인</button>
						</div>
					</form>
				</div>
				<div class="login-footer">
					<span><a>아이디 찾기</a></span>
					<span><a>비밀번호 찾기</a></span>
					<span><a href="/member/insert">회원가입</a></span>
				</div>
				<div class="login-social">
					<img alt="카카오 로그인" src="../resources/img/member/kakao.png" onclick="kakao();">
					<img alt="네이버 로그인" src="../resources/img/member/naver.png" onclick="naver();">
					<img alt="구글 로그인" src="../resources/img/member/google.png" onclick="google();">
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const kakao = () => {
			let loc = "https://kauth.kakao.com/oauth/authorize?client_id=${kakao}&redirect_uri=http://localhost:8888/member/kakao&response_type=code";
			let title = "Festival People - 카카오 로그인";
			let option = "width = 800, height = 700, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const naver = () => {
			const state = crypto.randomUUID();
			let loc = "https://nid.naver.com/oauth2.0/authorize?client_id=${naver}&response_type=code&redirect_uri=http://localhost:8888/member/naver&state="+state;
			let title = "Festival People - 네이버 로그인";
			let option = "width = 500, height = 700, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const google = () => {
			let loc = "https://accounts.google.com/o/oauth2/v2/auth?client_id=${google}&redirect_uri=http://localhost:8888/member/google&response_type=code&scope=email%20profile&access_type=offline&prompt=consent";
			let title = "Festival People - 구글 로그인";
			let option = "width = 1000, height = 600, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
	</script>
</body>
</html>