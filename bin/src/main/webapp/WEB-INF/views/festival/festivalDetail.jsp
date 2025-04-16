<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>festival Detail</title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/festival/festivalDetail.css">
	</head>
	<body>
		<div id="container">
			<jsp:include page="../include/header.jsp"/>
			<main class="festival-list">
				<div class="festival-detail">
					<section class="festival-name">
						<h2 id="festival-head"> 2025 태안봄꽃정원 </h2>
						<h4 id="festival-date">2025.05.02 ~ 2025.05.05</h4>
					</section>
					<section class="festival-detail-card">
						<div class="festival-card">
							<img src="../resources/img/festival/festival_img_exapmle.jpg" alt="축제 포스터1">
						</div>
						<div class="festival-card">
							<img src="../resources/img/festival/festival_img_exapmle.jpg" alt="축제 포스터1">
						</div>
						<div class="festival-card">
							<img src="../resources/img/festival/festival_img_exapmle.jpg" alt="축제 포스터1">
						</div>
					</section>
					<section class="festival-detail-items">
						<ul>
							<li> 🗓️ 축제 일정: 2025.05.02 ~ 2025.05.05</li>
							<li> 📍 개최 장소: 서울시 중구  하동야생차치유관, 박물관 일원</li>
							<li> ❤  대표전화 :  055-880-6583</li>
							<li> ❤  축제기간 일기예보
								<div class="weather-api">
									<img src="../resources/img/festival/weather_example.jpg" alt="날씨">
								</div>
							</li>
							<li>  ❤ 길찾기
								<div class="map-api">
									<img src="../resources/img/festival/examMap.png" alt="길찾기">
								</div>
							</li>		
						</ul>
					</section>
				</div>
			</main>
		</div>
		<script>
		</script>
	</body>
</html>