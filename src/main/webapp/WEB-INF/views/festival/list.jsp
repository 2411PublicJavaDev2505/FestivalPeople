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
						<c:forEach var="festival" items="${festivals}">
								<c:if test="${not empty festival.festivalFilePath}">
							<div class="festival-card">
									<a href="/festival/detail/${festival.festivalNo}">
					                	<img src="${festival.festivalFilePath}" alt="축제 이미지" width="300" />
									</a>
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
	               
			   <div class="pagination">
					<a href="/recipe/list?page=1"> ◁◁ </a>
					<c:if test= "${startNavi ne 1 }">
						<a href="/festivallist?page=${startNavi-1 }" class="prev">◀</a>
					</c:if>	
					<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
						<a href="/festival/list?page=${p }">${p }</a>
					</c:forEach>					
					<c:if test="${endNavi ne maxPage }">
						<a href="/festival/list?page=${endNavi+1 }" class="next">▶</a>
					</c:if>    
		           	<a href="/festivallist?page=${maxPage }"> ▷▷ </a>
	            </div>
	       </main>
	   </div>

    <script>
    	document.addEventListener('DOMContentLoaded', function (){
	        let currentSlide = 0;
	        const cardWidth = 270;
	
	        window.moveSlide = function (direction) {
	            const track = document.getElementById("moveSliderTrack");
	            const maxSlide = track.children.length - 3;

	            currentSlide += direction;
	            if (currentSlide < 0) currentSlide = 0;
	            if (currentSlide > maxSlide) currentSlide = maxSlide;
	
	            track.style.transform = 'translateX(-'+currentSlide * cardWidth+'px)';
	        }	
    	});
        
    </script>
	</body>
</html>