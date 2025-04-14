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
				<div class="course-recommend-choice">
					<div>
						<p class="courseText">코스추천</p>
					</div>
					<div class="radio-btn">
						<label class="radio-style">
							<input type="radio" id="distance" name="category">
							<span>거리순</span>
						</label>
						<label class="radio-style">
							<input type="radio" id="cost"	  name="category">
							<span>가격순</span>
						</label>
						<label class="radio-style">
							<input type="radio" id="rate"	  name="category">
							<span>평점순</span>
						</label>
					</div>
				</div>
				<div class="course-recommend-main">
					<div class="course-recommend-left">
						<div  class="course-recommend-img">
							<img src="../resources/img/course/examMap.png" alt="지도">
						</div>
						<div class="festival-title">
							<p>부산연등회</p>
						</div>
						<div class="course-recommend-img">
							<img src="../resources/img/course/busanFestival.jpg" alt="부산">
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천맛집</div>
							<div class="matzip-name">또또식당</div>
						</div>
						<div class="course-recommend-img">
							<img src="../resources/img/course/matzipPicture.jpg" alt="또또식당">
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천숙소</div>
							<div class="matzip-name">이비스 앰배서더 부산 시티 센터</div>
						</div>
						<div class="course-recommend-img">
							<img src="../resources/img/course/hotel.jpg" alt="또또식당">
						</div>
						<form class="insert-course" action="/" method="post">
							<div class="expect-cost">예상 금액 : ??</div>								
							<div class="expect-time">예상 소요 시간 : ??</div>								
							<input type="button" value="코스 저장하기">							
						</form>													
					</div>	
					<div class="course-recommend-right">
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
				            <div class="search-course-list">
				            	<input class ="search-course-title" type="text" name="courseTitle" id="courseNO" placeholder="부산 연등회" readonly>
				            	<input class ="search-course-title" type="text" name="courseTitle" id="courseNO" placeholder="부산 연등회" readonly>
				            	<input class ="search-course-title" type="text" name="courseTitle" id="courseNO" placeholder="부산 연등회" readonly>
				            	<input class ="search-course-title" type="text" name="courseTitle" id="courseNO" placeholder="부산 연등회" readonly>
				            	<input class ="search-course-title" type="text" name="courseTitle" id="courseNO" placeholder="부산 연등회" readonly>
				            </div>
			            </div>
<!-- 			            forEach 예정 -->
					</div>			
				</div>
			</div>	
		</main>	
	</div>

</body>
</html>