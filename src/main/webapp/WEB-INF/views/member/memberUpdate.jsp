<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberUpdate.css">
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
         crossorigin="anonymous"
    />
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
								<c:if test="${member.profileFilePath eq null }">
									<img alt="" src="../resources/img/member/profile.png" id="profile-div">
								</c:if>
								<c:if test="${member.profileFilePath ne null }">
									<img alt="프로필사진" src="${member.profileFilePath }" id="profile-div">
								</c:if>
								<label for="profile-input">
									<div>파일찾기</div>
								</label>
								<input type="file" name="profile" id="profile-input" onchange="changeProfile();">
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
								<li class="register-notbtn">
									<input type="text" placeholder="닉네임" name="nickname" id="input-nickname" value="${member.nickname }" onchange="checkNickname();">
								</li>
								<li class="check nickname"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="updateNickname();">닉네임 수정</button>
								</li>
								<li class="register-notbtn">
									<input type="text" placeholder="이메일" name="email" value="${member.email }" id="input-email" onchange="checkEmail();">
								</li>
								<li class="check email"></li>
								<li class="register-last-btn">
									<button type="submit" onclick="updateEmail();">이메일 수정</button>
								</li>
								<li class="register-last-btn">
									<button onclick="history.back();">돌아가기</button>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		let nicknameYn = false;
		let emailYn = false;
		
		function customAlert(message) {
		    Swal.fire({
		      icon: 'warning',
		      title: message,
		      text: "",
		    });
		  }
		
		const updateEmail = () => {
			let email = document.querySelector("#input-email").value;
			if(email.trim() == ''){
				customAlert("이메일을 입력해주세요");
			}else if(!emailYn){
				customAlert("중복된 이메일입니다");
			}else {
				Swal.fire({
			          title: '이메일을 변경하시겠습니까?',
			          icon: 'question',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
		        		if(result.isConfirmed){
		        			$.ajax({
		    					url: "/member/updateemail",
		    					data: {
		    						"email" : email,
		    						"memberNo" : '${member.memberNo}'
		    					},
		    					type: "POST",
		    					success: function(data) {
		    						customAlert("이메일이 수정되었습니다")
		    						email = data;
		    					},
		    					error: function() {
		    						customAlert("통신 오류!");
		    					}
		    				});
		        		}
			        })
				
			}
		}
		
		const updateNickname = () => {
			let nickname = document.querySelector("#input-nickname").value;
			if(nickname.trim() ==''){
				customAlert("닉네임을 입력해주세요");
			}else if(!nicknameYn){
				customAlert("중복된 닉네임입니다");
			}else{
				Swal.fire({
			          title: '닉네임을 변경하시겠습니까?',
			          icon: 'question',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
		        		if(result.isConfirmed){
		        			$.ajax({
		    					url: "/member/updatenickname",
		    					data: {
		    						"nickname" : nickname,
		    						"memberNo" : '${member.memberNo}'
		    					},
		    					type: "POST",
		    					success: function(data) {
		    						customAlert("닉네임이 수정되었습니다")
		    						nickname = data;
		    					},
		    					error: function() {
		    						customAlert("통신 오류!");
		    					}
		    				});
		        		}
			        })
			}
		}
		
		const updateAddress = () => {
			let address = document.querySelector("#input-address").value;
			if(address.trim() == ''){
				customAlert("주소를 입력해주세요");
			}else {
				Swal.fire({
			          title: '주소를 변경하시겠습니까?',
			          icon: 'question',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
		        		if(result.isConfirmed){
							$.ajax({
								url: "/member/updateaddress",
								data: {
									"address" : address,
									"memberNo" : '${member.memberNo}'
								},
								type: "POST",
								success: function(data) {
									customAlert("주소가 수정되었습니다")
									address = data;
								},
								error: function() {
									customAlert("통신 오류!");
								}
							});
		        		}
			        })
			}
		}
		
		const updatePw = () => {
			let pw = document.querySelector("#input-pw").value;
			let pwRe = document.querySelector("#input-pw-re").value;
			if(pw != pwRe || pw.trim() == ""){
				document.querySelector(".check.pw").innerHTML = "* 비밀번호를 확인해주세요";
			}else {
				Swal.fire({
			          title: '비밀번호를 변경하시겠습니까?',
			          icon: 'question',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
		        		if(result.isConfirmed){
		        			$.ajax({
								url: "/member/updatepw",
								data: {
									"memberPw" : pw,
									"memberId" : '${member.memberId}'
								},
								type: "POST",
								success: function(data) {
									customAlert(data);
									pw = "";
									pwRe = "";
								},
								error: function() {
									alert("통신 오류!");
								}
							});
		        		}
			        })
					
			}
		}
		
		const updateProfile = () => {
			Swal.fire({
		          title: '프로필을 변경하시겠습니까?',
		          icon: 'question',
		          showCancelButton: true,
		          confirmButtonColor: '#3085d6',
		          cancelButtonColor: '#d33',
		          confirmButtonText: '확인',
		          cancelButtonText: '취소',
		          reverseButtons: false, // 버튼 순서 거꾸로
		          
		        }).then((result) => {
	        		if(result.isConfirmed){
						let formData = new FormData();
					    let fileInput = $("#profile-input")[0];
					    if (fileInput.files.length > 0) {
					        formData.append("profile", fileInput.files[0]);
					        $.ajax({
					        	dataType: "json",
					        	url: "/member/updateprofile",
					        	data: formData,
					        	type: "POST",
					        	contentType: false,
					            processData: false, 
					        	success: function(data) {
					        		document.querySelector("#profile-div").src = data.profile;
					        		customAlert("프로필이 변경되었습니다")
					        	},
					        	error: function() {
					        		customAlert("통신 오류!!");
					        	}
					        });
					    }
	        		}
		        })
		}
		
		const checkNickname = () => {
			let nickname = document.querySelector("#input-nickname").value;
			if(nickname.trim() == ''){
				document.querySelector(".check.nickname").innerText = "* 닉네임을 입력해주세요";
			}else{
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
		}
		const checkEmail = () => {
			let email = document.querySelector("#input-email").value;
			if(email.trim() == ''){
				document.querySelector(".check.email").innerText = "* 이메일을 입력해주세요.";
			}else {
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
		}
		function changeProfile() {
			let formData = new FormData();
		    let fileInput = $("#profile-input")[0];
		    if (fileInput.files.length > 0) {
		        formData.append("profile", fileInput.files[0]);
		        $.ajax({
		        	url: "/member/changeprofile",
		        	data: formData,
		        	type: "POST",
		        	contentType: false,
		            processData: false, 
		        	success: function(data) {
		        		document.querySelector(".profile-img img").src = data;
		        	},
		        	error: function() {
		        		customAlert("통신 오류!!");
		        	}
		        });
		    }
		}
	</script>
</body>
</html>