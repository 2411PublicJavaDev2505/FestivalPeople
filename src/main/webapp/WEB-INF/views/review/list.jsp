<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>후기 게시판 List 전체</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/list.css">
</head>
<body>
	<!-- 광고배너 -->
	<div class="side-banner left-banner">
		<a href="/festival/detail/${festival1.festivalNo }"><img src="${festival1.festivalFilePath }" alt="왼쪽 광고" /></a>
	</div>
	<div class="side-banner right-banner">
		<a href="/festival/detail/${festival2.festivalNo }"><img src="${festival2.festivalFilePath }" alt="왼쪽 광고" /></a>
	</div>

    <!-- 바탕화면 -->
	<div class="background-image">
    	 <img src="../resources/img/review/review-background.jpg" alt="바탕화면">
    </div>
    <!-- 오른쪽배너 왼쪽으로 옮기는코드 몰라 못옯김...혹시몰라
    div 아래꺼 추가하고 css에 맨위에 추가해도 안옴....내일다시 지우기!4/28일 21:10 -->
    <div id="container">
     	<jsp:include page="../include/header.jsp"/>
    	<div class="review-all">
			    <div class="reviewlist-h3">
				    <span>여행후기</span>
			    </div>
		    <div class="reviewsearch">
		        <form action="/review/search" method="get" >
			        <select class="review-searchbar" name="searchCondition">
			            <option value="all">전체</option>
			            <option value="review_title">제목</option>
			            <option value="review_content">내용</option>
			        </select>
			        <input class="searchbox" type="text" name="searchKeyword" placeholder="검색">
			        <button  type="submit" class="search-btn">⌕</button>
		        </form>
		    </div>
		        <table class="reviewlist-table">
		        <thead>
		            <tr>
		                <td>후기번호</td>
		                <td>작성자</td>
		                <td>제목</td>
		                <td>작성시간</td>
		                <td>조회수</td>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="review" items="${rList }">
			            <tr>
			                <td>${review.reviewNo}</td>
			                <td>${review.nickname}</td>
							<td id="review-title" onclick="reviewDetail('${review.reviewNo}');"><a onclick="reviewDetail('${review.reviewNo}');">${review.reviewTitle }</a></td>
			                <td>${review.reviewWriteTime }</td>
			                <td>${review.reviewCount }</td>
			            </tr>
		            </c:forEach>
		        </tbody>
			</table>
		    
		    <!-- 페이지 네이션! 이름값 notice랑 맞춰줌! -->
		    <!-- notice에는 버튼으로 있어서 바꿔줌! -->
		    <!-- notice랑 맞춰주기위해 기존것은 주석처리하고 새로작성! -->
		    <!-- 잘 바꿔주면 지워주기! -->
		    <!-- 난page로 했어서 안되면 currentPage를 page로 바꿔주기*********  -->
		    <!-- pageinfo를 추가? -->
		    <!-- 4/29일 pageinfo 추가 -->
		    <!-- 다시 원복! -->
		    <div class="rivew-pagination">
					<c:if test="${pageInfo.startNavi ne 1 }">
						<button class="page-btn" onclick="prev();">&lt;</button>
					</c:if>
					<c:forEach begin="${pageInfo.startNavi }" end="${endNavi }" var="p">
						<c:if test="${p eq currentPage }">
							<span class="page-num active" onclick="move('${p}');">${p }</span>
						</c:if>
						<c:if test="${p ne currentPage }">
							<span class="page-num" onclick="move('${p}');">${p }</span>
						</c:if>
					</c:forEach>
					<c:if test="${pageInfo.endNavi ne maxPage }">
						<button class="page-btn" onclick="next();">&gt;</button>
					</c:if>
					<!-- 여기까지 페이지 네이션 -->
	
<%-- 			    <c:if test="${startNavi ne 1 }"> --%>
<!-- 			    	수정했음! -->
<%-- 			    	<a href="/review/list?page=${startNavi-1 }">&lt;</a> --%>
<%-- 			    </c:if> --%>
<%-- 			    <c:forEach begin="${startNavi }" end="${endNavi }" var="p"> --%>
<%-- 			    	<a href="/review/list?page=${p }">${p }</a> --%>
<%-- 			    </c:forEach> --%>
<%-- 			    <c:if test="${endNavi ne maxPage }"> --%>
<%-- 			    	<a href="/review/list?page=${endNavi+1 }">&gt;</a> --%>
<%-- 			    </c:if> --%>
		    </div>
		    <!-- 글쓰기버튼! -->
		    <!-- notice에선 div 가 버튼에있어 수정! -->
				<!-- 4/25 맵퍼에 <select id="selectOneByNo" resultMap="reviewResultMap"> 조인으로
				인해 로그인안한상태에서 글쓰기버튼 보여 코드 수정! eq로만 바꿔줌-->
				<c:if test="${sessionScope.member.memberYn ne null && sessionScope.member.memberYn eq 'Y'}" >
			    <div class="reviewinsert-btn">
			    	<button onClick="reviewinsert();" id="reviewinsert-btn">글쓰기</button>
			    </div>
				</c:if>
			</div>
			</div>
			<!-- 정리되면 전체 주석처리 지울것! -->
	<script type="text/javascript">
		const reviewDetail = (reviewNo) => {
			location.href ="/review/detail?reviewNo=" + reviewNo;
		}
	
		const reviewinsert = () => {
			location.href = "/review/insert";
		}
		
		//아래3개코드 페이징! notice랑 맞추기 04/29 11:28
		
		const prev = () => {
			location.href="/review/list?page=" +("${pageInfo.startNavi}" -1);
		}
		const move = (p) => {
			location.href ="/review/list?page=" + p;
		}
		const next = () => {
			location.href="/review/list?page=" + ("${pageInfo.endNavi}" +1);
		}
	</script>
</body>
</html>