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
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
         crossorigin="anonymous"
    />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
					<div class="mypage-right content">
						<div class="my-chat-list">
							<c:if test="${myChatList.size() eq 0 }">
								<div class="my-chat">
									아직 참가한 채팅방이 없어요..
								</div>
							</c:if>
							<c:forEach items="${myChatList }" var="room">
								<div class="my-chat">
									<div class="my-chat-img">
										<img alt="채팅방 썸네일" src="${room.chatImgPath }" onclick="enterChatRoom('${room.chatroomNo}');">
									</div>
									<div class="chat-content">
										<h3 onclick="enterChatRoom('${room.chatroomNo}');">${room.chatroomTitle }</h3>
										<div class="chat-tag">
											<c:if test="${room.tag1 ne null }">
												<span>#${room.tag1 }</span>
											</c:if>
											<c:if test="${room.tag2 ne null }">
												<span>#${room.tag2 }</span>
											</c:if>
											<c:if test="${room.tag3 ne null }">
												<span>#${room.tag3 }</span>
											</c:if>
										</div>
										<div class="chat-count">
											<span>정원 ${room.chatMemberCount}/${room.chatLimit }</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="my-course-list">
							<c:if test="${courseList.size() eq 0 || courseList eq null }">
								<div class="course-content">아직 저장한 코스가 없어요..ㅜㅜ</div>
							</c:if>
							<c:if test="${courseList ne null }">
								<c:forEach items="${courseList }" var="course">
									<div class="course-content">
										<div class="course-content-left">
											<img alt="축제 이미지" src="${course.festivalImg }">
											<h5>${course.festivalName }</h5>
										</div>
										<div class="course-content-right">
											<h4>${course.courseName }</h4>
											<div class="course-detail">
												<c:if test="${course.matzipPlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/matzip.png">
														<span>${course.matzipPlaceName }</span>
													</div>
												</c:if>
												<c:if test="${course.hotelPlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/hotel.png">
														<span>${course.hotelPlaceName }</span>
													</div>
												</c:if>
												<c:if test="${course.cafePlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/cafe.png">
														<span>${course.cafePlaceName }</span>
													</div>
												</c:if>
												<c:if test="${course.tourPlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/tour.png">
														<span>${course.tourPlaceName }</span>
													</div>
												</c:if>
												<c:if test="${course.parkingPlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/parking.png">
														<span>${course.parkingPlaceName }</span>
													</div>
												</c:if>
												<c:if test="${course.culturePlaceName ne null }">
													<div class="course-detail idx">
														<img alt="아이콘" src="../resources/img/course/icon/culture.png">
														<span>${course.culturePlaceName }</span>
													</div>
												</c:if>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
		const enterChatRoom = (chatroomNo) => {
			location.href="/chat/enter/"+chatroomNo;
		}
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
				Swal.fire({
			          title: '정말 탈퇴하시겠습니까??',
			          text: "정말로요..?..ㅠㅠ..",
			          icon: 'warning',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '예',
			          cancelButtonText: '아니요',
			          reverseButtons: true, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
			          if (result.isConfirmed) {
			        	  location.href="/member/socialdelete";
			          }
			        })
			}
		}
		const memberUpdate = () => {
			location.href="/member/update";
		}
	</script>
</body>
</html>