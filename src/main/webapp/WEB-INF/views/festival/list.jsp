<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/festival/list.css">
		<title>Festival Main Page</title>
	</head>
	<body>
		
	    <div class="container">
	    <div class="background-image">
    	 	<img src="../resources/img/festival/우도.jpg" alt="바탕화면">
    	 </div>
		<jsp:include page="../include/header.jsp"/>
	       <main class="festival-list">
	           <div class="buttons">
	               <div class="festival-button">
	                   <button>추천 축제</button>
	                   <button>다가오는 축제</button>
	               </div>
	               <div class="festival-search">
	                   <form class="search-form">
	                       <select>
	                           <option value="all">전체</option>
	                           <option value="name">축제명</option>
	                           <option value="location">지역</option>
	                           <option value="date">날짜</option>
	                       </select>
	                       <input type="text" placeholder="검색" id=" ">
	                       <button class="search-btn" onclick="/festival/festivalSearch.jsp">⌕</button>
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
	               
					<div class="moveSlider-track" id="moveSliderTrack">
						<c:forEach var="festival" items="${festivals}" varStatus="status">
						   <c:if test="${status.index % 4 == 0}">
						     <div class="slide-group">
						   </c:if>
						
						   <c:if test="${not empty festival.festivalFilePath}">
						     <div class="festival-card">
						       <a href="/festival/detail/${festival.festivalNo}">
						         <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
						       </a>
						     </div>
						   </c:if>
						
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
	
	           <div class="festival-list">
	               <div class="festival-list-track">
					    <c:forEach var="festival" items="${festivals}">
					        <c:if test="${not empty festival.festivalFilePath}">
					            <div class="festival-card">
					                <a href="/festival/detail/${festival.festivalNo}">
					                    <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
					                </a>
					            </div>
					        </c:if>
					    </c:forEach>
					</div>
               </div>
	               
			   <div class="pagination">
					<a href="/recipe/list?page=1"> ◁◁ </a>
					<c:if test= "${startNavi ne 1 }">
						<a href="/festival/list?currentPage=${startNavi-1 }" class="prev">◀</a>
					</c:if>	
					<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
						<a href="/festival/list?currentPage=${p }">${p }</a>
					</c:forEach>					
					<c:if test="${endNavi ne maxPage }">
						<a href="/festival/list?currentPage=${endNavi+1 }" class="next">▶</a>
					</c:if>    
		           	<a href="/festival/list?page=${maxPage }"> ▷▷ </a>
	            </div>
	       </main>
	   </div>

    <script>
	   document.addEventListener('DOMContentLoaded', function () {
	       let currentSlide = 0;
	       const track = document.getElementById("moveSliderTrack");
	       const totalGroups = track.querySelectorAll(".slide-group").length;
	       let autoSlideInterval;
	       let restartTimeout;
	
	       function startAutoSlide() {
	           autoSlideInterval = setInterval(() => {
	               moveSlide(1);
	           }, 5000);
	       }
	
	       function moveSlide(direction) {
	           clearInterval(autoSlideInterval);
	           clearTimeout(restartTimeout);
	
	           currentSlide += direction;
	           if (currentSlide >= totalGroups) currentSlide = 0;
	           if (currentSlide < 0) currentSlide = totalGroups - 1;
	
	           const groupWidth = track.offsetWidth;
	           track.style.transform = 'translateX(-' + currentSlide * groupWidth + 'px)';
	
	           restartTimeout = setTimeout(() => {
	               startAutoSlide();
	           }, 10000); // 10초 뒤 자동 재시작
	       }
	
	       window.moveSlide = moveSlide;
	
	       startAutoSlide(); // 페이지 로드시 자동 시작
	   });
        
    </script>
	</body>
</html>