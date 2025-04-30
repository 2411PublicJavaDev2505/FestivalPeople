<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    LocalDate today = LocalDate.now();
    LocalDate tomorrow = today.plusDays(1);
    LocalDate dayAfterTomorrow = today.plusDays(2);

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM월 dd일 (E)");
    String todayStr = today.format(formatter);
    String tomorrowStr = tomorrow.format(formatter);
    String dayAfterTomorrowStr = dayAfterTomorrow.format(formatter);
%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
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
						<h2 id="festival-head"> 🎪${festival.festivalName}</h2>
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
							<li> 🔅 축제지역 일기예보
								<div class="weather-api">
									<table border="1" cellpadding="10" style="border-collapse: collapse; text-align: center;">
										<tr>
										    <th>날짜</th>
										    <th><%= todayStr %></th>
										    <th><%= tomorrowStr %></th>
										    <th><%= dayAfterTomorrowStr %></th>
										</tr>
										<tr>
										    <th>🌡 기온</th>
										    <c:forEach var="key" items="${days}">
										        <td>${weatherSummary[key]["기온"]}</td>
										    </c:forEach>
										</tr>
										<tr>
										    <th>☔ 강수</th>
										    <c:forEach var="key" items="${days}">
										        <td>${weatherSummary[key]["강수량"]}</td>
										    </c:forEach>
										</tr>
										<tr>
										    <th>⛅ 구름</th>
										    <c:forEach var="key" items="${days}">
										        <td>${weatherSummary[key]["하늘상태"]}</td>
										    </c:forEach>
										</tr>

									</table>
								</div>
							</li>
							<li> 🚩 지도
								<div class="map-wrapper" >
								  <!-- Kakao Map Container -->
								  <div class="map-api" style="width:100%;height:350px;">								
								  <!-- 길찾기 버튼 -->
									  <a class="map_shortcut" 
									     href="https://map.kakao.com/link/to/${festival.festivalName},${festival.mapHCode},${festival.mapVCode}" 
									     target="_blank">
									     📍 길찾기
									  </a>
									  <a class= "course_recommend" 
									  	href="/course/detail?festivalNo=${festival.festivalNo}">
										추천코스
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
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJavaScriptKey }"></script>
		<script>
			var kakaoMapContainer = document.querySelector('.map-api')
			var mapOptions = {
				center : new kakao.maps.LatLng(Number("${festival.mapHCode}"), Number("${festival.mapVCode}")),
					level: 2
			};
			
			var map = new kakao.maps.Map(kakaoMapContainer,mapOptions);
			
			var positions = [
				{
					title: "${festival.festivalName}",
					latlng: new kakao.maps.LatLng(Number("${festival.mapHCode}"), Number("${festival.mapVCode}"))
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
			        map: map,
			        position: positions[i].latlng,
			        title: positions[i].title,
			        image: markerImage
			    });

			    var infowindow = new kakao.maps.InfoWindow({
			        content: '<div style="padding:5px;font-size:14px;">' + positions[i].title + '</div>',
			        removable: false
			    });

			    // 지도 로드 시 항상 보이도록
			    infowindow.open(map, marker);
			    
			    
			}
						
		</script>
	</body>
</html>