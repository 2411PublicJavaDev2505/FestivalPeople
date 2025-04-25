<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/intro/intro.css">
	<title>사이트 소개</title>
</head>
<body>
		<jsp:include page="../include/header.jsp"/>
		<!-- 바탕화면 -->
		<div class="background-image">
			<img src="../resources/img/member/insertSucess.jpg" alt="바탕화면">
		</div>
			<main class="container">
				
					<div class="card intro">
					<img src="../resources/img/intro/logo.png">
						<div class="card__content">
							<p class="card__title">저희 Festival People은 </p>
							<p class="card__description">회원님들의 지역과, 날짜, 날씨를 기반으로 여행코스를 추천해드리고,<br>
														같은 축제를 즐기실수 있게 커뮤니티를 만들어 친구들과 같이 여행을 할수 있습니다.</p>
							<c:if test="${sessionScope.member eq null }">
								<button class="card__button i" onclick="location.href='/member/login';">로그인</button>
								<button class="card__button secondary" onclick="location.href='/member/insert';">회원가입</button>
							</c:if>
						</div>
					</div>
					
					<div class="card variety">
						<img src="../resources/img/intro/variety.png">
						<div class="card__content">
							<p class="card__title">축제 추천 페이지 는</p>
							<p class="card__description">회원님의 주소지 기반으로 맑은 읽기예보를 나타내는 곳을 기준으로 추천해 드리고, <br>
														 축제를 선택하시면 해당 축제 장소 일기예보와길찾기 기능을 활용하여 도착 예상 시간까지 확인 하실수 있습니다.
							</p>
							<button class="card__button v" onclick="location.href='/festival/list';">축제 페이지로</button>
						</div>
					</div>
					
					<div class="card recommend">
						<img src="../resources/img/intro/recommend.png">
						<div class="card__content">
							<p class="card__title">코스 추천 기능은</p>
							<p class="card__description">회원님의 주소지 주변의 축제리스트를 보여드리고, 선택하신 축제 장소 주변에 있는 <br>
														맛집, 카페, 숙박시설 등 카테고리별로 가까운 장소를 추천해드리며,
														해당 코스가 마음에 드실 경우 저장을 통해 마이페이지내에서 확인하실 수 있습니다.
							</p>
							<button class="card__button r" onclick="goCourse();">코스추천 페이지로</button>
						</div>
					</div>
					
					<div class="card together">
						<img src="../resources/img/intro/together.png">
						<div class="card__content">
							<p class="card__title">Festival People 는</p>
							<p class="card__description">소개내용</p>
							<button class="card__button t" onclick="goChat();">같이 갈래? 페이지로</button>
						</div>
					</div>
					
					<div class="card review">
						<img src="../resources/img/intro/review.png">
						<div class="card__content">
							<p class="card__title">Festival People 는</p>
							<p class="card__description">소개내용</p>
							<button class="card__button re" onclick="location.href='/review/list';">여행 후기 페이지로</button>
						</div>
					</div>
			</main>
</body>
</html>