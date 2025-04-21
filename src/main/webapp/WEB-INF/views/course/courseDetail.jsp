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
<!-- 					<form id="sortForm" action="/course/detail" method="get"> -->
						<label>
							<input type="checkbox" name="category" value="FD6">
							맛집
						</label>
						<label>
							<input type="checkbox" name="category" value="AD5">
							숙박업소
						</label>
						<label>
							<input type="checkbox" name="category" value="CE7">
							카페
						</label>
						<label>
							<input type="checkbox" name="category" value="AT4">
							관광명소
						</label>
						<label>
							<input type="checkbox" name="category" value="PK6">
							주차장
						</label>
						<label>
							<input type="checkbox" name="category" value="CT1">
							문화시설
						</label>
<!-- 					</form> -->
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

							<img src= "${festival.festivalFilePath}" alt="부산">
						</div>
						<div id="resultContainer" class="place-result-container">
						
						<div id="recommendation-container">
							<%-- <c:forEach items="${placeList }" var="place" varStatus="i">
								<c:if test="${place.category_group_code eq 'FD6'}">
									<div class="place-container">
										<div class="place-title">인근 맛집</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
								<c:if test="${place.category_group-code eq 'AD5'}">
									<div class="place-container">
										<div class="place-title">인근 숙박업소</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
								<c:if test="${place.category_group-code eq 'CE7'}">
									<div class="place-container">
										<div class="place-title">인근 카페</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
								<c:if test="${place.category_group-code eq 'AT4'}">
									<div class="place-container">
										<div class="place-title">인근 관광지</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
								<c:if test="${place.category_group-code eq 'PK6'}">
									<div class="place-container">
										<div class="place-title">인근 주차장</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
								<c:if test="${place.category_group-code eq 'CT1'}">
									<div class="place-container">
										<div class="place-title">인근 문화공간</div>
										<div class="place-name">"${place.place_name }"</div>
									</div>								
								</c:if>
							
							</c:forEach> --%>
							
						</div>
						
						
							<form class="insert-course" action="/" method="post">
								<div class="expect-cost">예상 금액 : ??</div>								
								<div class="expect-time">예상 소요 시간 : ??</div>								
								<input type="button" value="코스 저장하기">							
							</form>													
							
						</div>

						</div>
					<div class="course-recommend-right">
		                <div class="course-search">
			                <form class="search-form" action="course/list" method="get">
			                    <select>
			                        <option value="all">전체</option>
			                        <option value="name">축제명</option>
			                        <option value="location">지역</option>
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
			</div>	
		</main>	
	</div>
<input type="hidden" id="festivalNo" value="${festival.festivalNo}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce2765b5c8d1c862f02d7a486094793d"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	// 넘어오는 자료 확인용
	let festivalNo = $('#festivalNo').val();
	console.log("festivalX: ", "${coursePoint.festivalX}");
	console.log("festivalY: ", "${coursePoint.festivalY}");


	
	// 카카오맵 , 최상단 마커 꽂는 지도 표시할때 필요한부분
	var kakaoMapContainer = document.querySelector('.course-recommend-map')
	var mapOptions = {
			center : new kakao.maps.LatLng(Number("${coursePoint.festivalY}"), Number("${coursePoint.festivalX}")),
			level: 3	 

	};
	// 지도 생성
	var map = new kakao.maps.Map(kakaoMapContainer, mapOptions);
	
	// 마커 찍기 위해 축제, 맛집, 호텔 좌표값 보내주는거
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
	    
	 	// 인포윈도우 생성 팝업으로 해당 장소 설명 
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
	
	
	$(document).ready(function () {
		let selectedCategories = [];

		$('input[type=checkbox]').change(function() {
			const value = $(this).val();
			console.log(value);

			if($(this).is(':checked')) {
				if(!selectedCategories.includes(value)) {
					selectedCategories.push(value);
				}
			} else {
				selectedCategories = selectedCategories.filter(item => item !== value);
			}	

			// 여기에 AJAX 넣어야 함!
			const obj = {
					"categories": selectedCategories,
					"festivalNo": $('#festivalNo').val()
				};
			
			$.ajax({
				url: '/course/filter',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(obj),
				success: function (data) {
					console.log("서버 응답:", data); // 확인용 콘솔
					console.log("thkdls")
					console.log(data[0].place_name)
					
					let html = '';
					
					  data.forEach(place => {
					    if(place.category_group_code == "FD6") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천맛집</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "`+place.place_url +`" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    if(place.category_group_code == "AD5") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천 숙소</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "${place.place_url }" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    if(place.category_group_code == "CE7") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천 카페</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "${place.place_url }" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    if(place.category_group_code == "AT4") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천 관강지</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "${place.place_url }" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    if(place.category_group_code == "PK6") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천 주차장</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "${place.place_url }" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    if(place.category_group_code == "CT1") {
					    html += `
						<div class="place-container">
							<div class="place-title">추천 문화 시설</div>
							<div class="place-name">${place.place_name }</div>
								</div>
								<div class="course-recommend-section">
									<iframe src= "${place.place_url }" width="100%" height="600px"></iframe><br>
								<div class="iframe-description">
									<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="${place.place_url}" target="_blank">${place.place_url}</a>
							</div>
						</div>					    	
					    `;
					    }
					    
					    
					    
					  });
					
					$('#recommendation-container').html(html);
				},
				error: function(err) {
					console.error('ajax 오류', err);
				}
			});

			console.log("보내는 데이터:", JSON.stringify({
				categories: selectedCategories,
				festivalNo: $('#festivalNo').val()
			}));
		});
	});
	
/*  	console.log(JSON.stringify({
		  categories: selectedCategories,
		  festivalNo: $('#festivalNo').val()
		})); */ 
	
	
 	$(document).ready(function () {
	    $('input[name="category"]').change(function () {
	        console.log("체크박스 변경됨:", $(this).val());
	    });
	}); 
</script>


</body>
</html>