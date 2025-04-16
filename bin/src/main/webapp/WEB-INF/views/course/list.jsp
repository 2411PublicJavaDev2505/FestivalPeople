<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/course/coursePage.css">
	
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
		                <form class="search-form">
		                    <select>
		                        <option value="all">전체</option>
		                        <option value="name">축제명</option>
		                        <option value="location">지역</option>
		                        <option value="date">날짜</option>
		                    </select>
		                    <input type="text" placeholder="검색" id=" ">
		                    <button class="search-btn">⌕</button>
		                </form>
		            </div>
			        
			        <button class="slide-btn left" onclick="slideLeft()">&#10094;</button>
				        <div class="card-slider" id="cardSlider">
				        
				                <a href="/course/detail">
				                	<div class="coursecard">
				                    <img src="../resources/img/course/examPic1.png" alt="이미지" />
				                    <h3>벚꽃축제</h3>
				                    <p>한강</p>
				                    <p class="hashtags">꽃구경</p>
				                	</div>
				                </a>
				                
				                
				                <a href="/course/detail">
				                	<div class="coursecard">
				                    <img src="../resources/img/course/examPic2.jpg" alt="이미지" />
				                    <h3>벚꽃축제</h3>
				                    <p>한강</p>
				                    <p class="hashtags">꽃구경</p>
				               		</div>
				                </a>
				                
				                
				                <a href="/course/detail">
				                	<div class="coursecard">
				                    <img src="../resources/img/course/examPic3.jpg" alt="이미지" />
				                    <h3>벚꽃축제</h3>
				                    <p>한강</p>
				                    <p class="hashtags">꽃구경</p>
				                	</div>
				                </a>
				                
				                <a href="/course/detail">
				               		<div class="coursecard">
				                    <img src="../resources/img/course/examPic4.jpg" alt="이미지" />
				                    <h3>벚꽃축제</h3>
				                    <p>한강</p>
				                    <p class="hashtags">꽃구경</p>
				                	</div>
				                </a>
				        </div>
			    
			        <button class="slide-btn right" onclick="slideRight()">&#10095;</button>
			    </div>
			</main>	
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
	</script>
	
	
</body>
</html>