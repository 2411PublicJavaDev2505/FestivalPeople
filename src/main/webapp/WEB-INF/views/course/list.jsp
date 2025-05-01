<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/course/coursePage.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/footer.css">
	<title>Insert title here</title>
</head>
<body>
	<div class="background-image">
    	 <img src="" alt="바탕화면">
    	 </div>

		<div id="container">
			<jsp:include page="../include/header.jsp"/>
			<main>		
			    <div class="course-slider-container">
	                <div class="course-search">
		                <form class="search-form" action="/course/search" method="get">
		                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					    	<div class="message-box">${memberName}${message }</div>
		                    <select name="searchCondition">
		                        <option value="all">전체</option>
		                        <option value="name">축제명</option>
		                        <option value="location">지역</option>
		                    </select>
		                    <input type="text" placeholder="검색" name="searchKeyword" value="${param.searchKeyword }">
		                    <button class="search-btn" type="submit">⌕</button>
		                </form>
		            </div>
			        <div class="course-slider-wrapper">
				        <button class="slide-btn left" onclick="slideLeft()">&#10094;</button>
					        <div class="card-slider" id="cardSlider">
								<c:forEach items="${fList }" var="festival" varStatus="i">
										<div class="course-back-image">
										    <a id="content" href="/course/detail?festivalNo=${festival.festivalNo }">
										    <img class="poster-img" src="${festival.festivalFilePath}" alt="포스터이미지">
										        <div class="coursecard">
													<img src="${festival.festivalFilePath }" alt="축제이미지" />
										            <h3>${festival.festivalName }</h3><br>
										            <p>${festival.festivalAddress }</p><br>										            
										            <p>${festival.festivalStartDate} ~ ${festival.festivalEndDate }</p><br>
										            <p class="hashtags">${festival.festivalDetailAddress }</p>
										            <br><br><br><br><br><br>
										        </div>
										    </a>
										</div>
					            </c:forEach>
					        </div>		    
				        <button class="slide-btn right" onclick="slideRight()">&#10095;</button>
			        </div>
			    </div>
			</main>	
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	    </div>
	
	<script>
	  const images = [
  		    "../resources/img/course/bgi1.jpg",
 		    "../resources/img/course/bgi2.jpg",
		    "../resources/img/course/bgi3.jpg",
		    "../resources/img/course/bgi4.jpg",
		    "../resources/img/course/bgi5.jpg"  
		  ];

		  let index = 0;
		  const imgTag = document.querySelector(".background-image img");

		  // 초기 이미지 설정
		  window.onload = function () {
		    imgTag.src = images[0];

		    // 5초마다 이미지 변경
		    setInterval(() => {
		      index = (index + 1) % images.length;
		      imgTag.src = images[index];
		    }, 5000);
		  };	
		  
		  
		  const slider = document.querySelector(".card-slider");
		  const cardWidth = 250 + 20;
		  const visibleCards = 4;
		  const scrollAmount = cardWidth * visibleCards;

		  function slideLeft() {
		    if (slider.scrollLeft === 0) {
		      slider.scrollLeft = slider.scrollWidth; // 마지막으로 이동
		    } else {
		      slider.scrollLeft -= scrollAmount;
		    }
		  }

		  function slideRight() {
		    if (slider.scrollLeft + slider.clientWidth >= slider.scrollWidth - 5) {
		      slider.scrollLeft = 0; // 처음으로 이동
		    } else {
		      slider.scrollLeft += scrollAmount;
		    }
		  }
		  
		  
	</script>
	
	
</body>
</html>