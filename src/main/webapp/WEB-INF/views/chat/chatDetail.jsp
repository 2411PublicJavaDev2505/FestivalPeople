<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chatDetail.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chatLeftSide.css">
	
</head>
<body>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <main class="chat-main">
		<!--상단 채팅방검색-->
		<section class="chat-nav">
			<span>${member.nickname }참여 채팅 수 : 0</span> memNo.${member.memberNo }
			<form class="chat-list-search" action="#" >
				<input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
				<button class="chat-search-btn" >⌕</button>
			</form>
		</section>
		<section class="chat-list-total">
			<!--좌 소속방목록-->
			<section class="mychat-list-wrap">
<!-- 				<form class="mychat-list-search" action="#" >
					<input type="text" class="list-search-input" placeholder="검색" name="mySearchKeyword">
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
			<!--우 채팅방 상세 -->
			<section class="chat-msg-list">
				<header class="chat-header">
					<div class = "chat-header-left">
						<div class="chat-prev-list"><a href="/chat/list">←</a></div>
						<div class="chat-header-title"><span>${chatRoom.chatroomTitle }</span>
						<input type="hidden" value="${chatroomNo }" >
						</div>
					</div>
					<div class ="chat-header-right">
						<div  class="msg-search">
							<input type="text" id="msgSearch" class="list-search-input" placeholder="검색" name="searchKeyword">
							<button id="searchMoveBtn" class="chat-search-btn" type="submit">⌕</button>
						</div>
						<!-- 메뉴 버튼- 모달창 -->
						<button class="chat-menu-open">메뉴</button>
					</div>
					<div class="menu-wrapper hidden">
						<div class="modal-overlay"></div><!-- 반투명 배경 -->
						<div class="slide-menu">
							<button class="chat-menu-close">Χ</button>
							<ul>
								<li>
									<c:if test="${sessionScope.memberNo ne chatRoom.memberNo}">
											<a herf="/report/content"><button>채팅방 신고</button></a>
									</c:if>
								</li>
								<li>
									<form action="/chat/leave" id="leaveForm" method="get">
										<input type="hidden" name="chatroomNo" value="${chatRoom.chatroomNo }">
										<button type="button" onclick="leaveConfirm(${chatRoom.chatroomNo});">채팅방 나가기</button>
									</form>
								</li>
								<li>
									<c:if test="${sessionScope.memberNo eq chatRoom.memberNo}">
									<form action="/chat/delete" id="deleteForm" method="get">
										<input type="hidden" name="chatroomNo" value="${chatRoom.chatroomNo }">
										<button type="button" onclick="deleteConfirm(${chatRoom.chatroomNo});">채팅방 삭제</button>
									</form>
									</c:if>
								</li>	
							</ul>
							<ul>
								<c:forEach items="${memberList }" var="mbList" varStatus="i">
									<li>
										<c:if test="${sessionScope.memberNo eq mbList.memberNo }">
											<div>(나)${mbList.nickname }</div>
										</c:if>
										<c:if test="${sessionScope.memberNo ne mbList.memberNo }">
											<div>${mbList.nickname }</div>
										</c:if>
										<c:if test="${sessionScope.memberNo eq chatRoom.memberNo }">	<!-- 방장표시  -->																			
											<div><img src="${mbList.profileFilePath }" width="40" />⭐ </div>
										</c:if>	
										<c:if test="${sessionScope.memberNo ne chatRoom.memberNo }">																			
											<div><img src="${mbList.profileFilePath }" width="40" /></div>
										</c:if>	
										<c:if test="${sessionScope.memberNo eq chatRoom.memberNo}">
										<form action="/chat/block" method="get" id="blockForm${mbList.memberNo }">									
											<input type="hidden" name="chatroomNo" value="${chatRoom.chatroomNo }">
											<input type="hidden" name="blockMemberNo" value="${mbList.memberNo }"> <!-- 블락할 멤버 -->
											<button type="button" onclick="blockConfirm(${mbList.memberNo});">내보내기</button>
										</form>
										</c:if>
									</li>
								</c:forEach>														
							</ul>
						</div>
					</div>
				</header>
				
				<section class="chat-area">
					<div>
					<c:forEach items="${msgList }" var="mList" varStatus="i">
						<ul id="balloonList" class="group_msg_balloon">
						
							<!-- 날짜 한번만 출력(중복출력불가) -->
							<c:set var="preDate" value=""/>
							<c:set var="currentDate" value="${mList.chatMsgTime.time }"/>
							<fmt:formatDate  var="formattedDate" value="${mList.chatMsgTime}" pattern="yyyy.MM.dd(E)"/>
							
							<c:if test="${formattedDate ne prevDate}">
								<li class="date_check"><span>${formattedDate}</span></li>
								<c:set var="prevDate" value="${formattedDate}" />
							</c:if>
							
							<!-- 다른사람 채팅은 왼쪽에 -->
							<c:if test="${sessionScope.memberNo != mList.memberNo }">
							<li class="msg-balloon-area">
								<div class="profile-area">
									<div class="chat-profile-thumbnail">${member.profileFilePath }</div>
									<div class="chat-mem-nickname">${member.nickname }</div>
								</div>
								<div class="msg-balloon-area-l">
									<p class="msg-balloon-box-l">${mList.chatMsgContent }</p>
									<div class="msg-info">
										<p class="msg-non-read">안읽음</p>
										<span class="msg-time">
											<fmt:formatDate value="${mList.chatMsgTime}" pattern="a h:mm" />
										</span>
									</div>
								</div>
							</li>
							</c:if>
							<!-- 내 채팅은 오른쪽에 -->
							<c:if test="${sessionScope.memberNo eq mList.memberNo }">
							<li class="msg-balloon-area-my">
								<div class="msg-balloon-area-r">
									<div class="msg-info-r">
										<p class="msg-non-read">안읽음</p>
										<span class="msg-time">
											<fmt:formatDate value="${mList.chatMsgTime}" pattern="a h:mm" />
										</span>
									</div>
									<p class="msg-balloon-box-r">${mList.chatMsgContent }</p>
								</div>
							</li>
							</c:if>
						</ul>
					</c:forEach>	
					</div>
				</section>
				<footer class="chat-write">
					<label id="fileUploadBtn" class="upload-btn" for="fileUploaderInput">🔗</label>
					<input id="fileUploaderInput" name="files[]" type="file">
					<div class="chat-input-area">
						<textarea id="msgContent" class="chat-input" maxlength="2000" placeholder="메시지를 입력하세요"></textarea>
					</div>
					<button id="addChat" class="chat-btn-submit" type="submit">➤</button>
				</footer>
			</section>
		</section>
	</main>
	<!-- 푸터 -->
	</div>

	<script>
		const chatroomNo = "${chatroomNo}"
		
		/* 채팅창 입장 시 팝업 및 가입 */
		document.querySelector("#addChat").addEventListener("click", function(){
			
			console.log("댓글 버튼 눌림")
			
			const msgContent = document.querySelector("#msgContent").value.trim(); //.trim()을 추가하면 공백여부 가려줌
			const fileInput = document.querySelector("#fileUploaderInput");
			
			// 아무 입력 없으면 알림없이 return (서버 미전송으로 완료)
			if (msgContent === "" && fileInput.files.length === 0){
				return;
			}
			
			const formData = new FormData();
			formData.append("chatroomNo",chatroomNo);
			formData.append("msgContent",msgContent);
			
			if(fileInput.files.length > 0){
				formData.append("uplodeFile", fileInput.files[0]);
			}
			
			fetch("/chat/msgInsert",{
				method:"POST",
				body: formData })
			.then(response => response.text())
			.then(result => {
				if(result >0){
					// 성공 시 메시지 목록 다시 불러오기 또는 화면에 추가
					location.reload(); 
				}
			});
		});
		
		/* 메뉴창 팝업 */
		const openBtn = document.querySelector('.chat-menu-open');
		const closeBtn = document.querySelector('.chat-menu-close');
		const wrapper = document.querySelector('.menu-wrapper');
		const overlay = document.querySelector('.modal-overlay');
		
		openBtn.addEventListener('click', () => {
			wrapper.classList.add('visible');
		});

		const closeModal = () => {
			wrapper.classList.remove('visible');
		};

		closeBtn.addEventListener('click', closeModal);
		overlay.addEventListener('click', closeModal); // 채팅화면 눌러도 창 닫힘
		
		/* 채팅방 삭제 */
		function deleteConfirm(chatroomNo) {
			var result = confirm("정말로 삭제하시겠습니까?");
			if(result) {
				document.getElementById('deleteForm').submit();
			}
		}		
		
		/* 채팅방 탈퇴 */
		function leaveConfirm(chatroomNo) {
			var result = confirm("정말 이 방을 나가시겠어요? 채팅방을 나가면 나의 채팅방 목록에서 삭제됩니다.");
			if(result) {
				document.getElementById('leaveForm').submit();
			}
		}		
		
		/* 회원 강퇴(방장) */
		function blockConfirm(memberNo) {
			var result = confirm("정말로 내보내시겠습니까?");
			if(result) {
				document.getElementById('blockForm'+memberNo).submit();
			}
		}		
		
		/* 메시지 검색 시 하이라이트 표시 */
		var matchedElements = [];
		var highlightIndex = 0;
		
		// 검색어 입력 시 하이라이트
		$('#msgSearch').on('input', function () {
		    var keyword = $(this).val().trim();
		    matchedElements = [];
		    highlightIndex = 0;
		
		    // 기존 하이라이트 제거
		    $('.msg-balloon-box-l, .msg-balloon-box-r').each(function () {
		        $(this).html($(this).text());
		    });
		
		    if (keyword !== "") {
		        var regex = new RegExp("(" + keyword + ")", "gi");
		
		        $('.msg-balloon-box-l, .msg-balloon-box-r').each(function () {
		            var originalText = $(this).text();
		            if (regex.test(originalText)) {
		                var highlighted = originalText.replace(regex, "<span class='txt-hlight'>$1</span>");
		                $(this).html(highlighted);
		                matchedElements.push(this);
		            }
		        });
		        // 역순으로 이동 시작
		        highlightIndex = matchedElements.length - 1; 
		    }
		});
		
		// 버튼 클릭 시 역순으로 이동
		$('#searchMoveBtn').on('click', function () {
		    if (matchedElements.length > 0 && highlightIndex >= 0) {
		        matchedElements[highlightIndex].scrollIntoView({ behavior: "smooth", block: "center" });
		        highlightIndex--; //위로이동
		    }
		});
		
		/*  페이지 진입 또는 새로고침 시 가장 마지막 메시지로 스크롤 */
		window.addEventListener('load', function () {
		    var lastMsg = document.querySelector('.group_msg_balloon:last-child');
		    if (lastMsg) {
		        lastMsg.scrollIntoView({ behavior: "auto", block: "end" });
		    }
		});
		
    </script>
</body>
</html>