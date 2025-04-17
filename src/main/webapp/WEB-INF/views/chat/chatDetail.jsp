<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
	            <form class="mychat-list-search" action="#" >
	                <input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
	                <button class="chat-search-btn" type="submit">⌕</button>
	            </form>
	            
	            <!-- 참여방 없을 경우 -->
	            <c:if test="${empty myList }">
		            <span class="chat-notice">참여중인 채팅방이 없습니다</span>
	            </c:if>
	            <!-- 참여방 있을 경우 → 목록 출력--> 
	            <c:if test="${not empty myList }">
	       	        <c:forEach items="${myList }" var="myList" varStatus="i">
		            <ul class="chat-list">
		                <li class="chat-list-row">
							<a href="/chat/detail" class="chat-link">	            
							<img class="chat-image" alt="${myList.chatImgName}" src="${myList.chatImgPath}">
		                    <div class="text-wrap">
		                        <div class="chat-title">${myList.chatroomTitle }</div>
		                        <div class="chat-tag">#${myList.tag1 } #${myList.tag2 } #${myList.tag3 }</div>
		                        <div class="chat-mem-count">정원 ${myList.chatMemberCount } / ${myList.chatLimit }</div>
		                    </div>
		                    <div class="msg-alarm">2</div>
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
      					<div class="chat-header-title"><span>제목${chatRoom.chatroomTitle }</span>
      					<input type="hidden" value="${chatroomNo }" >
      					</div>
      				</div>
      				<div class ="chat-header-right">
			            <form action="#" >
			            <div  class="msg-search">
			                <input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
			                <button class="chat-search-btn" type="submit">⌕</button>
			            </div>
			            </form>
      					<div class="chat-menu">메뉴</div>
      				</div>
      			</header>
      			<section class="chat-area">
      				<div>
      				<c:forEach items="${msgList }" var="mList" varStatus="i">
      					<ul id="balloonList" class="group_msg_balloon">
      						<li class="date_check"><span>25.4.11.(금)</span></li>
	      					<c:if test="${sessionScope.memberNo != member.memberNo }">
      						<li class="msg-balloon-area">
      							<div class="profile-area">
	      							<div class="chat-profile-thumbnail">프사${member.profileFilePath }</div>
	      							<div class="chat-mem-nickname">닉넴${member.nickname }</div>
      							</div>
      							<div class="msg-balloon-area-l">
      								<p class="msg-balloon-box-l">내용${mList.chatMsgContent }</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음2</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>6:00${mList.chatMsgTime }</span>
	      								</span>
      								</div>
      							</div>
      						</li>
  							</c:if>
	      					<c:if test="${sessionScope.memberNo eq member.memberNo }">
      						<li class="msg-balloon-area-my">
      							<div class="msg-balloon-area-r">
      								<div class="msg-info-r">
	      								<p class="msg-non-read">안읽음4</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>5:26${mList.chatMsgTime }</span>
	      								</span>
      								</div>
      								<p class="msg-balloon-box-r">내용${mList.chatMsgContent }</p>
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
    	
    	document.querySelector("#addChat").addEventListener("click", function(){
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
    		
    		fetch("chat/msgInsert",{
				method:"POST",
				body: formData })
			.then(response => response.text())
			.then(result => {
				if(result >0){
					// 성공 시 메시지 목록 다시 불러오기 또는 화면에 추가
					document.querySelector("msgContent").value = "";
					location.reload(); 
				}
			});
   		});
    	
    	//입력이 있을 때만 버튼 활성화
    	msgInput.addEventListener("input", () => {
    		addChatBtn.disabled = msgInput.value.trim() === "";
    	});
    
    </script>
</body>
</html>