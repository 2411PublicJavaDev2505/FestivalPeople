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
	<div class="background-image">
    	 <img src="" alt="바탕화면">
    	 </div>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<main>
			<div class="course-total-container">		
				<div class="course-recommend-choice">
					<div>
					<p class="courseText">코스추천
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
						</p>
					</div>
				</div>

				<div class="course-recommend-main">			
					<div class="course-recommend-left">
						<div  class="course-recommend-map" style="width:100%; height:400px;">							
						</div>
						<div class="festival-title">
							<p>${festival.festivalName}</p>
						</div>
						<div class="course-recommend-img">
							<img src= "${festival.festivalFilePath}" alt="부산">
						</div>
						<div id="resultContainer" class="place-result-container">
						
						<!-- 추천 코스 리스트 출력 -->
						<div id="recommendation-container">					
						</div>					
							<form id="courseForm" class="insert-course">								
								<div class="expect-cost">선택 장소 수 : 0</div>	
								<input type="text" name="courseName" placeholder="코스명을 입력하세요"> 	
								<input type="hidden" name="festivalNo" value="${festival.festivalNo }">												
								<div id="hiddenPlaceInputs">
						        </div>
								<button type="button" id="saveCourseBtn">코스 저장</button>			
							</form>																			
						</div>
						</div>
							<div class="course-recommend-right">
				                <div class="course-search">				             
				                    <select id="searchCondition">
				                        <option value="all">전체</option>
				                        <option value="name">축제명</option>
				                        <option value="location">지역</option>
				                    </select>
				                    <input type="text" placeholder="검색" id="searchKeyword">
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
	    "../resources/img/course/bgi1.jpg",
	    "../resources/img/course/bgi2.jpg",
	    "../resources/img/course/bgi3.jpg",
	    "../resources/img/course/bgi4.jpg",
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
	let festivalY = ${coursePoint.festivalY};
	let festivalX = ${coursePoint.festivalX};

	
	// 지도 생성
	var kakaoMapContainer = document.querySelector('.course-recommend-map');
	var mapOptions = {
		center: new kakao.maps.LatLng(Number(festivalY), Number(festivalX)),
		level: 3
	};
	var map = new kakao.maps.Map(kakaoMapContainer, mapOptions);

	// 기본 마커들 (축제, 맛집, 호텔 등)
	var positions = [
		{
			title: "${festival.festivalName}",
			latlng: new kakao.maps.LatLng(Number(festivalY), Number(festivalX))
		}
	];

	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

	// 기본 마커들 찍기
	positions.forEach(pos => {
		let markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35));
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

	// 동적으로 추가될 마커들
	let dynamicMarkers = [];

	// 동적 마커 제거 함수
	function clearMarkers() {
		dynamicMarkers.forEach(marker => marker.setMap(null));
		dynamicMarkers = [];
	}


	/* 카테고리 Check-Box 선택시 동작하는 이벤트 */
	$(document).ready(function () {
		let selectedCategories = [];

		$('input[type=checkbox]').change(function () {
			const value = $(this).val();
			console.log("선택된 카테고리:", value);

			// 기존 추천 섹션 초기화
			$('#recommendation-container').html('');

			if ($(this).is(':checked')) {
				if (!selectedCategories.includes(value)) {
					selectedCategories.push(value);
				}
			} else {
				selectedCategories = selectedCategories.filter(item => item !== value);
			}

			const obj = {
				"categories": selectedCategories,
				"festivalNo": festivalNo
			};

			$.ajax({
				url: '/course/filter',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(obj),
				success: function (data) {
					console.log("서버 응답:", data);

					
					clearMarkers(); // 동적 마커 제거
					$('#recommendation-container').html('');
				    $('#hiddenPlaceInputs').html('');
					let html = '';
					data.forEach((place, i) => {
						const latlng = new kakao.maps.LatLng(Number(place.y), Number(place.x));
						const markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35));
						const marker = new kakao.maps.Marker({
							map: map,
							position: latlng,
							title: place.place_name,
							image: markerImage
						});
						dynamicMarkers.push(marker); // 배열에 저장

						const infowindow = new kakao.maps.InfoWindow({
							content: `<div style="padding:5px;font-size:14px;">`+place.place_name+`</div>`
						});
						kakao.maps.event.addListener(marker, 'mouseover', () => infowindow.open(map, marker));
						kakao.maps.event.addListener(marker, 'mouseout', () => infowindow.close());

						
						// 숨겨진 input (폼 전송용)
						let hiddenInputs = `
						    <input type="hidden" name="category_group_code" value="`+place.category_group_code+`" />
						    <input type="hidden" name="place_name" value="`+place.place_name+`" />
						    <input type="hidden" name="x" value="`+place.x+`" />
						    <input type="hidden" name="y" value="`+place.y+`" />
						`;
						$('#hiddenPlaceInputs').append(hiddenInputs);
						
						// 카테고리 별로 구분 출력
						let categoryTitle = '';
						if (place.category_group_code == "FD6") categoryTitle = "추천 맛집";
						else if (place.category_group_code == "AD5") categoryTitle = "추천 숙소";
						else if (place.category_group_code == "CE7") categoryTitle = "추천 카페";
						else if (place.category_group_code == "AT4") categoryTitle = "추천 관광지";
						else if (place.category_group_code == "PK6") categoryTitle = "추천 주차장";
						else if (place.category_group_code == "CT1") categoryTitle = "추천 문화시설";

						html += `
						<div class="course-category">
							<div class="place-title">`+categoryTitle+`</div>
							<div class="place-name">`+place.place_name+`</div>
						</div>
						<div class="course-recommend-section">
							<iframe src="`+place.place_url+`" width="100%" height="600px"></iframe><br>
							<div class="iframe-description">
								<p>자세한 정보는 아래 링크에서 확인하세요 👇</p>
								<a href="`+place.place_url+`" target="_blank">`+place.place_url+`</a>
							</div>
						</div>`;			
					});

					$('#recommendation-container').append(html);
					$('.expect-cost').text('선택 장소 수 : ' + data.length);
				},
				error: function (err) {
					console.error("AJAX 오류:", err);
				}
			});
		});
	});
	
	/* 코스 저장시 처리하는 자바스크립트 */
	document.querySelector("#saveCourseBtn").addEventListener("click", function(e) {
	    e.preventDefault();

	    const form = document.querySelector("#courseForm");
	    const formData = new FormData(form);

	    fetch("insert", {
	        method: "POST",
	        body: formData
	    })
	    .then(res => res.text())
	    .then(data => {
	        if (data === "success") {
	            alert("코스가 성공적으로 저장되었습니다!");
	            window.location.href = "/member/detail";
	        } else {
	            alert("저장에 실패했습니다. 다시 시도해주세요.");
	        }
	    })
	    .catch(error => {
	        console.error("에러:", error);
	        alert("요청 중 오류가 발생했습니다.");
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
	                    div.innerHTML = '<a href="/course/detail?festivalNo=' + course.festivalNo + '">' + course.festivalName + '</a>';
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