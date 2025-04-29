<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/include/header.css">
	<link rel="stylesheet" href="/resources/css/course/courseDetailPage.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/footer.css">
	
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
					<p class="courseText">나의 코스</p>
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
								<!-- 저장된 코스 리스트 출력 -->
								<div id="recommendation-container">									
									<c:forEach items="${placeList}" var="place">
											<div>
												<div class="course-category">
													<div class="place-title">
										                <c:choose>
										                    <c:when test="${place.category_group_code eq 'FD6'}">추천 맛집</c:when>
										                    <c:when test="${place.category_group_code eq 'CE7'}">추천 카페</c:when>
										                    <c:when test="${place.category_group_code eq 'AD5'}">추천 숙박업소</c:when>
										                    <c:when test="${place.category_group_code eq 'AT4'}">추천 관광지</c:when>
										                    <c:when test="${place.category_group_code eq 'PK6'}">추천 주차장</c:when>
										                    <c:when test="${place.category_group_code eq 'CT1'}">추천 문화시설</c:when>
										                    <c:otherwise>추천 장소</c:otherwise>
									              		</c:choose>									
													</div>
													<div class="place-name">${place.place_name} </div>
												</div>
				 								<div class="course-recommend-section">
													<iframe src="${place.place_url}" width="100%" height="600px"></iframe><br>
													<div class="iframe-description">
														<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
														<a href="${place.place_url}" target="_blank">${place.place_url}</a>
													</div>
												</div>								
											</div>
									</c:forEach>			
								</div>	
								<div class="deleteDiv">	
									<form action="/course/delete" id="deleteForm" method="get">
										<input type="hidden" name="courseNo" value="${course.courseNo }">
										<button class="deleteButton" type="button" onclick="deleteCourse(${course.courseNo})" >삭제하기</button>
									</form>				
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
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
<input type="hidden" id="festivalNo" value="${festival.festivalNo}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJavaScriptKey }"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	/* 배경화면 설정 */
	const images = [
	    "/resources/img/course/bgi2.jpg",
	    "/resources/img/course/bgi3.jpg",
	    "/resources/img/course/bgi5.jpg"  
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
	  let festivalY = ${festival.mapHCode};
	  let festivalX = ${festival.mapVCode};

	  var kakaoMapContainer = document.querySelector('.course-recommend-map');
	  var mapOptions = {
	      center: new kakao.maps.LatLng(Number(festivalY), Number(festivalX)),
	      level: 5
	  };
	  var map = new kakao.maps.Map(kakaoMapContainer, mapOptions); // 맵 생성

	  // 📍 [1] 축제 마커 먼저 찍기
	  var festivalMarkerImage = new kakao.maps.MarkerImage(
	      '/resources/img/course/icon/festival.png', // 축제 아이콘 경로
	      new kakao.maps.Size(24, 35) // 축제 마커 크기 (조금 크게)
	  );

	  var festivalMarker = new kakao.maps.Marker({
	      map: map,
	      position: new kakao.maps.LatLng(Number(festivalY), Number(festivalX)),
	      title: "${festival.festivalName}",
	      image: festivalMarkerImage
	  });

	  var festivalInfowindow = new kakao.maps.InfoWindow({
	      content: '<div style="padding:5px; font-size:12px;">${festival.festivalName}</div>'
	  });

	  kakao.maps.event.addListener(festivalMarker, 'mouseover', function() {
	      festivalInfowindow.open(map, festivalMarker);
	  });
	  kakao.maps.event.addListener(festivalMarker, 'mouseout', function() {
	      festivalInfowindow.close();
	  });

	  // 📍 [2] 저장한 코스 장소들 placeList 가져오기
	  var placeList = [
	      <c:forEach var="place" items="${placeList}" varStatus="status">
	          {
	              name: "${place.place_name}",
	              x: ${place.x},
	              y: ${place.y},
	              category: "${place.category_group_code}"
	          }<c:if test="${!status.last}">,</c:if>
	      </c:forEach>
	  ];

	  //카테고리별 마커 이미지 설정
	  function getMarkerImage(category) {
	      var basePath = '/resources/img/course/icon/';
	      var imgName = 'default.png';

	      switch (category) {
	          case 'FD6':
	              imgName = 'matzip.png';
	              break;
	          case 'AD5':
	              imgName = 'hotel.png';
	              break;
	          case 'CE7':
	              imgName = 'cafe.png';
	              break;
	          case 'AT4':
	              imgName = 'tour.png';
	              break;
	          case 'PK6':
	              imgName = 'parking.png';
	              break;
	          case 'CT1':
	              imgName = 'culture.png';
	              break;
	      }
	      return new kakao.maps.MarkerImage(
	          basePath + imgName,
	          new kakao.maps.Size(24, 35)
	      );
	  }

	  //저장된 장소 placeList 돌면서 마커 찍기
	  placeList.forEach(function(place) {
	      var marker = new kakao.maps.Marker({
	          map: map,
	          position: new kakao.maps.LatLng(Number(place.y), Number(place.x)),
	          title: place.name,
	          image: getMarkerImage(place.category)
	      });

	      var infowindow = new kakao.maps.InfoWindow({
	          content: '<div style="padding:5px; font-size:12px;">' + place.name + '</div>'
	      });

	      kakao.maps.event.addListener(marker, 'mouseover', function() {
	          infowindow.open(map, marker);
	      });
	      kakao.maps.event.addListener(marker, 'mouseout', function() {
	          infowindow.close();
	      });
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
	
 	 
 	 /* 코스 삭제하기 */
 	 const deleteCourse = (courseNo) => {
 		 var result = confirm("정말로 삭제하시겠습니까?");
 		 if(result === true) {
 			 document.getElementById('deleteForm').submit();
 		 }else {
 			 return false;
 		 } 		 
 		 
 		 
 	 }
</script>

</body>
</html>