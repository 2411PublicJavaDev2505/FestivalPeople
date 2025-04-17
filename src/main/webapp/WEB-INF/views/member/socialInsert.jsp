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
			<input type="hidden" name="profileFilePath" value="${profileUrl }">
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
	<script type="text/javascript">
		const checkRegister = () => {
			let address = document.querySelector("#input-address").value;
			let name = document.querySelector("#input-name").value;
			if(address.trim() == ''){
				alert("주소를 입력해주세요");
				event.preventDefault();
			}else if(name.trim() == ''){
				alert("이름을 입력해주세요.");
				event.preventDefault();
			}
		}
	</script>
</body>
</html>