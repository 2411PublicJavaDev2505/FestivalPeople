<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>festival Detail</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/header.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/festival/festivalDetail.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/footer.css">
	</head>
	<body>
		<div id="container">
			<div class="background-image">
	    	 	<img src="${pageContext.request.contextPath}/resources/img/festival/우도.jpg" alt="바탕화면">
	    	 </div>
			<jsp:include page="../include/header.jsp"/>
			<input type="hidden" value="${festival}">
			
			<c:if test="${not empty festival.festivalFilePath}">
			<main class="festival-list">
				<div class="festival-detail">
					<section class="festival-name">
						<h2 id="festival-head"> ${festival.festivalName}</h2>
						<h4 id="festival-date">🗓️ 축제일정: ${festival.festivalStartDate} ~ ${festival.festivalEndDate}</h4>
					</section>
					<section class="festival-detail-card">
		                <img src="${festival.festivalFilePath}" alt="축제 이미지" />
		            </section>
					<section class="festival-detail-items">
						<ul>
							<li> 🗓️ 축제 일정: ${festival.festivalStartDate} ~ ${festival.festivalEndDate}</li>
							<li> 📍 개최 장소: ${festival.festivalAddress} ${festival.festivalDetailAddress}</li>
							<li> 📞 대표 전화:  ${festival.festivalPhone}</li>
							<li> 🔅 축제기간 일기예보
								<div class="weather-api">
									<img src="${pageContext.request.contextPath}/resources/img/festival/weather_example.jpg" alt="날씨">
								</div>
							</li>
							<li> 🚩 지도
								<div class="map-wrapper" >
								  <!-- Kakao Map Container -->
								  <div class="map-api" style="width:100%;height:350px;">
								
								  <!-- 길찾기 버튼 -->
								  <a class="map_shortcut" 
								     href="https://map.kakao.com/link/to/${festival.festivalName},${festival.mapHcode},${festival.mapVCode}" 
								     target="_blank">
								     📍 길찾기
								  </a>
								  </div>
								</div>
							</li>		
						</ul>
					</section>
				</div>
			</main>
			</c:if>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce2765b5c8d1c862f02d7a486094793d"></script>
		<script>
			var kakaoMapContainer = document.querySelector('.map-api')
			var mapOptions = {
				center : new kakao.maps.LatLng(Number("${festival.mapHcode}"), Number("${festival.mapVCode}")),
					level: 2
			};
			
			var map = new kakao.maps.Map(kakaoMapContainer,mapOptions);
			
			var positions = [
				{
					title: "${festival.festivalName}",
					latlng: new kakao.maps.LatLng(Number("${festival.mapHcode}"), Number("${festival.mapVCode}"))
				}
			]
			//마커이미지
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
			    
			    // 인포윈도우 생성 팝업으로 해당 축제 설명 
			    var infowindow = new kakao.maps.InfoWindow({
			        content: '<div style="padding:5px;font-size:14px;">' + positions[i].title + '</div>'
			    });

			    // 마우스 버튼 선택시에만 팝업 창 나옴
			    kakao.maps.event.addListener(marker, 'mouseover', function(marker, infowindow) {
			        return function() {
			            infowindow.open(map, marker);
			        };
			    }(marker, infowindow));  // 클로저로 묶어서 i값 유지

			    kakao.maps.event.addListener(marker, 'mouseout', function(marker, infowindow) {
			        return function() {
			            infowindow.close();
			        };
			    }(marker, infowindow));
			    
			    
			}
		</script>
	</body>
</html>