<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/root.css">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/member/memberDetail.css">
	<title>FePeo-마이페이지</title>
</head>
<body>
	<div class="background-image">
    	 <img src="../resources/img/mainback.jpg" alt="바탕화면">
    </div>
	<div id="container">
		<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="mypage-container">
				<div class="mypage-left">
					<h3>마이페이지</h3>
					<c:if test="${member.socialYn eq 'Y' }">
						<img alt="" src="${member.profileUrl }" class="mypage-profile">
					</c:if>
					<c:if test="${member.socialYn ne 'Y' }">
						<c:if test="${member.profileFilePath eq null }">
							<img alt="" src="../resources/img/member/profile.png" class="mypage-profile">
						</c:if>
						<c:if test="${member.profileFilePath ne null }">
							<img alt="" src="${member.profileFilePath }" class="mypage-profile">
						</c:if>
					</c:if>
					<ul>
						<c:if test="${member.socialYn ne 'Y' }">
							<li>${member.memberId }</li>
						</c:if>
						<li>${member.memberName }</li>
						<li>${member.nickname }</li>
						<li>${member.email }</li>
						<li>신고누적횟수 : ${member.reportCount }</li>
						<li>${member.address }</li>
					</ul>
					<div class="mypage-left-button">
						<button onclick="memberUpdate();">수정하기</button>
						<button onclick="memberDelete('${member.socialYn}');">탈퇴하기</button>
					</div>
				</div>
				<div class="mypage-right">
					<div class="mypage-right-top">
						<button onclick="myChat();">내 채팅방</button>
						<button onclick="myCourse();">내 코스</button>
					</div>
					<div class="my-chat-list">
						<div class="my-chat">
							<img alt="채팅방 썸네일" src="">
							<div class="chat-content">
								<h3>전주국제영화제 같이 가실분</h3>
								<div>
									<span>#전주</span>
									<span>#영화제</span>
									<span>#여자만</span>
								</div>
								<div class="chat-count">
									<span>정원 2/10</span>
								</div>
							</div>
						</div>
						<div class="my-chat">
							<img alt="채팅방 썸네일" src="">
							<div class="chat-content">
								<h3>전주국제영화제 같이 가실분</h3>
								<div>
									<span>#전주</span>
									<span>#영화제</span>
									<span>#여자만</span>
								</div>
								<div class="chat-count">
									<span>정원 2/10</span>
								</div>
							</div>
						</div>
					</div>
					<div class="my-course-list">
						<div class="my-course"></div>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const myChat = () => {
			document.querySelector(".my-chat-list").style.display = "block";
			document.querySelector(".my-course-list").style.display = "none";
			document.querySelector(".mypage-right-top button:first-child").style.backgroundColor = "#FFAF00";
			document.querySelector(".mypage-right-top button:last-child").style.backgroundColor = "white";
		}
		const myCourse = () => {
			document.querySelector(".my-chat-list").style.display = "none";
			document.querySelector(".my-course-list").style.display = "block";
			document.querySelector(".mypage-right-top button:first-child").style.backgroundColor = "white";
			document.querySelector(".mypage-right-top button:last-child").style.backgroundColor = "#FFAF00";
		}
		const memberDelete = (socialYn) => {
			if(socialYn == 'N'){
				location.href="/member/delete";
			}else{
				if(confirm("정말로 탈퇴하시겠습니까? ㅠㅠ")){
					location.href="/member/socialdelete";
				}
			}
		}
		const memberUpdate = () => {
			location.href="/member/update";
		}
	</script>
</body>
</html>