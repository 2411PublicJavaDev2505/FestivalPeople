<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberInsert.css">
	<title>FePeo-회원가입</title>
</head>
<body>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		const findAddress = () => {
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	document.querySelector("#input-address").value = data.address;
		        }
		    }).open();
		}
	</script>
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="register-container">
				<div class="register-header">
					<span>회원가입</span>
				</div>
				<form action="/member/insert" method="post">
					<div class="register-main">
						<div class="register-left">
							<div class="profile-img"></div>
							<input type="file">
						</div>
						<div class="register-right">
							<ul class="register-input">
								<li class="register-btn">
									<input type="text" placeholder="아이디" name="memberId" id="input-id">
									<button type="button" onclick="checkId();">중복확인</button>
								</li>
								<li class="check id"></li>
								<li class="register-notbtn">
									<input type="password" placeholder="비밀번호" name="memberPw" id="input-pw">
								</li>
								<li class="register-notbtn">
									<input type="password" placeholder="비밀번호 확인" id="input-pw-re">
								</li>
								<li class="check pw"></li>
								<li class="register-btn">
									<input type="text" placeholder="주소" name="address" id="input-address" readonly="readonly">
									<button type="button" onclick="findAddress();">검색</button>
								</li>
								<li class="register-notbtn">
									<input type="text" placeholder="이름" name="memberName">
								</li>
								<li class="register-radio">
									남: <input type="radio" name="gender" value="M" checked>
								</li>
								<li class="register-radio">
									여: <input type="radio" name="gender" value="F">
								</li>
								<li class="register-btn">
									<input type="text" placeholder="닉네임" name="nickname" id="input-nickname">
									<button type="button" onclick="checkNickname();">중복확인</button>
								</li>
								<li class="check nickname"></li>
								<li class="register-btn">
									<input type="text" placeholder="이메일" name="email">
									<button type="button" onclick="checkEmail();" id="input-email">중복확인</button>
								</li>
								<li class="check email"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="checkPw();">회원가입</button>
								</li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const checkId = () => {
			let memberId = document.querySelector("#input-id").value;
			document.querySelector(".check.id").innerText = "* 가능한 아이디입니다";
		}
		const checkPw = () => {
			let pw = document.querySelector("#input-pw").value;
			let pwRe = document.querySelector("#input-pw-re").value;
			if(pw != pwRe){
				document.querySelector(".check.pw").innerText = "* 비밀번호를 다시 확인해주세요";
				event.preventDefault();
			}
		}
		const checkNickname = () => {
			let nickname = document.querySelector("#input-nickname").value;
			document.querySelector(".check.nickname").innerText = "* 가능한 닉네임입니다";
		}
		const checkEmail = () => {
			let email = document.querySelector("#input-email").value;
			document.querySelector(".check.email").innerText = "* 가능한 이메일입니다";
		}
	</script>
</body>
</html>