<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
         crossorigin="anonymous"
    />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<link rel="stylesheet" href="../resources/css/member/findId.css">
</head>
<body>
	<div id="find-container">
		<div class="find-title">
			<div>
				<span>아이디 찾기</<span>
			</div>
		</div>
		<form action="/member/findid" method="post">
			<ul class="find-ul">
				<li><input type="text" name="memberName" placeholder="이름을 입력해주세요" id="#input-name"></li>
				<li><input type="text" name="email" placeholder="이메일을 입력해주세요" id="input-email"></li>
				<li><button class="submit" onclick="findId();">이메일 전송</button></li>
			</ul>
		</form>
	</div>
	<script type="text/javascript">
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
					alert("통신 오류!");
				}
			});
		}
		const findId = () => {
			
		}
	</script>
</body>
</html>