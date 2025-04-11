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
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="register-container">
				<div class="register-header">
					<span>회원가입</span>
				</div>
				<form action="/member/delete" method="post">
					<div class="register-main">
						<div class="register-left">
							<div class="profile-img"></div>
							<input type="file">
						</div>
						<div class="register-right">
							<ul class="register-input">
								<li class="register-btn"><input type="text" placeholder="아이디"><button>중복확인</button></li>
								<li class="register-notbtn"><input type="text" placeholder="비밀번호"></li>
								<li class="register-notbtn"><input type="text" placeholder="비밀번호 확인"></li>
								<li class="register-btn"><input type="text" placeholder="주소"><button>검색</button></li>
								<li class="register-notbtn"><input type="text" placeholder="이름"></li>
								<li class="register-notbtn">남: <input type="radio" name="gender"></li>
								<li class="register-notbtn">여: <input type="radio" name="gender"></li>
								<li class="register-btn"><input type="text" placeholder="닉네임"><button>중복확인</button></li>
								<li class="register-btn"><input type="text" placeholder="이메일"><button>중복확인</button></li>
								<li class="register-last-btn"><button>회원가입</button></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</main>
	</div>
</body>
</html>