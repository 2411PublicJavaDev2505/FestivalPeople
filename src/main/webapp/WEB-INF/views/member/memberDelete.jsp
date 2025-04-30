<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberDelete.css">
	<title>FePeo-회원탈퇴</title>
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
         crossorigin="anonymous"
    />
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
						<input type="password" placeholder="비밀번호" name="memberPw" id="pw">
					</div>
					<div class="login-input">
						<input type="password" placeholder="비밀번호 확인" id="pwRe">
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
		function customConfirm(url) {
	        Swal.fire({
	          title: '로그인이 필요한 서비스입니다.',
	          text: "로그인하시겠습니까?",
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#3085d6',
	          cancelButtonColor: '#d33',
	          confirmButtonText: '로그인',
	          cancelButtonText: '취소',
	          reverseButtons: false, // 버튼 순서 거꾸로
	          
	        }).then((result) => {
	          if (result.isConfirmed) {
	            location.href = url;
	          }
	        })
	      }
		function customAlert(message) {
		    Swal.fire({
		      icon: 'warning',
		      title: message,
		      text: "",
		    });
		  }
		const check = () => {
			let id = document.querySelector("#id").value;
			let pw = document.querySelector("#pw").value;
			let pwRe = document.querySelector("#pwRe").value;
			if(pw.trim() == ''){
				document.querySelector(".input-check").innerHTML = "* 비밀번호를 입력해주세요.";
				event.preventDefault();
			}else if(pw != pwRe){
				document.querySelector(".input-check").innerHTML = "* 비밀번호가 다릅니다.";
				event.preventDefault();
			}else{
				Swal.fire({
			          title: '정말 탈퇴하시겠습니까?',
			          text: "ㅠㅠ..",
			          icon: 'warning',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
			          if (result.isConfirmed) {
			        	  $.ajax({
								dataType: "json",
								url: "/member/delete",
								data : {
									"memberPw" : pw,
									"memberId" : id
								},
								type: "POST",
								success: function(data) {
									if(data.memberId == null){
										customAlert("비밀번호를 다시 입력해주세요.");
									}else{
										customAlert("탈퇴가 완료되었습니다.");
										location.href="/member/logout";
									}
								},
								error: function() {
									customAlert("통신 오류!!");
								}
							});
			          }
			        })
			}
		}
	</script>
</body>
</html>