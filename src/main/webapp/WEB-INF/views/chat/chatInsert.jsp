<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	        <span>참여 채팅 수 : 0</span>
	        <div class="chat-list-search" >
		        <form action="#" >
		            <input type="text" class="list-search-input" placeholder="검색" name="searchKeyword">
		            <button class="chat-search-btn" >⌕</button>
		        </form>
	        </div>
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
	        <!--우 채팅방 만들기 상세 -->
	        <section class="chat-room-insert">
	        <form action="/chat/insert" method="post">
   				<div class = "room-header">
   					<div class="chat-prev-list"><a href="#">←</a></div>
   					<div class="chat-header-title"><span>채팅방 만들기</span></div>
   				</div>
				<div class ="chat-room-top">
   					<input id="chatRoomTitle"  type="text" maxlength="90" placeholder="채팅방 이름(필수)">
   					<span id="charCount">0/30</span>
				</div>
				<div class ="room-tag-group">
   					<input class="room-tag1"  type="text" placeholder="#태그1">
   					<input class="room-tag2"  type="text" placeholder="#태그2">
   					<input class="room-tag3"  type="text" placeholder="#태그3">
				</div>
				<div class ="chat-room-bottom">
					<div class="image-group">
						<button id=roomImageUpload>대표사진 선택</button>
	   					<input id="imageInput" type="file" style="display: none;">
					</div>
					<div class="right-group">
	      				<div class ="chat-mem-limit">
		   					<input class="room-mem"  type="text" placeholder="인원(최대50)">
	      				</div>
	      				<button class ="room-register-button">완료</button>
					</div>
				</div>
	        </form>
	        </section>
	    </section>
    </main>
    <!-- 푸터 -->
    </div>
    
    <script >
	    <!-- 채팅방 제목 글자 카운트 -->
	    const title = document.getElementById('chatRoomTitle');
	    const counter = document.getElementById('charCount');	
	    input.addEventListener('title', () => {
	      const length = title.value.length;
	      counter.textContent = `${length}/90`;
	    });
	    
	    <!-- 채팅방 대표 이미지 첨부 -->
	    document.getElementById('uploadBtn').addEventListener('click', function() {
	    	  document.getElementById('fileInput').click();
	    });
    </script>
</body>
</html>