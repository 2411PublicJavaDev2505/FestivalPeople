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
					<form id="sortForm" action="controllerURL" method="get">
						<div class="radio-btn">
							<label class="radio-style">
								<input type="radio" id="distance" name="sort" checked>거리순
							</label>
							<label class="radio-style">
								<input type="radio" id="rate"	  name="sort"> 평점순
							</label>
						</div>
					</form>
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

							<img src= "${festival.festivalFilePath}" alt="부산">
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천맛집</div>
							<div class="matzip-name">${matZip.place_name }</div>
						</div>
						<div class="course-recommend-section">
							<iframe src="${matZip.place_url }" width="100%" height="600px"></iframe><br>
							<div class="iframe-description">
							<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
							<a href="${matZip.place_url}" target="_blank">${matZip.place_url}</a>
							</div>
						</div>
						<div class="matzip-container">
							<div class="matzip-title">추천숙소</div>
							<div class="matzip-name">${hotel.place_name }</div>
						</div>
						<div class="course-recommend-section">
							<iframe src="${hotel.place_url }" width="100%" height="600px"></iframe><br>
							<div class="iframe-description">
							<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
							<a href="${hotel.place_url}" target="_blank">${hotel.place_url}</a>
							</div>
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
	console.log("festivalX: ", "${coursePoint.festivalX}");
	console.log("festivalY: ", "${coursePoint.festivalY}");


	var kakaoMapContainer = document.querySelector('.course-recommend-map')
	var mapOptions = {
			center : new kakao.maps.LatLng(Number("${coursePoint.festivalY}"), Number("${coursePoint.festivalX}")),
			level: 3	 


	

	};
	
	var map = new kakao.maps.Map(kakaoMapContainer, mapOptions);
	
	var positions = [
		{
			title: "${festival.festivalName}",
			latlng: new kakao.maps.LatLng(Number("${coursePoint.festivalY}"), Number("${coursePoint.festivalX}"))
		},
		
		{
			title: "${matZip.place_name}",
			latlng: new kakao.maps.LatLng(Number("${coursePoint.matzipY}"), Number("${coursePoint.matzipX}"))
		},
		
		{
			title: "${hotel.place_name}",
			latlng: new kakao.maps.LatLng(Number("${coursePoint.hotelY}"), Number("${coursePoint.hotelX}"))
		}
	]
	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    // 마커 이미지 크기
	    var imageSize = new kakao.maps.Size(24, 35);     
	    // 마커 이미지를 생성  
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    // 마커를 생성
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	}
	
	
	
	
</script>


</body>
</html>