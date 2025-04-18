<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
	<!-- 광고 배너 -->
	<div class="side-banner left-banner">
        <a href="http://localhost:8888/festival/detail/287"><img src="../resources/img/review/banner-poster.jpg" alt="왼쪽 광고" /></a>
    </div>
    <div class="side-banner right-banner">
        <a href="http://localhost:8888/festival/detail/288"><img src="../resources/img/review/banner-posterR.jpg" alt="오른쪽 광고" /></a>
    </div>
    <!-- 바탕화면 -->
	<div class="background-image">
    	 <img src="../resources/img/chat/chat-background.jpg" alt="바탕화면">
    </div>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <!--상단 채팅방검색-->
    <main class="chat-main">
	    <section class="chat-nav">
	        <span>${member.nickname } 참여 채팅 수 : 0</span> memNo.${member.memberNo }
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
							<a href="/chat/detail/${myList.chatroomNo }" class="chat-link">	            
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
	        
	        <!--우 전체목록-->
	        <section class="allchat-list-wrap">
	        <c:forEach items="${cRooms }" var="cRoom" varStatus="i">
	            <ul class="chat-list">
	                <li class="chat-list-row">
	                	<a href="/chat/detail/${cRoom.chatroomNo }" class="chat-link">
	                    <img class="chat-image" alt="${cRoom.chatImgName}" src="${cRoom.chatImgPath}">
	                    <div class="text-wrap">
	                        <div class="chat-title">${cRoom.chatroomTitle }</div>
	                        <div class="chat-tag">#${cRoom.tag1 } #${cRoom.tag2 } #${cRoom.tag3 }</div>
	                        <div class="chat-mem-count">정원 ${cRoom.chatMemberCount } / ${cRoom.chatLimit }</div>
	                    </div>
	                    <div class="msg-alarm">4</div>
	                    </a>
	                </li>
	            </ul>            
	        </c:forEach>
	        </section>
	    </section>
    </main>
    <!-- 푸터 -->
    </div>
</body>
</html>