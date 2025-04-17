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
					<input type="hidden" value="${festival}">
					<input type="hidden" value="${matZip}">
					<input type="hidden" value="${hotel}">
					<input type="hidden" value="${coursePoint}">
					
					<div class="course-recommend-left">
						<div  class="course-recommend-map" style="width:100%; height:400px;">							
							<!-- <img src="../resources/img/course/examMap.png" alt="지도"> -->
						</div>
						<div class="festival-title">

							<p>${festival.festivalName}</p>
						</div>
						<div class="course-recommend-img">

							<img src="../resources/img/course/busanFestival.jpg" alt="부산">
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천맛집</div>
							<div class="matzip-name">${matZip.place_name }</div>
						</div>
						<div class="course-recommend-img">
							<img src="../resources/img/course/matzipPicture.jpg" alt="또또식당">
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천숙소</div>
							<div class="matzip-name">${hotel.place_name }</div>
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


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce2765b5c8d1c862f02d7a486094793d"></script>

<script>

/* 	const coursePoints = {
			
			festival: {
				x : "${coursePoint.festivalX}",
				y : "${coursePoint.festivalY}",
				name : "${coursePoint.festivalName}",
			},
			
			matzip: {
				x: "${coursePoint.matZipX}",
				y: "${coursePoint.matZipY}",
				name: "${coursePoint.place_name}",
			},
			
			hotel: {
				x: "${coursePoint.hotelX}",
				y: "${coursePoint.hotelY}",
				name: "${coursePoint.place_name}",
			}
	}; */

	
    console.log("${coursePoint.festivalX}");
    console.log("${coursePoint.festivalY}");

	var kakaoMapContainer = document.querySelector('.course-recommend-map')
	var mapOptions = {
			center : new kakao.maps.LatLng(Number("${coursePoint.festivalX}"), Number("${coursePoint.festivalY}"))
/* 			level: 3	 */
	};
	
	var map = new kakao.maps.Map(kakaoMapContainer, mapOptions);
	
	
	
	
	
</script>


</body>
</html>