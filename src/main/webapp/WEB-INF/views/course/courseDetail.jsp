<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/course/courseDetailPage.css">

	
	<title>코스 추천</title>
	
</head>
<body>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="course-total-container">
			
				<div class="course-recommend">
					<div class="course-recommend-left">
					<p class="courseText">코스추천</p>
					<input type="radio" id="distance" name="category">거리순
					<input type="radio" id="cost"	  name="category">가격순
					<input type="radio" id="rate"	  name="category">평점순
						<div class="course-recommend-detail">
							<div class="course-recommend-map">
								<img src="../resources/img/course/examMap.png" alt="지도">
							</div>
							<div class="festival-title">
								<p>부산연등회</p>
							</div>
							<div class="course-recommend-festival">
								<img src="../resources/img/course/busanFestival.jpg" alt="부산">
							</div>
							<div class="matzip-container">
								<div class="matzip-title">추천맛집</div>
								<div class="matzip-name">또또식당</div>
								<img src="../resources/img/course/matzipPicture.jpg" alt="또또식당">
							</div>
						</div>
					</div>	
					
					<div class="course-"></div>
					
				</div>
				
			</div>
	
			
		</main>
	
	</div>

</body>
</html>