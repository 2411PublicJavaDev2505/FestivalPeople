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
					<input type="hidden" value="${sessionScope.member.memberId }" id="id">
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
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const check = () => {
			let id = document.querySelector("#id").value;
			let pw = document.querySelector("#pw").value;
			let pwRe = document.querySelector("#pwRe").value;
			if(pw != pwRe){
				document.querySelector(".input-check").innerHTML = "비밀번호가 다릅니다.";
				event.preventDefault();
			}else{
				$.ajax({
					url: "/member/delete",
					data : {
						"memberPw" : pw,
						"memberId" : id
					},
					type: "POST",
					success: function(data) {
						alert("결과 : "+ data);
					},
					error: function() {
						alert("통신 오류!!");
					}
				});
			}
		}
	</script>
</body>
</html>