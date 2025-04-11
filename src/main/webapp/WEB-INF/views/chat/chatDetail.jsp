<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-목록</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
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
	            <!-- 참여방 있을 경우 → 목록 출력--> 
	            <ul class="chat-list">
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	            </ul> 
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	            </ul> 
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">튤립축제 동행 구해요</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 6/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">전주국제영화제 같이 가실 분</div>
	                        <div class="chat-tag">#전주 #영화제 #여자만</div>
	                        <div class="chat-mem-count">정원 2/10</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	                <li class="chat-list-row">
	                    <div class="chat-image">그림</div>
	                    <div class="text-wrap">
	                        <div class="chat-title">마라톤 동행 구합니다</div>
	                        <div class="chat-tag">태그</div>
	                        <div class="chat-mem-count">정원 12/30</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                </li>
	            </ul> 
	            <form class="chat-room-make" action="#">
	                <button type="submit">채팅방 생성</button>
	            </form>                 
	        </section>
	        <!--우 채팅방 상세 -->
	        <section class="chat-msg-list">
      			<header class="chat-header">
      				<div class = "chat-header-left">
      					<div class="chat-prev-list">←</div>
      					<div class="chat-header-title"><span>튤립축제 동행 구해요</span></div>
      				</div>
      				<div class ="chat-header-right">
			            <form class="msg-search" action="#" >
			                <input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
			                <button class="chat-search-btn" type="submit">⌕</button>
			            </form>
      					<div class="chat-menu"></div>
      				</div>
      			</header>
      			<section class="chat-area">
      				<div>
      					<ul class="group_msg_balloon">
      						<li class="date_check"><span>2025년 4월 11일 금요일</span></li>
      						<li class="msg-balloon-area">
      							<div class="chat-profile-thumbnail">프사</div>
      							<div class="chat-mem-nickname"></div>
      							<div class="msg-balloon-area-l">
      								<p>어느 정도 모였으면 시간대랑 출발지를 정해야 할 것 같아요<br>
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
      								<p>저는 전철역이요</p>
      								<div class="msg-info">
	      								<p class="msg-non-read">안읽음4</p>
	      								<span class="msg-time">
	      									<span>오후</span>
	      									<span>5:26</span>
	      								</span>
      								</div>
      							</div>
      						</li>
      					</ul>
      				</div>
      			</section>
      			<footer class="chat-write">
      				<label id="fileUploadBtn" class="upload-btn" for="fileUploaderInput">첨부아이콘</label>
      				<form action="#" method="post" enctype="multipart/form-data">
      					<input id="fileUploaderInput" name="files[]" type="file">
      				</form>
      				<div class="chat-input-area">
      					<textarea class="chat-input" maxlength="2000" placeholder="메시지를 입력하세요"></textarea>
      				</div>
      				<button class="chat-btn-submit" type="submit">전송아이콘</button>
      			</footer>
	        </section>
	    </section>
    </main>
    <!-- 푸터 -->
    </div>
</body>
</html>