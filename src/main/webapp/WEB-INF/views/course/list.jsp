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
			                <div class="coursecard">
			                    <a href="/course/detail"><img src="../resources/img/course/examPic1.png" alt="이미지" /></a>
			                    <h3>벚꽃축제</h3>
			                    <p>한강</p>
			                    <p class="hashtags">꽃구경</p>
			                </div>
			                <div class="coursecard">
			                    <a href="/course/detail"><img src="../resources/img/course/examPic2.jpg" alt="이미지" /></a>
			                    <h3>벚꽃축제</h3>
			                    <p>한강</p>
			                    <p class="hashtags">꽃구경</p>
			                </div>
			                <div class="coursecard">
			                    <a href="/course/detail"><img src="../resources/img/course/examPic3.jpg" alt="이미지" /></a>
			                    <h3>벚꽃축제</h3>
			                    <p>한강</p>
			                    <p class="hashtags">꽃구경</p>
			                </div>
			                <div class="coursecard">
			                    <a href="/course/detail"><img src="../resources/img/course/examPic4.jpg" alt="이미지" /></a>
			                    <h3>벚꽃축제</h3>
			                    <p>한강</p>
			                    <p class="hashtags">꽃구경</p>
			                </div>
			        </div>
		    
		        <button class="slide-btn right" onclick="slideRight()">&#10095;</button>
		    </div>
		</main>	
	</div>
</body>
</html>