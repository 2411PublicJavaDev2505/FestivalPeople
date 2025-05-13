<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/login.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/footer.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
					<form action="/login" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div  class="login-input">
							<input type="text" placeholder="아이디를 입력하세요" name="username" id="id">
						</div>
						<div class="login-input">
							<input type="password" placeholder="비밀번호를 입력하세요" name="password" id="pw">
						</div>
						<div class="check-input"></div>
						<div class="login-btn">
							<button onclick="login();">로그인</button>
						</div>
					</form>
				</div>
				<div class="login-footer">
					<span><a onclick="findId();">아이디 찾기</a></span>
					<span><a onclick="findPw();">비밀번호 찾기</a></span>
					<span><a href="/member/insert">회원가입</a></span>
				</div>
				<div class="login-social">
					<img alt="카카오 로그인" src="../resources/img/member/kakao.png" onclick="kakao();">
					<img alt="네이버 로그인" src="../resources/img/member/naver.png" onclick="naver();">
					<button class="gsi-material-button" onclick="google();">
					  <div class="gsi-material-button-state"></div>
					  <div class="gsi-material-button-content-wrapper">
					    <div class="gsi-material-button-icon">
					      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
					        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
					        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
					        <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
					        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
					        <path fill="none" d="M0 0h48v48H0z"></path>
					      </svg>
					    </div>
					    <span class="gsi-material-button-contents">Sign in with Google</span>
					    <span style="display: none;">Sign in with Google</span>
					  </div>
					</button>
				</div>
			</div>
		</main>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
	        let token = $('meta[name="_csrf"]').attr("content");
	        let header = $('meta[name="_csrf_header"]').attr("content");
			
	        console.log(token);
	        console.log(header);
	        
	        $(document).ajaxSend(function (e, xhr, options) {
	            xhr.setRequestHeader(header, token);
	        });
	    });
		const fail = '${fail}';
		if(fail == 1){
			customAlert("로그인에 실패하셨습니다!");
		}
		function customAlert(message) {
		    Swal.fire({
		      icon: 'warning',
		      title: message,
		      text: "",
		    });
		  }
		const login = () => {
			document.querySelector(".check-input").innerHTML = "";
			let memberId = document.querySelector("#id").value;
			let memberPw = document.querySelector("#pw").value;
			if(memberId.trim() == ""){
				document.querySelector(".check-input").innerHTML = "아이디를 입력해주세요.";
				event.preventDefault();
			}else if(memberPw.trim() == ""){
				document.querySelector(".check-input").innerHTML = "비밀번호를 입력해주세요.";
				event.preventDefault();
			}else{
				
// 				$.ajax({
// 					dataType: "json",
// 					url: "/member/login",
// 					data: {
// 						"memberId" : memberId,
// 						"memberPw" : memberPw
// 					},
// 					type: "POST",
// 					success: function(data) {
// 						if(data.memberNo == null){
// 							document.querySelector(".check-input").innerHTML = data.checkMsg;
// 						}else{
// 							console.log("확인")
// 						}
// 					},
// 					error: function() {
// 						alert("통신오류!!");
// 					}
// 				});
			}
		}
	
		const kakao = () => {
			let loc = "https://kauth.kakao.com/oauth/authorize?client_id=${kakao}&redirect_uri=http://localhost:8888/member/kakao&response_type=code";
			let title = "Festival People - 카카오 로그인";
			let option = "width = 1000, height = 700, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const naver = () => {
			const state = crypto.randomUUID();
			let loc = "https://nid.naver.com/oauth2.0/authorize?client_id=${naver}&response_type=code&redirect_uri=http://localhost:8888/member/naver&state="+state;
			let title = "Festival People - 네이버 로그인";
			let option = "width = 1000, height = 700, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const google = () => {
			let loc = "https://accounts.google.com/o/oauth2/v2/auth?client_id=${google}&redirect_uri=http://localhost:8888/member/google&response_type=code&scope=email%20profile&access_type=offline&prompt=consent";
			let title = "Festival People - 구글 로그인";
			let option = "width = 1000, height = 700, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const findId = () => {
			let loc = "http://localhost:8888/member/findid";
			let title = "아이디 찾기";
			let option = "width = 550, height = 510, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
		const findPw = () => {
			let loc = "http://localhost:8888/member/findpw";
			let title = "비밀번호 찾기";
			let option = "width = 600, height = 520, top = 100, left = 200, location = no";
			window.open(loc,title,option);
		}
	</script>
</body>
</html>