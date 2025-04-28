<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/include/header.css">
	<link rel="stylesheet" href="/resources/css/course/courseDetailPage.css">

	
	<title>코스 추천</title>
</head>
<body>
	<div class="background-image">
    	 <img src="" alt="바탕화면">
    	 </div>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="course-total-container">		
				<div class="course-recommend-choice">
					<p class="courseText">
						나의 코스
						</p>
				</div>
		
				
				<div class="course-recommend-main">			
					<div class="course-recommend-left">
						<div  class="course-recommend-map" style="width:100%; height:400px;"></div>
							<div class="festival-title">
								<p>${course.festivalName}</p>
							</div>
								<div class="course-recommend-img">
									<img src= "${course.festivalImg}" alt="축제이미지">
								</div>
							<div id="resultContainer" class="place-result-container">
								<!-- 추천 코스 리스트 출력 -->
								<div id="recommendation-container">		
									<c:forEach items="${placeList}" var="place">
											<div>
												<div class="course-category">
													<div class="place-title">추천 맛집</div>
													<div class="place-name">${place.place_name} </div>
												</div>
				 								<div class="course-recommend-section">
													<iframe src="${place.place_url} " width="100%" height="600px"></iframe><br>
													<div class="iframe-description">
														<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
														<a href="${place.place_url}" target="_blank">${place.place_url}</a>
													</div>
												</div>								
											</div>
									</c:forEach>			
								</div>																						
							</div>
						</div>
							<div class="course-recommend-right">
				                <div class="course-search">				             
				                    <select id="searchCondition">
				                        <option value="all">전체</option>
				                        <option value="name">축제명</option>
				                        <option value="location">지역</option>
				                    </select>
				                    <input type="text" placeholder="다른 축제 찾기" id="searchKeyword">
				                    <button class="search-btn" id="searchBtn">⌕</button>
					            <div class="search-course-list" id="courseListResult"></div>
				            </div>
						</div>			
					</div>
				</div>	
			</div>	
		</main>	
	</div>
<input type="hidden" id="festivalNo" value="${festival.festivalNo}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce2765b5c8d1c862f02d7a486094793d"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	/* 배경화면 설정 */
	const images = [
/* 	    "../resources/img/course/bgi1.jpg", */
	    "../resources/img/course/bgi2.jpg",
	    "../resources/img/course/bgi3.jpg",
/* 	    "../resources/img/course/bgi4.jpg", */
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


	let festivalNo = $('#festivalNo').val();
	let festivalY = ${festival.getMapHCode()};
	let festivalX = ${festival.getMapVCode()};

	var kakaoMapContainer = document.querySelector('.course-recommend-map');
	var mapOptions = {
		center: new kakao.maps.LatLng(Number(festivalY), Number(festivalX)),
		level: 3
	};
	var map = new kakao.maps.Map(kakaoMapContainer, mapOptions);
	
	var positions = [
		{
			title: "${festival.festivalName}",
			latlng: new kakao.maps.LatLng(Number(festivalY), Number(festivalX))
		}
	];

	var festivalimg = "/resources/img/course/icon/festival.png";
	
	
	positions.forEach(pos => {
		let markerImage = new kakao.maps.MarkerImage(festivalimg, new kakao.maps.Size(24, 35));
		let marker = new kakao.maps.Marker({
			map: map,
			position: pos.latlng,
			title: pos.title,
			image: markerImage
		});
	
		let infowindow = new kakao.maps.InfoWindow({
			content: '<div style="padding:5px;font-size:14px;">' + pos.title + '</div>'
		});

		kakao.maps.event.addListener(marker, 'mouseover', () => infowindow.open(map, marker));
		kakao.maps.event.addListener(marker, 'mouseout', () => infowindow.close());
	});

	
 	 /* 오른쪽 리스트 div 처리  */
	document.addEventListener("DOMContentLoaded", function() {
	    document.getElementById("searchBtn").addEventListener("click", function(e) {
	        e.preventDefault(); // 기본 form 제출 방지

	        let searchCondition = document.getElementById("searchCondition").value;
	        let searchKeyword = document.getElementById("searchKeyword").value;

	        fetch("/course/rightSearch?searchCondition=" + searchCondition + "&searchKeyword=" + encodeURIComponent(searchKeyword))
	            .then(response => response.json())
	            .then(data => {
	                let resultDiv = document.getElementById("courseListResult");
	                resultDiv.innerHTML = ""; // 이전 검색 결과 비우기	               

	                if (data.length === 0) {
	                    resultDiv.innerHTML = "<p>검색 결과가 없습니다.</p>";
	                    return;
	                }

	                data.forEach(course => {
	                    let div = document.createElement("div");
	                    div.classList.add("search-course-title");
	                    div.innerHTML = '<a href="/course/detail?festivalNo=' + course.festivalNo + '">' + course.festivalName + '<br>'+course.festivalStartDate+'~'+course.festivalEndDate+'</a>';
	                    resultDiv.appendChild(div);
	                });
	            })
	            .catch(error => {
	                console.error("검색 실패:", error);
            });
	    });
	}); 
	
</script>

</body>
</html>