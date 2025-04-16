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
	</head>
	<body>
		<div id="container">
			<jsp:include page="../include/header.jsp"/>
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
							<li> 🚩 길찾기
								<div class="map-api">
									<img src="${pageContext.request.contextPath}/resources/img/festival/examMap.png" alt="길찾기">
								</div>
							</li>		
						</ul>
					</section>
				</div>
			</main>
			</c:if>
		</div>
		<script>
		</script>
	</body>
</html>