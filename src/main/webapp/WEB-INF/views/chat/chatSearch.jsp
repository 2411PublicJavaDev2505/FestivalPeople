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
			<form class="chat-list-search" action="chat/totalSearch"  >
				<input type="text" class="list-search-input" placeholder="검색" name="searchKeyword" value="${searchKeyword }">
				<button class="chat-search-btn" >⌕</button>
			</form>
		</section>
		<section class="chat-list-total">
			<!--좌 소속방목록-->
		 	<section class="mychat-list-wrap">
		<%--	<form class="mychat-list-search" action="/chat/mySearch" >
					<input type="text" class="list-search-input" placeholder="검색" name="mySearchKeyword" value="${mySearchKeyword }">
					<button class="chat-search-btn" type="submit">⌕</button>
				</form> --%>
				
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
			
			<!--우 전체목록-->
			<section class="allchat-list-wrap">
				<div class="chat-prev-list"><a href="/chat/totalSearch">←</a></div>
				<c:forEach items="${rSearchList }" var="cRoom" varStatus="i">
					<ul class="chat-list">
						<li class="chat-list-row">
							<a href="javascript:void(0);" onclick="checkAndEnter('${cRoom.chatroomNo}',${cRoom.chatMemberCount}, ${cRoom.chatLimit});" class="chat-link">
							<img class="chat-image" alt="${cRoom.chatImgName}" src="${cRoom.chatImgPath}">
							<div class="text-wrap">
								<div class="chat-title">${cRoom.chatroomTitle }</div>
								<div class="chat-tag">#${cRoom.tag1 } #${cRoom.tag2 } #${cRoom.tag3 }</div>
								<div class="chat-mem-count">정원 ${cRoom.chatMemberCount } / ${cRoom.chatLimit }</div>
							</div>
							</a>
						</li>
					</ul>            
				</c:forEach>
			</section>
		</section>
    </main>
    <!-- 푸터 -->
    </div>
    
	<script>
	/* 채팅방 입장 시  */
	function checkAndEnter(chatroomNo, currentCount, limitCount) {
		if(currentCount >= limitCount){
			alert("채팅방 정원이 가득 찼습니다.");
			return; // 만원 시 입장거부
		}
		
		fetch("/chat/check-access?chatroomNo=" + chatroomNo)
		.then(res => res.json())
		.then(data => {
			if (data.status === "joined") {
				// 가입자: 바로 입장
				location.href = "/chat/enter/" + chatroomNo;
			} else if (data.status === "notJoined") {
				// 미가입자: 팝업으로 물어봄
				const ok = confirm("첫입장을 환영합니다! 가입 후 입장하시겠습니까?");
				if (ok) {
					location.href = "/chat/enter/" + chatroomNo;
				}
			}
		})
		.catch(err => {
			alert("서버 오류 발생: " + err);
		});
	}

	</script>	
</body>
</html>