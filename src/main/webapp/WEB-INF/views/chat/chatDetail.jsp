<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>같이갈래-목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chatDetail.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chatLeftSide.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
    <!-- 바탕화면 -->
	<div class="background-image">
		<img src="${pageContext.request.contextPath}/resources/img/chat/chat-background.jpg" alt="바탕화면">
    </div>
    <div id="container">
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <main class="chat-main">
		<!--상단 채팅방검색-->
		<section class="chat-nav">
			<p>${member.nickname }님 접속중</p>
			<form class="chat-list-search" action="/chat/totalSearch" >
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
									<img class="chat-image" src="../../resources/img/member/profile.png" alt="채팅방 이미지" >
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
							<ul class="menu-top">
								<div class="menu-button-area">
								<c:if test="${sessionScope.memberNo ne chatRoom.memberNo}">
									<li>
										<button onclick="report('${chatRoom.chatroomNo}');">채팅방 신고</button>
									</li>
								</c:if>
								<c:if test="${sessionScope.memberNo ne chatRoom.memberNo}">
									<li>
										<form action="/chat/leave" id="leaveForm" method="get">
											<input type="hidden" name="chatroomNo" value="${chatRoom.chatroomNo }">
											<button type="button" onclick="leaveConfirm(${chatRoom.chatroomNo});">채팅방 나가기</button>
										</form>
									</li>
								</c:if>
								<c:if test="${sessionScope.memberNo eq chatRoom.memberNo}">
									<li>
									<form action="/chat/delete" id="deleteForm" method="get" >
										<input type="hidden" name="chatroomNo" value="${chatRoom.chatroomNo }">
										<button type="button" onclick="deleteConfirm(${chatRoom.chatroomNo});">채팅방 삭제</button>
									</form>
									</li>	
								</c:if>
								</div>
							</ul>
							<ul class="mem-profile">
								<span class="mem-count">우리방 인원 : ${chatRoom.chatMemberCount }</span>
								<c:forEach items="${memberList }" var="mbList" varStatus="i">
									<li class="memlist-area">
										<div class="memlist-area">
											<c:if test="${mbList.profileFilePath eq null }">										
												<img src="../../resources/img/member/profile.png" width="40" />
											</c:if>	
											<c:if test="${mbList.profileFilePath ne null }">										
												<img src="${mbList.profileFilePath }" width="40" />
											</c:if>	
											<c:choose>
												<c:when test="${sessionScope.memberNo eq mbList.memberNo }">
													<div>(나)${mbList.nickname }</div>
												</c:when>
												<c:otherwise>
													<div>${mbList.nickname }</div>
												</c:otherwise>	
											</c:choose>
											<c:if test="${mbList.memberNo == chatRoom.memberNo }">	<!-- 방장표시  -->																			
												<span>⭐</span> 
											</c:if>	
										</div>
										<c:if test="${sessionScope.memberNo eq chatRoom.memberNo and mbList.memberNo ne sessionScope.memberNo}">
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
					<div id="chat-msg-area">
					<c:forEach items="${msgList }" var="msgList" varStatus="i">
						<ul id="balloonList" class="group_msg_balloon">
							<!-- 날짜 한번만 출력(중복출력불가) -->
							<c:set var="preDate" value=""/>
							<c:set var="currentDate" value="${msgList.chatMsgTime.time }"/>
							<fmt:formatDate  var="formattedDate" value="${msgList.chatMsgTime}" pattern="yyyy.MM.dd(E)"/>
							<c:if test="${formattedDate ne prevDate}">
								<li class="date_check"><span>${formattedDate}</span></li>
								<c:set var="prevDate" value="${formattedDate}" />
							</c:if>
							
							<!-- 다른사람 채팅은 왼쪽에 -->
							<c:if test="${sessionScope.memberNo != msgList.memberNo }">
								<li class="msg-balloon-area">
									<div class="profile-area">
									<c:forEach items="${memberList }" var="mb" varStatus="i"></c:forEach>
										<c:if test="${mb.profileFilePath eq null }">
											<img class="chat-profile-thumbnail" src="../../resources/img/member/profile.png" width="40" />
										</c:if>
										<c:if test="${mb.profileFilePath ne null }">
											<img class="chat-profile-thumbnail" src="${mb.profileFilePath }"  alt="${mb.profileFilePath}" width="40" />
										</c:if>
										<div class="chat-mem-nickname">${msgList.nickname }</div>
									</div>
									<div class="msg-balloon-area-l">
										<div class="msg-contents">
											<!-- 파일 첨부 시 -->
											<c:if test="${not empty msgList.chatFilePath}"><!-- 이미지는 미리보기 파일은 이름만 -->
												<c:choose>
													<c:when test="${msgList.chatFilePath.endsWith('.jpg') || msgList.chatFilePath.endsWith('.jpeg') || msgList.chatFilePath.endsWith('.png') || msgList.chatFilePath.endsWith('.gif') || msgList.chatFilePath.endsWith('.bmp') || msgList.chatFilePath.endsWith('.webp') || msgList.chatFilePath.endsWith('.svg')|| msgList.chatFilePath.endsWith('.jfif')}">
														<img src="${msgList.chatFilePath }" class="chat-file-img"/>
													</c:when>
													<c:otherwise>
														<a href="${msgList.chatFilePath }" download="${msgList.chatFileName }">${msgList.chatFileName }</a>
													</c:otherwise>
												</c:choose>
											</c:if>
											<p class="msg-balloon-box-l">${msgList.chatMsgContent }</p>
										</div>
										<div class="msg-info">
											<c:if test="${msgList.nonReadMember > 0}">						
												<span class="msg-non-read">안읽음${msgList.nonReadMember }</span>
											</c:if>
											<span class="msg-time">
												<fmt:formatDate value="${msgList.chatMsgTime}" pattern="a h:mm" />
											</span>
										</div>
									</div>
								</li>	
							</c:if>
							<!-- 내 채팅은 오른쪽에 -->
							<c:if test="${sessionScope.memberNo eq msgList.memberNo }">
							<li class="msg-balloon-area-my">
								<div class="msg-balloon-area-r">
									<div class="msg-info-r">
										<c:if test="${msgList.nonReadMember > 0}">						
											<span class="msg-non-read">안읽음${msgList.nonReadMember }</span>
										</c:if>
										<span class="msg-time">
											<fmt:formatDate value="${msgList.chatMsgTime}" pattern="a h:mm" />
										</span>
									</div>
									<div class="msg-contents">
										<!-- 파일 첨부 시 -->
										<c:if test="${not empty msgList.chatFilePath}"><!-- 이미지는 미리보기 파일은 이름만 -->
											<c:choose>
												<c:when test="${msgList.chatFilePath.endsWith('.jpg') || msgList.chatFilePath.endsWith('.jpeg') || msgList.chatFilePath.endsWith('.png') || msgList.chatFilePath.endsWith('.gif') || msgList.chatFilePath.endsWith('.bmp') || msgList.chatFilePath.endsWith('.webp') || msgList.chatFilePath.endsWith('.svg')|| msgList.chatFilePath.endsWith('.jfif')}">
													<img src="${msgList.chatFilePath }" class="chat-file-img"/>
												</c:when>
												<c:otherwise>
													<a href="${msgList.chatFilePath }" download="${msgList.chatFileName }">${msgList.chatFileName }</a>
												</c:otherwise>
											</c:choose>
										</c:if>									
										<p class="msg-balloon-box-r">${msgList.chatMsgContent }</p>
									</div>
								</div>
							</li>
							</c:if>
						</ul>
					</c:forEach>	
					</div>
				</section>
				<footer class="chat-write">
					<input type="hidden" name="chatroomNo" value="${chatroomNo}" />
					<div id="filePreviewArea" style="display: none;"> <!-- 파일 미리보기 영역 -->
				       	<img id="imagePreview" src="" alt="Image Preview" style="max-width: 200px; margin-top: 10px;">
				        <span id="fileName"></span>		
				        <button type="button" id="cancelBtn" onclick="resetfile()">취소</button>				
					</div>
					<div class="wrtiteArea">
						<label id="fileUploadBtn" class="upload-btn" for="fileUploaderInput">🔗</label>
						<input id="fileUploaderInput" name="uplodeFile" type="file" style="display:none;">
						<div class="chat-input-area">
							<textarea id="msgContent" name="msgContent" class="chat-input" maxlength="2000" placeholder="메시지를 입력하세요"></textarea>
						</div>
						<button id="addChat" class="chat-btn-submit" type="submit">➤</button>
					</div>
				</footer>
			</section>
		</section>
	</main>
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>

	<script>
		/* 신고 */
		let prevChatMsgSize = 0;
		const chatroomNo = "${chatroomNo}"
		const memberNo = "${sessionScope.member.memberNo}";
		const report = (num) => {
			location.href = '/report/insert?target=chat&num='+num;
		}
		
		/* 채팅방 실시간 새로고침 */
		function formatTime(dateString) { // 시간표기
		    const date = new Date(dateString);
		    let hours = date.getHours();
		    const minutes = date.getMinutes().toString().padStart(2, '0');
		    const ampm = hours >= 12 ? '오후' : '오전';
		    hours = hours % 12 || 12;
		    return ampm+' '+hours+':'+minutes;
		}
		
		const loadChat = () => {
			$.ajax({
				url : "/chat/load",
				data : {
					"chatroomNo" : chatroomNo,
				},
				type : "GET",
				success : function(data) {
					let chatMsgSize = data.length;
					let html = "";
					let prevDate = "";
					
					if(chatMsgSize != prevChatMsgSize){
						data.forEach(function(msg) {
							const date = new Date(msg.chatMsgTime); // msg.chatMsgTime이 ISO String이면 바로 new Date() 가능
							const formattedDate = date.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', weekday: 'short'});
						    html += '<ul id="balloonList" class="group_msg_balloon">';
						    console.log(formattedDate)
						    // 날짜 출력 예시
						    if (formattedDate !== prevDate) {
						        html += '<li class="date_check"><span>' + formattedDate + '</span></li>';
						        prevDate = formattedDate;
						    }
						    
						    if (memberNo != msg.memberNo) {
						        // 다른 사람 채팅 (왼쪽)
						        html += '<li class="msg-balloon-area">';
						        html += '<div class="profile-area">';
						        if(msg.profileFilePath != null){
							        html += '<img class="chat-profile-thumbnail" src="' + msg.profileFilePath + '" width="40" />';
						        }else {
							        html += '<img class="chat-profile-thumbnail" src="../../resources/img/member/profile.png" width="40" />';
						        }
						        html += '<div class="chat-mem-nickname">' + msg.nickname + '</div>';
						        html += '</div>';
						        html += '<div class="msg-balloon-area-l"><div class="msg-contents">';
	
						        if (msg.chatFilePath != null) {
						            if (/\.(jpg|jpeg|png|gif|bmp|webp|svg|jfif)$/i.test(msg.chatFilePath)) {
						                html += '<img src="' + msg.chatFilePath + '" class="chat-file-img"/>';
						            } else {
						                html += '<a href="' + msg.chatFilePath + '" download="' + msg.chatFileName + '">' + msg.chatFileName + '</a>';
						            }
						        }
// 						        if (msg.chatFilePath != null) {
// 					                html += '<img src="' + msg.chatFilePath + '" class="chat-file-img"/>';
// 						        }
						        html += '<p class="msg-balloon-box-l">' + msg.chatMsgContent + '</p></div>';
						        
						        html += '<div class="msg-info">';
						        if (msg.nonReadMember > 0) {
						            html += '<span class="msg-non-read">안읽음' + msg.nonReadMember + '</span>';
						        }
						        html += '<span class="msg-time">' + formatTime(msg.chatMsgTime) + '</span>';
						        html += '</div></div></li>';
						        
						    } else {
						        // 내 채팅 (오른쪽)
						        html += '<li class="msg-balloon-area-my">';
						        html += '<div class="msg-balloon-area-r">';
						        html += '<div class="msg-info-r">';
						        
						        if (msg.nonReadMember > 0) {
						            html += '<span class="msg-non-read">안읽음' + msg.nonReadMember + '</span>';
						        }
						        
						        html += '<span class="msg-time">' + formatTime(msg.chatMsgTime) + '</span>';
						        html += '</div><div class="msg-contents">';
						        html += '<p class="msg-balloon-box-r">' + msg.chatMsgContent + '</p>';
	
						        if (msg.chatFilePath != null) {
						            if (/\.(jpg|jpeg|png|gif|bmp|webp|svg|jfif)$/i.test(msg.chatFilePath)) {
						                html += '<img src="' + msg.chatFilePath + '" class="chat-file-img"/>';
						            } else {
						                html += '<a href="' + msg.chatFilePath + '" download="' + msg.chatFileName + '">' + msg.chatFileName + '</a>';
						            }
						        }
// 						        if (msg.chatFilePath != null) {
// 						        	html += '<img src="' + msg.chatFilePath + '" class="chat-file-img"/>';
// 						        }
	
						        html += '</div></div></li>';
						    }
						    html += '</ul>';
						});
	
						document.querySelector("#chat-msg-area").innerHTML = html;
						if(document.querySelector("#msgSearch").value.trim() != ''){
							console.log("뭐야")
							// 채팅리스트 다시 출력후 검색어 있으면 하이라이트
							var keyword = $('#msgSearch').val().trim();
							
							matchedElements = [];
							
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
						    }
						}else{
							let chatArea = document.querySelector(".chat-area");
							setTimeout(() => {
							    chatArea.scrollTop = chatArea.scrollHeight;
							}, 0);
						}
						prevChatMsgSize = chatMsgSize;
					}

					
				},
				error  : function() {
					console.log("통신오류!");
				}
			}); 
		}

		setInterval(loadChat, 1000);
		
		/* 메시지 입력 */
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
				body: formData
			})
			.then(response => response.json())
			.then(result => {
				if(result >0){
					// 성공 시 메시지 목록 다시 불러오기 또는 화면에 추가
					loadChat();
					document.querySelector('#msgContent').value = '';
					document.querySelector("#filePreviewArea").style.display = "none";
				} else{
					alert("메시지 전송에 실패했습니다.");
				}
			});
		});
		
		/* 파일첨부 시 미리보기 */
	    const fileInput = document.getElementById("fileUploaderInput");
	    const filePreviewArea = document.getElementById("filePreviewArea");
	    const imagePreview = document.getElementById("imagePreview");
	    const fileName = document.getElementById("fileName");
	    const cancelBtn = document.getElementById("cancelBtn");
	
	    fileInput.addEventListener("change", function (event) {
	        const file = event.target.files[0];
	
	        // 이미지 파일인 경우 미리보기
	        if (file) {
	            const reader = new FileReader();
	            reader.onload = function (e) {
	                const fileType = file.type.split("/")[0]; // "image"와 같은 형태로 분리
	
	                if (fileType === "image") {
	                    // 이미지 미리보기
	                    imagePreview.src = e.target.result;
	                    imagePreview.style.display = "block";
	                    fileName.textContent = "";
	                } else {
	                    // 이미지가 아닌 경우
	                    imagePreview.style.display = "none";
	                    fileName.textContent = file.name; // 파일 이름 표시
	                }
	                // 파일 미리보기 영역 표시
	                filePreviewArea.style.display = "block";
                    cancelBtn.style.display = "inline"; // 취소버튼 표시
	            };
	
	            reader.readAsDataURL(file); // 파일을 데이터 URL로 읽어들임
	        }
	    });
	 	// 파일첨부 취소하기
		function resetfile() {
			const filePreviewArea = document.getElementById("filePreviewArea");
			const fileInput = document.getElementById("fileUploaderInput");
			const fileUploadBtn = document.getElementById("fileUploadBtn");
			const fileName = document.getElementById("fileName");
			const imagePreview = document.getElementById("imagePreview");
			const cancelBtn = document.getElementById("cancelBtn");
			
			fileInput.value = ""; // 입력값 초기화
			fileUploadBtn.innerHTML = "🔗"; //기존 텍스트 노출
			cancelBtn.style.display = "none"; // 취소버튼 숨기기
			filePreviewArea.style.display = "none"; // 미리보기 전체 숨기기
			imagePreview.scr = ""; //이미지 초기화
			fileName.textContent = ""; // 파일명 초기화
		}
		
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
		
		function searchKeword () {
			var keyword = $('#msgSearch').val().trim();
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
		}
		
		// 검색어 입력 시 하이라이트
		$('#msgSearch').on('input', function() {
			searchKeword();
		});
// 		$('#msgSearch').on('input', function () {
// 		    var keyword = $(this).val().trim();
// 		    matchedElements = [];
// 		    highlightIndex = 0;
		
// 		    // 기존 하이라이트 제거
// 		    $('.msg-balloon-box-l, .msg-balloon-box-r').each(function () {
// 		        $(this).html($(this).text());
// 		    });
		
// 		    if (keyword !== "") {
// 		        var regex = new RegExp("(" + keyword + ")", "gi");
		
// 		        $('.msg-balloon-box-l, .msg-balloon-box-r').each(function () {
// 		            var originalText = $(this).text();
// 		            if (regex.test(originalText)) {
// 		                var highlighted = originalText.replace(regex, "<span class='txt-hlight'>$1</span>");
// 		                $(this).html(highlighted);
// 		                matchedElements.push(this);
// 		            }
// 		        });
// 		        // 역순으로 이동 시작
// 		        highlightIndex = matchedElements.length - 1; 
// 		    }
// 		});
		
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