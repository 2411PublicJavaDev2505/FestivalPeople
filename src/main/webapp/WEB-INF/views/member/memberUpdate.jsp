<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberUpdate.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<title>회원정보 수정</title>
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
					<span>회원정보 수정</span>
				</div>
				<input type="hidden" name="memberNo" value="${member.memberNo }">
				<input type="hidden" name="socialYn" value="${member.socialYn }">
				<div class="register-main">
					<div class="register-left">
						<div class="profile-img">
							<c:if test="${member.socialYn eq 'Y' }">
								<img alt="프로필사진" src="${member.profileUrl }">
							</c:if>
							<c:if test="${member.socialYn ne 'Y' }">
								<img alt="프로필사진" src="${member.profileFilePath }" id="profile">
								<input type="file" name="profile" id="profile-input">
								<button onclick="updateProfile();">프로필 사진 수정</button>
							</c:if>
						</div>
					</div>
					<div class="register-right">
						<ul class="register-input">
							<c:if test="${member.socialYn ne 'Y' }">
								<li class="register-notbtn">
									<input type="password" placeholder="비밀번호" name="memberPw" id="input-pw">
								</li>
								<li class="register-notbtn">
									<input type="password" placeholder="비밀번호 확인" id="input-pw-re">
								</li>
								<li class="check pw"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="updatePw();">비밀번호 수정</button>
								</li>
							</c:if>
							<li class="register-btn">
								<input type="text" placeholder="주소" name="address" id="input-address" readonly="readonly" value="${member.address }">
								<button type="button" onclick="findAddress();">검색</button>
							</li>
							<li class="register-last-btn">
								<button type="submit" onclick="updateAddress();">주소 수정</button>
							</li>
							<c:if test="${member.socialYn ne 'Y' }">
								<li class="register-btn">
									<input type="text" placeholder="닉네임" name="nickname" id="input-nickname" value="${member.nickname }">
									<button type="button" onclick="checkNickname();">중복확인</button>
								</li>
								<li class="check nickname"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="updateNickname();">닉네임 수정</button>
								</li>
								<li class="register-btn">
									<input type="text" placeholder="이메일" name="email" value="${member.email }">
									<button type="button" onclick="checkEmail();" id="input-email">중복확인</button>
								</li>
								<li class="check email"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="updateEmail();">이메일 수정</button>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		let pw = document.querySelector("#input-pw").value;
		let pwRe = document.querySelector("#input-pw-re").value;
		let address = document.querySelector("#input-address").value;
		let nickname = document.querySelector("#input-nickname").value;
		let email = document.querySelector("#input-email").value;
		
		const updateProfile = () => {
			let formData = new FormData();
		    let fileInput = $("#profile-input")[0];

		    if (fileInput.files.length > 0) {
		        formData.append("profile", fileInput.files[0]);
		        $.ajax({
		        	dataType: "json",
		        	url: "/member/updateprofile",
		        	data: formData,
		        	type: "POST",
		        	success: function(data) {
		        		document.querySelector("#profile").src = data.profile;
		        	},
		        	error: function() {
		        		alert("통신 오류!!");
		        	}
		        });
		    }
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
	</script>
</body>
</html>