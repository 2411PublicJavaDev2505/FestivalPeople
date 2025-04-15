<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/socialInsert.css">
	<title>FePeo-회원가입</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
					<span>회원가입</span> <br>
					<p>${nickname }님 반갑습니다!</p>
				</div>
				<form action="/member/insert" method="post" enctype="multipart/form-data">
					<input type="hidden" name="memberId" value="${id }">
					<input type="hidden" name="memberCode" value="${id }">
					<input type="hidden" name="nickname" value="${nickname }">
					<input type="hidden" name="email" value="${email }">
					<input type="hidden" name="profileUrl" value="${profileUrl }">
					<input type="hidden" name="socialYn" value="Y">
					<div class="register-main">
						<div class="register-left">
							<div class="profile-img"> <img alt="프사" src="${profileUrl }"> </div>
						</div>
						<div class="register-right">
							<ul class="register-input">
								<li class="register-btn">
									<input type="text" placeholder="주소" name="address" id="input-address" readonly="readonly">
									<button type="button" onclick="findAddress();">검색</button>
								</li>
								<li class="register-notbtn">
									<input type="text" placeholder="이름" name="memberName" id="input-name">
								</li>
								<ul class="register-radio-group">
									<li class="register-radio">
	  							        <label for="male">
									    <img src="../resources/img/member/male.jpg" alt="남">
									    <input type="radio" id="male" name="gender" value="M" checked>
									    </label>
									</li>
									<li class="register-radio">
										<label for="female">
									    <img src="../resources/img/member/female.jpg" alt="여">
									    <input type="radio" id="female" name="gender" value="F">
									    </label>
									</li>
								</ul>
								<li class="register-last-btn">
									<button type="submit" onclick="checkRegister();">회원가입</button>
								</li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		let memberId = document.querySelector("#input-id").value;
		let pw = document.querySelector("#input-pw").value;
		let pwRe = document.querySelector("#input-pw-re").value;
		let address = document.querySelector("#input-address").value;
		let name = document.querySelector("#input-name").value;
		let nickname = document.querySelector("#input-nickname").value;
		let email = document.querySelector("#input-email").value;
		const checkId = () => {
			document.querySelector(".check.id").innerText = "* 가능한 아이디입니다";
		}
		const checkRegister = () => {
			if(pw != pwRe){
				document.querySelector(".check.pw").innerText = "* 비밀번호를 다시 확인해주세요";
				event.preventDefault();
			}
		}
		const checkNickname = () => {
			document.querySelector(".check.nickname").innerText = "* 가능한 닉네임입니다";
		}
		const checkEmail = () => {
			document.querySelector(".check.email").innerText = "* 가능한 이메일입니다";
		}
	</script>
</body>
</html>