<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-목록</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/chat/chatDetail.css">
	<link rel="stylesheet" href="../resources/css/chat/chatLeftSide.css">
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
		                        <div class="chat-mem-count">정원 0 / ${myList.chatLimit }</div>
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
      					<div class="chat-header-title"><span>튤립축제 동행 구해요</span></div>
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
      					<ul class="group_msg_balloon">
      						<li class="date_check"><span>25.4.11.(금)</span></li>
      						<li class="msg-balloon-area">
      							<div class="profile-area">
	      							<div class="chat-profile-thumbnail">프사</div>
	      							<div class="chat-mem-nickname">펭펭</div>
      							</div>
      							<div class="msg-balloon-area-l">
      								<p class="msg-balloon-box-l">안녕하세요오<br>마감 며칠까지에영?<br>
									</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음2</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>6:00</span>
	      								</span>
      								</div>
      							</div>
      						</li>
      						<li class="msg-balloon-area">
      							<div class="profile-area">
	      							<div class="chat-profile-thumbnail">프사</div>
	      							<div class="chat-mem-nickname">쿵치팍치</div>
      							</div>
      							<div class="msg-balloon-area-l">
      								<p class="msg-balloon-box-l">사람들 얼마나 더 모으실 예정인가요?<br>
									</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음2</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>6:00</span>
	      								</span>
      								</div>
      							</div>
      						</li>
      						<li class="msg-balloon-area">
      							<div class="profile-area">
	      							<div class="chat-profile-thumbnail">프사</div>
	      							<div class="chat-mem-nickname">먕먕</div>
      							</div>
      							<div class="msg-balloon-area-l">
      								<p class="msg-balloon-box-l">정원까지 꽉 채우시나요<br>
									</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음2</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>6:00</span>
	      								</span>
      								</div>
      							</div>
      						</li>
      						<li class="msg-balloon-area">
      							<div class="profile-area">
	      							<div class="chat-profile-thumbnail">프사</div>
	      							<div class="chat-mem-nickname">방장이지롱</div>
      							</div>
      							<div class="msg-balloon-area-l">
      								<p class="msg-balloon-box-l">어느 정도 모였으면 시간대랑 출발지를 정해야 할 것 같아요<br>
일단 우리는 대중교통으로 가는 게 목적이니까 아예 에버라인에서 만나는 걸로 할까요? 아니면 에버랜드 주차장에서 만나는게 더 낫나요?</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음2</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>6:12</span>
	      								</span>
      								</div>
      							</div>
      						</li>
      						<li class="msg-balloon-area-my">
      							<div class="msg-balloon-area-r">
      								<div class="msg-info-r">
	      								<p class="msg-non-read">안읽음4</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>5:26</span>
	      								</span>
      								</div>
      								<p class="msg-balloon-box-r">저는 전철역이요</p>
      							</div>
      						</li>
      					</ul>
      				</div>
      			</section>
      			<footer class="chat-write">
      				<label id="fileUploadBtn" class="upload-btn" for="fileUploaderInput">🔗</label>
      				<form action="#" method="post" enctype="multipart/form-data">
      					<input id="fileUploaderInput" name="files[]" type="file">
      				</form>
      				<div class="chat-input-area">
      					<textarea class="chat-input" maxlength="2000" placeholder="메시지를 입력하세요"></textarea>
      				</div>
      				<button class="chat-btn-submit" type="submit">➤</button>
      			</footer>
	        </section>
	    </section>
    </main>
    <!-- 푸터 -->
    </div>
</body>
</html>