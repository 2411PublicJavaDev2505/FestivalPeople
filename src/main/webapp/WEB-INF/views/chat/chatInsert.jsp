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
	<link rel="stylesheet" href="../resources/css/chat/chatLeftSide.css">
	<link rel="stylesheet" href="../resources/css/chat/chatInsert.css">
</head>
<body>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <main class="chat-main">
		<!--상단 채팅방검색-->
		<section class="chat-nav">
			<span>${member.nickname } 참여 채팅 수 : 0</span>memNo.${member.memberNo }
			<form action="/chat/totalSearch" class="chat-list-search"  >
				<input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
				<button class="chat-search-btn" >⌕</button>
			</form>
		</section>
		<section class="chat-list-total">
			<!--좌 소속방목록-->
 			<section class="mychat-list-wrap">
<!--				<form class="mychat-list-search" action="#" >
					<input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
					<button class="chat-search-btn" type="submit">⌕</button>
				</form> -->
				
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
								<img class="chat-image" alt="${myList.chatImgName}" src="${myList.chatImgPath}">
								<div class="text-wrap">
									<div class="chat-title">${myList.chatroomTitle }</div>
									<div class="chat-tag">#${myList.tag1 } #${myList.tag2 } #${myList.tag3 }</div>
									<div class="chat-mem-count">정원 ${myList.chatMemberCount } / ${myList.chatLimit }</div>
								</div>
								<div class="msg-alarm">알림</div>
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
			${member.nickname }님 안녕!
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
						<button type="button" onclick="imgUp()" id=imgUploadBtn >대표사진 선택</button>
						<input id="imgInput" accept="image/*" name="image" type="file" onchange="setThumbnail(event);" style="display: none;">
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
	</div>

	<script type="text/javascript">
		<!-- 채팅방 제목 글자 카운트(30자 제한) --> //현재 작동안되고 있는 중 ㅠ
		document.addEventListener("DOMContentLoaded", function () {
			const chatRoomTitle = document.getElementById("chatRoomTitle");
			const maxlength = 30; // 최대 글자수

			chatRoomTitle.addEventListener("input", function () {
				const currentLength = chatRoomTitle.value.length;

				// 초과 글자수 제거
				if (currentLength > maxlength) {
					chatRoomTitle.value = chatRoomTitle.value.substr(0, maxlength);
				}

				// 글자수 업데이트
				const charCountSpan = document.getElementById("charCount");
				if (charCountSpan) {
					charCountSpan.textContent = `${chatRoomTitle.value.length}/${maxlength}`;
				}
			});
		});
		
		
		
		<!-- 이미지 삽입 -->
		function imgUp(){
			const imgInput = document.getElementById("imgInput");
			imgInput.click();
		}
		<!-- 썸네일 이미지 -->	    
		function setThumbnail(event){
			const reader = new FileReader();
			
			// 파일 읽는 것을 성공했을 때 실행
			reader.onload = function(event){
				const img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				
				// 기존 이미지를 제거하고 새 이미지를 추가
				const imgUploadBtn = document.querySelector("#imgUploadBtn");
				imgUploadBtn.innerHTML = ""; // 기존 내용을 비움
				imgUploadBtn.appendChild(img);

				// 이미지 스타일 설정
				img.style.width = "100%"; // 버튼 너비에 맞춤
				img.style.height = "100%"; // 버튼 높이에 맞춤
				img.style.objectFit = "cover"; // 이미지 비율을 유지하며 버튼 크기에 맞게 자름
				img.style.borderRadius = "10px"; // 버튼과 동일한 둥근 모서리 적용
			};    		
			reader.readAsDataURL(event.target.files[0]);
		}
			
		
    </script>
</body>
</html>