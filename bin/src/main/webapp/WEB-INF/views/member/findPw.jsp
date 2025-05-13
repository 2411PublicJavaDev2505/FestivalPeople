<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<link rel="stylesheet" href="../resources/css/member/findId.css">
</head>
<body>
	<div id="find-container">
		<div class="find-title">
			<div>
				<span>비밀번호 찾기</<span>
			</div>
		</div>
		<ul class="find-ul">
			<li><input type="text" name="memberId" placeholder="아이디를 입력해주세요" id="input-id"></li>
			<li><button class="submit" onclick="findPw();">이메일 전송</button></li>
		</ul>
	</div>
	<script type="text/javascript">
		function customAlert(message) {
		    Swal.fire({
		      icon: 'warning',
		      title: message,
		      text: "",
		    });
		  }
		const findPw = () => {
			let memberId = document.querySelector("#input-id").value;
			if(memberId.trim() ==''){
				customAlert("아이디를 입력해주세요!");
			}else{
				$.ajax({
					dataType: "json",
					url: "/member/findpw",
					data: {
						"memberId" : memberId,
					},
					type: "POST",
					success: function(data) {
						if(data.check == 0){
							customAlert("존재하지 않는 아이디 입니다!");
						}else{
							location.href = "/member/closefindpw";
						}
					},
					error: function() {
						alert("통신 오류!");
					}
				});
			}
		}
	</script>
</body>
</html>