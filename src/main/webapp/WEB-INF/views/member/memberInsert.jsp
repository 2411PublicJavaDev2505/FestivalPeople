<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberInsert.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
	<div class="background-image">
    	 <img src="../resources/img/mainback.jpg" alt="바탕화면">
    </div>
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="register-container">
				<div class="register-header">
					<span>회원가입</span>
				</div>
				<form action="/member/insert" method="post" enctype="multipart/form-data">
					<input type="hidden" name="socialYn" value="N">
					<div class="register-main">
						<div class="register-left">
							<div class="profile-img"></div>
							<input type="file" name="profile">
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
		function checkId() {
			memberId = document.querySelector("#input-id").value;
			$.ajax({
				dataType: "json",
				url: "/member/checkid",
				data : {
					"memberId" : memberId
				},
				type : "GET",
				success : function(data) {
					if(data.check == 0){
						document.querySelector(".check.id").innerText = "* 가능한 아이디입니다";
					}else{
						document.querySelector(".check.id").innerText = "* 이미 존재하는 아이디입니다";
					}
				},
				error : function() {
					alert("통신 오류!");
				}
			});
		}
		const checkNickname = () => {
			nickname = document.querySelector("#input-nickname").value;
			$.ajax({
				dataType: "json",
				url: "/member/checknickname",
				data: {
					"nickname" : nickname
				},
				type: "GET",
				success: function(data) {
					if(data.check == 0){
						document.querySelector(".check.nickname").innerText = "* 가능한 닉네임입니다";
					}else{
						document.querySelector(".check.nickname").innerText = "* 이미 존재하는 닉네임입니다";
					}
				},
				error: function() {
					alert("통신 오류!");
				}
			});
		}
		const checkEmail = () => {
			email = document.querySelector("#input-email").value;
			$.ajax({
				dataType: "json",
				url: "/member/checkemail",
				data: {
					"email" : email
				},
				type: "GET",
				success: function(data) {
					if(data.check == 0){
						document.querySelector(".check.email").innerText = "* 가능한 이메일입니다";
					}else{
						document.querySelector(".check.email").innerText = "* 이미 존재하는 이메일입니다";
					}
				},
				error: function() {
					alert("통신 오류!");
				}
			});
		}
		const checkRegister = () => {
			if(memberId.trim() == ''){
				alert("아이디를 입력해주세요.");
				event.preventDefault();
			}else if(pw.trim() == ''){
				alert("비밀번호를 입력해주세요.");
				event.preventDefault();
			}else if(address.trim() == ''){
				alert("주소를 입력해주세요.");
				event.preventDefault();
			}else if(name.trim() == ''){
				alert("이름를 입력해주세요.");
				event.preventDefault();
			}else if(nickname.trim() == ''){
				alert("닉네임를 입력해주세요.");
				event.preventDefault();
			}else if(email.trim() == ''){
				alert("이메일를 입력해주세요.");
				event.preventDefault();
			}else if(pw != pwRe){
				document.querySelector(".check.pw").innerText = "* 비밀번호를 다시 확인해주세요";
				event.preventDefault();
			}
		}
	</script>
</body>
</html>