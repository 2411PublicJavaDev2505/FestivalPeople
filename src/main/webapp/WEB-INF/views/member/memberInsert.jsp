<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberInsert.css">
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
         crossorigin="anonymous"
    />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
					<sec:csrfInput/>
					<input type="hidden" name="socialYn" value="N">
					<div class="register-main">
						<div class="register-left">
							<div class="profile-img">
								<img alt="" src="../resources/img/member/profile.png" id="profile-img">
							</div>
							<label for="input-profile">
								<div>파일찾기</div>
							</label>
							<input type="file" name="profile" onchange="changeProfile();" id="input-profile">
						</div>
						<div class="register-right">
							<ul class="register-input">
								<li class="register-notbtn">
									<input type="text" placeholder="아이디" name="memberId" id="input-id" onchange="checkId();">
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
								<li class="register-notbtn">
									<input type="text" placeholder="닉네임" name="nickname" id="input-nickname" onchange="checkNickname();">
								</li>
								<li class="check nickname"></li>
								<li class="register-btn">
									<input type="text" placeholder="이메일" name="email" onchange="checkEmail();" id="input-email">
									<button type="button" onclick="sendEmail();">이메일 인증</button>
								</li>
								<li id="input-email-check" class="register-btn"></li>
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
		let idYn = false;
		let nicknameYn = false;
		let emailYn = false;
		let emailCodeYn = false;
		let emailCode = "";
		
		const checkEmailCode = () => {
			let code = document.querySelector("#input-email-code").value;
			console.log(code);
			console.log(emailCode);
			if(code.trim() == emailCode.trim()){
				customAlert("이메일 인증이 완료되었습니다.");
				document.querySelector("#input-email").readOnly = "readonly";
				emailCodeYn = true;
			}else{
				customAlert("이메일 코드가 다릅니다!");
			}
		}
		
		const sendEmail = () => {
			if(emailYn){
				email = document.querySelector("#input-email").value;
				customAlert("인증코드가 전송되었습니다");
				$.ajax({
					dataType: "json",
					url: "/member/sendcode",
					data : {
						"email" : email,
					},
					type: "GET",
					success: function(data) {
						emailCode = data.emailCode;
						document.querySelector("#input-email-check").innerHTML = '<input type="text" id="input-email-code"><button type="button" onclick="checkEmailCode();">확인</button>';
					},
					error: function() {
						customAlert("통신 오류!!");
					}
				});
			}else{
				customAlert("이메일을 다시 확인해주세요!");
			}
		}
		
		function changeProfile() {
			let formData = new FormData();
		    let fileInput = $("#input-profile")[0];
		    if (fileInput.files.length > 0) {
		        formData.append("profile", fileInput.files[0]);
		        $.ajax({
		        	url: "/member/changeprofile",
		        	data: formData,
		        	type: "POST",
		        	contentType: false,
		            processData: false, 
		        	success: function(data) {
		        		document.querySelector("#profile-img").src = data;
		        	},
		        	error: function() {
		        		customAlert("통신 오류!!");
		        	}
		        });
		    }
		}
		
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
						idYn = true;
					}else{
						document.querySelector(".check.id").innerText = "* 이미 존재하는 아이디입니다";
						idYn = false;
					}
				},
				error : function() {
					customAlert("통신 오류!");
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
						nicknameYn = true;
					}else{
						document.querySelector(".check.nickname").innerText = "* 이미 존재하는 닉네임입니다";
						nicknameYn = false;
					}
				},
				error: function() {
					customAlert("통신 오류!");
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
						emailYn = true;
					}else{
						document.querySelector(".check.email").innerText = "* 이미 존재하는 이메일입니다";
						emailYn = false;
					}
				},
				error: function() {
					customAlert("통신 오류!");
				}
			});
		}
		
		function customAlert(message) {
		    Swal.fire({
		      icon: 'warning',
		      title: message,
		      text: "",
		    });
		  }
		
		const checkRegister = () => {
			memberId = document.querySelector("#input-id").value;
			pw = document.querySelector("#input-pw").value;
			pwRe = document.querySelector("#input-pw-re").value;
			address = document.querySelector("#input-address").value;
			name = document.querySelector("#input-name").value;
			nickname = document.querySelector("#input-nickname").value;
			email = document.querySelector("#input-email").value;
			if(emailCodeYn){
				if(memberId.trim() == ''){
					customAlert('아이디를 입력해주세요!!');
					event.preventDefault();
				}else if(pw.trim() == ''){
					customAlert("비밀번호를 입력해주세요.");
					event.preventDefault();
				}else if(address.trim() == ''){
					customAlert("주소를 입력해주세요.");
					event.preventDefault();
				}else if(name.trim() == ''){
					customAlert("이름를 입력해주세요.");
					event.preventDefault();
				}else if(nickname.trim() == ''){
					customAlert("닉네임를 입력해주세요.");
					event.preventDefault();
				}else if(email.trim() == ''){
					customAlert("이메일를 입력해주세요.");
					event.preventDefault();
				}else if(pw != pwRe){
					document.querySelector(".check.pw").innerText = "* 비밀번호를 다시 확인해주세요";
					event.preventDefault();
				}else if(!idYn){
					customAlert("아이디를 변경해주세요");
					event.preventDefault();
				}else if(!nicknameYn){
					customAlert("닉네임을 변경해주세요");
					event.preventDefault();
				}else if(!emailYn){
					customAlert("이메일을 변경해주세요");
					event.preventDefault();
				}
			}else{
				customAlert('이메일 인증이 완료되지 않았습니다.');
				event.preventDefault();
			}
		}
	</script>
</body>
</html>