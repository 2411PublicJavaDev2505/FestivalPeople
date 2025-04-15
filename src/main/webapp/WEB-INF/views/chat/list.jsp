<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-목록</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/chat/chatLeftSide.css">
	<link rel="stylesheet" href="../resources/css/chat/list.css">
</head>
<body>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <!--상단 채팅방검색-->
    <main class="chat-main">
	    <section class="chat-nav">
	        <span>참여 채팅 수 : 0</span>
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
	            <span class="chat-notice">참여중인 채팅방이 없습니다</span>
	            <!-- 참여방 있을 경우 → 목록 출력--> 
	            <ul class="chat-list">
	                <li class="chat-list-row">
						<a href="/chat/detail" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div></a>
	                </li>
	                <li class="chat-list-row">
						<a href="#" class="chat-link">	            
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	            </ul> 
	            <form class="chat-room-make" action="/chat/insert">
	                <button type="submit">채팅방 생성</button>
	            </form>                 
	        </section>
	        <!--우 전체목록-->
	        <section class="allchat-list-wrap">
	            <ul class="chat-list">
	                <li class="chat-list-row">
	                	<a href="#" class="chat-link">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">제목</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 4/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	                <li class="chat-list-row">
	                	<a href="#" class="chat-link">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">제목</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 4/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	            </ul>            
	        </section>
	    </section>
    </main>
    <!-- 푸터 -->
    </div>
</body>
</html>