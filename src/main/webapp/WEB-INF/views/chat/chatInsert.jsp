<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-채팅방생성</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<link rel="stylesheet" href="../resources/css/chat/chatLeftSide.css">
	<link rel="stylesheet" href="../resources/css/chat/chatInsert.css">
</head>
<body>
    <!-- 바탕화면 -->
	<div class="background-image">
		<img src="../resources/img/chat/chat-background.jpg" alt="바탕화면">
    </div>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <main class="chat-main">
		<!--상단 채팅방검색-->
		<section class="chat-nav">
			<span>${member.nickname }님 접속중</span>
			<form action="/chat/totalSearch" class="chat-list-search"  >
				<input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
				<button class="chat-search-btn" >⌕</button>
			</form>
		</section>
		<section class="chat-list-total">
			<!--좌 소속방목록-->
 			<section class="mychat-list-wrap">
				<!-- 참여방 없을 경우 -->
				<c:if test="${empty myList }">
					<span class="chat-notice">참여중인 채팅방이 없습니다</span>
				</c:if>
				<!-- 참여방 있을 경우 → 목록 출력--> 
				<c:if test="${not empty myList }">
					<c:forEach items="${myList }" var="myList" varStatus="i">
						<ul class="chat-list">
							<li class="chat-list-row">
								<a href="/chat/detail/${myList.chatroomNo }" class="chat-link">	            
									<c:if test="${myList.chatImgPath eq null }">          
										<img class="chat-image" src="../resources/img/member/profile.png" alt="" >
									</c:if>
									<c:if test="${myList.chatImgPath ne null }">          
										<img class="chat-image" src="${myList.chatImgPath}" alt="${myList.chatImgName}" >
									</c:if>
								<div class="text-wrap">
									<div class="chat-title">${myList.chatroomTitle }</div>
									<div class="chat-tag">
										<c:if test="${myList.tag1 ne null }">
											<span>#${myList.tag1 }</span>
										</c:if>
										<c:if test="${myList.tag2 ne null }">
											<span>#${myList.tag2 }</span>
										</c:if>
										<c:if test="${myList.tag3 ne null }">
											<span>#${myList.tag3 }</span>
										</c:if>										
									</div>
									<div class="chat-mem-count">정원 ${myList.chatMemberCount } / ${myList.chatLimit }</div>
								</div>
								<c:if test="${myList.nonCheckMsg> 0 }" >
									<div class="msg-alarm">${myList.nonCheckMsg }</div>
								</c:if>
								</a>
							</li>
						</ul> 
					</c:forEach>
				</c:if>
				<form class="chat-room-make" action="/chat/insert">
					<button type="submit">채팅방 생성</button>
				</form>                 
			</section>
			<!--우 채팅방 만들기 상세 -->
			<section class="chat-room-insert">
			<form action="/chat/insert" method="post" enctype="multipart/form-data">
				<input type="hidden" name="memberNo"  value="${member.memberNo }">
				<div class = "room-header">
					<div class="chat-prev-list"><a href="/chat/list">←</a></div>
					<div class="chat-header-title"><span>채팅방 만들기</span></div>
				</div>
				<div class ="chat-room-top">
					<input name="chatroomTitle" id="chatRoomTitle" type="text" placeholder="채팅방 이름(필수)">
					<div id="charLength">
						<span id="charCount">0/30</span>
					</div>
				</div>
				<div class ="room-tag-group">
					<input name="tag1" class="room-tag1"  type="text" placeholder="#태그1">
					<input name="tag2" class="room-tag2"  type="text" placeholder="#태그2">
					<input name="tag3" class="room-tag3"  type="text" placeholder="#태그3">
				</div>
				<div class ="chat-room-bottom">
					<div class="image-group">
						<button type="button" onclick="imgUp()" id=imgUploadBtn >
							<img alt="" src="../resources/img/member/profile.png" id="profile-img">
							<span id="uploadText">대표사진 선택</span>
						</button>
						<input id="imgInput" accept="image/*" name="image" type="file" onchange="setThumbnail(event);" style="display: none;">
						<button type="button" id="cancelBtn" onclick="resetImage()" style="display: none;">취소</button>
					</div>
					<div class="right-group">
						<div class ="chat-mem-limit">
							<input name="chatLimit" class="room-mem"  type="text" placeholder="인원(최대50)">
						</div>
						<button type="submit" class ="room-register-button">완료</button>
					</div>
				</div>
			</form>
			</section>
		</section>
	</main>
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>

	<script type="text/javascript">
		/* 채팅방 검색 시 방 생성 계속 진행 여부 */
		 let isFormChanged = false; // 폼이 변경되었는지 여부

	    // 검색창을 클릭했을 때 변경사항이 있을 경우 확인창을 띄움
	    document.querySelector('.list-search-input').addEventListener('input', function () {
	        isFormChanged = true;
	    });
	    document.querySelector('.chat-list-search').addEventListener('submit', function (event) {
	        if (isFormChanged) {
	            const userConfirm = confirm("채팅방 생성을 취소하시겠습니까?");
	            if (!userConfirm) {
	                event.preventDefault(); // 사용자가 취소를 누르면 폼 전송을 막음
	            }
	        }
	    });
	
	
	
		document.addEventListener("DOMContentLoaded", function () {
			
			/* 채팅방 제목 글자 카운트(30자 제한) */
			const chatRoomTitle = document.getElementById("chatRoomTitle");
			const maxlength = 30; // 최대 글자수
			const charCountSpan = document.getElementById("charCount"); // 글자수 표시할 자리 요소

			chatRoomTitle.addEventListener("input", function () {
				const currentLength = chatRoomTitle.value.length;

				// 초과 글자수 제거
				if (currentLength > maxlength) {
					chatRoomTitle.value = chatRoomTitle.value.substr(0, maxlength);
				}

				// 글자수 업데이트
				if (charCountSpan) {
					charCountSpan.textContent = currentLength + "/30";
				}
			});
			/* 정원 제한 */
			const chatLimitInput = document.querySelector(".room-mem");
			chatLimitInput.addEventListener("input", function(){
				this.value = this.value.replace(/[^0-9]/g, '');
				if(this.value !== '' && parseInt(this.value) > 50) {
					this.value = 50;
				}
			});
		});
		
		/* 이미지 삽입  */
		function imgUp(){
			const imgInput = document.getElementById("imgInput");
			imgInput.click();
		}
		/* 썸네일 이미지 */	    
		function setThumbnail(event){
			const reader = new FileReader();
			
			// 파일 읽는 것을 성공했을 때 실행
			reader.onload = function(event){
				const img = document.getElementById("profile-img");
				const uploadText = document.getElementById("uploadText");
				const cancelBtn = document.getElementById("cancelBtn");
				img.src = event.target.result; // 기존 이미지 태그의 src 변경
				img.style.filter = "none"; // 업로드 후 블러 제거
				uploadText.style.display = "none"; // 글씨 숨기기
				
				// 이미지 선택했을 때만 취소 버튼 노출
				cancelBtn.style.display = "inline-block";
			};    		
			reader.readAsDataURL(event.target.files[0]);
		}
		// 이미지 취소하기
		function resetImage() {
			const imgInput = document.getElementById("imgInput");
			const cancelBtn = document.getElementById("cancelBtn");
			const img = document.getElementById("profile-img");
			const uploadText = document.getElementById("uploadText");
			img.src = "../resources/img/member/profile.png"; // 기본 이미지로 복구
			img.style.filter = "blur(2px)"; //블러 초기화
			uploadText.style.display = "inline"; // 글씨 다시 보이게
			cancelBtn.style.display = "none"; // 취소버튼 숨기기
			imgInput.value = ""; // 입력값 초기화
		}
		
    </script>
</body>
</html>