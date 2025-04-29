<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Festival Main Page</title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/festival/festivalList.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">
	</head>
	<body>
		
	    <div id="container">
	    <div class="background-image">
    	 	<img src="../resources/img/festival/우도.jpg" alt="바탕화면">
    	 </div>
		<jsp:include page="../include/header.jsp"/>
	       <main class="festival-main">
	           <div class="buttons">
	               <div class="festival-button">
            			<c:if test="${member.memberId eq null }">
				            
			            </c:if>
			            <c:if test="${member.memberId ne null }">
				            <button class="active">🔅우리지역 축제</button>
			            </c:if>
			            
			            <c:if test="${member.memberId ne null }">
				            <button>진행중인 축제</button>
			            </c:if>
	                   
	               </div>
	               <div class="festival-search">
	                   <form class="search-form" method="get" action="/festival/search">
						    <select name="searchCondition">
						        <option value="all">전체</option>
						        <option value="name">축제명</option>
						        <option value="location">지역</option>
						    </select>
						    <input type="text" name="searchKeyword" value="${param.searchKeyword }" placeholder="검색어를 입력하세요">
						    <button type="submit" class="search-btn">⌕</button>
						</form>
	               </div>
	           </div>
	   
	           <!-- 슬라이드 -->
	           <div class="moveSlider">
	               <div class ="moveSlider-prev-button">
	                   <button class="slider-btn-prev" onclick="moveSlide(-1)">
	                       <img class="on" src="../resources/img/festival/pre_off_btn_2.png"alt="이전 버튼">
	                   </button>
	               </div>
	               
					<!-- 추천 축제용 트랙 -->
		    <div class="moveSlider-track" id="track-recommend">
		        <c:forEach var="festival" items="${fList}" varStatus="status">
		            <c:if test="${status.index % 4 == 0}">
		                <div class="slide-group">
		            </c:if>
		            <div class="festival-card-recommend">
		                <a href="/festival/detail/${festival.festivalNo}">
		                    <div class="festival-image-wrapper">
			                    <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
				                <div class="overlay-text">
				                	${festival.festivalName}
				                </div>
				            </div>
		                </a>
		            </div>
		            <c:if test="${status.index % 4 == 3 || status.last}">
		                </div>
		            </c:if>
		        </c:forEach>
		    </div>
		
		    <!-- 다가오는 축제용 트랙 -->
		    <div class="moveSlider-track" id="track-upcoming" style="display:none;">
		        <c:forEach var="festival" items="${festivals}" varStatus="status">
		            <c:if test="${status.index % 4 == 0}">
		                <div class="slide-group">
		            </c:if>
		            <div class="festival-card-recommend">
		                <a href="/festival/detail/${festival.festivalNo}">
		                    <div class="festival-image-wrapper">
			                    <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
				                <div class="overlay-text">
				                	${festival.festivalName}
				                </div>
				            </div>
		                </a>
		            </div>
		            <c:if test="${status.index % 4 == 3 || status.last}">
		                </div>
		            </c:if>
		        </c:forEach>
		    </div>
	               
	               <div class ="moveSlider-next-button">
	                   <button class="slider-btn-next" onclick="moveSlide(1)">
	                       <img class="on" src="../resources/img/festival/next_off_btn_2.png" alt="다음 버튼" >
	                   </button>
	               </div>
	           </div>
				<div class ="festival-list-button">
	                   <button id="showFestivalListBtn">전국 축제 리스트</button>
	               </div>
	           <div class="festival-list">
	               <div id="festivalListTrack" class="festival-list-track" >
					    <c:forEach var="festival" items="${festivals}">
					        <c:if test="${not empty festival.festivalFilePath}">
					            <div class="festival-card">
					                <a href="/festival/detail/${festival.festivalNo}">
					                    <div class="festival-image-wrapper">
						                    <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
							                <div class="overlay-text">
							                	${festival.festivalName}
							                </div>
							            </div>
					                </a>
					            </div>
					        </c:if>
					    </c:forEach>
					</div>
               </div>
			   <div class="pagination">
				    <a href="/festival/list?currentPage=1">◁◁</a>
				    
				    <c:if test="${startNavi gt 1}">
				        <a href="/festival/list?currentPage=${startNavi-1}" class="prev">◀</a>
				    </c:if>  
				    
				    <c:forEach begin="${startNavi}" end="${endNavi}" var="p">
				        <c:if test="${p <= maxPage}">
					        <c:choose>
						        <c:when test="${p eq currentPage}">
						            <a href="/festival/list?currentPage=${p}" style="font-weight:bold; color:black;">${p}</a>
						        </c:when>
						        <c:otherwise>
						            <a href="/festival/list?currentPage=${p}">${p}</a>
						        </c:otherwise>
						    </c:choose>
				        </c:if>
				        
				    </c:forEach>          
				    
				    <c:if test="${endNavi lt maxPage}">
				        <a href="/festival/list?currentPage=${endNavi+1}" class="next">▶</a>
				    </c:if>    
				    <a href="/festival/list?currentPage=${maxPage}">▷▷</a>
				</div>
	       </main>
	       <jsp:include page="/WEB-INF/views/include/footer.jsp" />
	   </div>
		
    <script>
	    let currentSlide = 0;
	    let activeTrackId = 'track-recommend';
	
	    const buttons = document.querySelectorAll('.festival-button button');
	    buttons.forEach((btn, idx) => {
	        btn.addEventListener('click', (event) => {
	            buttons.forEach(b => b.classList.remove('active'));
	            event.target.classList.add('active');

	            if (idx === 0) switchTrack('track-recommend');
	            else switchTrack('track-upcoming');
	        });
	    });
	    /* document.getElementById("showFestivalListBtn").addEventListener("click", function() {
	        var festivalListTrack = document.getElementById("festivalListTrack");
	        if (festivalListTrack.style.display === "none") {
	            festivalListTrack.style.display = "block"; // Show the festival list
	        } else {
	            festivalListTrack.style.display = "none"; // Hide the festival list
	        }
	    }); */
	    function switchTrack(trackId) {
	        document.getElementById(activeTrackId).style.display = 'none';
	        document.getElementById(trackId).style.display = 'flex';
	        activeTrackId = trackId;
	        currentSlide = 0;
	        updateSlide();
	    }
	
	    function moveSlide(direction) {
	        const track = document.getElementById(activeTrackId);
	        const totalGroups = track.querySelectorAll('.slide-group').length;
	
	        currentSlide += direction;
	        if (currentSlide >= totalGroups) currentSlide = 0;
	        if (currentSlide < 0) currentSlide = totalGroups - 1;
	
	        const groupWidth = track.offsetWidth;
	        track.style.transform = 'translateX(-' + currentSlide * groupWidth + 'px)';
	    }
	
	    function updateSlide() {
	        const track = document.getElementById(activeTrackId);
	        const groupWidth = track.offsetWidth;
	        track.style.transform = 'translateX(-' + currentSlide * groupWidth + 'px)';
	    }
        
    </script>
	</body>
</html>