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
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const kakao = () => {
			location.href = "https://kauth.kakao.com/oauth/authorize?client_id=${kakao}&redirect_uri=http://localhost:8888/member/kakao&response_type=code";
		}
		const naver = () => {
			const state = crypto.randomUUID();
			location.href = "https://nid.naver.com/oauth2.0/authorize?client_id=vtFv0628kUp2Kt2meM2v&response_type=code&redirect_uri=http://localhost:8888/member/naver&state="+state;
		}
	</script>
</body>
</html>