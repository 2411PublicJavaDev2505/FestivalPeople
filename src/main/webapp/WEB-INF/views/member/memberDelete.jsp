<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberDelete.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
						<input type="hidden" name="memberNo" value="${sessionScope.memberNo }">
						<div  class="login-input">
							<input type="text" placeholder="비밀번호" name="memberPw" id="pw">
						</div>
						<div class="login-input">
							<input type="text" placeholder="비밀번호 확인" id="pwRe">
						</div>
						<div class="login-btn">
							<button onclick="check();">회원탈퇴</button>
						</div>
						<div class="input-check"></div>
					</form>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const check = () => {
			let pw = document.querySelector("#pw").value;
			let pwRe = document.querySelector("#pwRe").value;
			console.log(document.querySelector("#input-check"));
			if(pw != pwRe){
				document.querySelector(".input-check").innerHTML = "비밀번호가 다릅니다.";
				event.preventDefault();
			}else{
				$.ajax({
					dataType: "json",
					url: "/member/delcheck",
					data : {"pw" : pw},
					type: "GET",
					success: function(data) {
						alert("결과 : "+ data);
					},
					error: function() {
						alert("통신 오류!!");
						event.preventDefault();
					}
				});
			}
		}
	</script>
</body>
</html>