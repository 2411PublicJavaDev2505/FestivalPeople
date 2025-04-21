<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/list.css">
	<title>후기 게시판 List 전체</title>
</head>
<body>
	<div class="side-banner left-banner">
        <a href="http://localhost:8888/festival/detail/287"><img src="../resources/img/review/banner-poster.jpg" alt="왼쪽 광고" /></a>
    </div>
    <div class="side-banner right-banner">
        <a href="http://localhost:8888/festival/detail/288"><img src="../resources/img/review/banner-posterR.jpg" alt="오른쪽 광고" /></a>
    </div>
	<div class="background-image">
    	 <img src="../resources/img/review/review-background.jpg" alt="바탕화면">
    </div>
    <div id="container">
     	<jsp:include page="../include/header.jsp"/>
		    <div class="reviewlist-main">
			    <div class="reviewlist-h3">
				    <h3>여행후기</h3>
			    </div>
			<main>
		    <div class="reviewsearch">
		        <!-- action값넣기 -->
		        <form action="/review/search" method="get" >
			        <select class="review-searchbar" name="reviewsearchCondition">
			            <option value="all">전체</option>
			            <option value="review_title">제목</option>
			            <option value="review_content">내용</option>
			        </select>
			        <input class="searchbox" type="text" name="searchKeyword" placeholder="검색">
			        <button  type="submit" class="search-btn">⌕</button>
		        </form>
		    </div>
		    <div class="reviewlist">
		        <table class="reviewlist-table">
		            <tr class="reviewlist-top">
		                <td>후기번호</td>
		                <td>작성자</td>
		                <td>제목</td>
		                <td>작성시간</td>
		                <td>조회수</td>
		            </tr>
		            <c:forEach var="review" items="${seachList }">
			            <tr>
			                <!-- 4/19 18:34분 수정시작! -->
			                <!-- 수정했으나 list에 밑줄나오게하는건?? -->
			                <td>${review.reviewNo}</td>
			                <td>${review.memberName}</td>
<%-- 			                <td><a href="/review/${review.reviewNo}">${review.reviewTitle }</td> --%>
			                 <td id="review-title"><a onclick="reviewDetail('${review.reviewNo}');">${review.reviewTitle }</a></td>
			                <td>${review.reviewWriteTime }</td>
			                <td>${review.reviewCount }</td>
			            </tr>
		            </c:forEach>
		        </table>
		    </div>
		    <div class="page">
			    <c:if test="${startNavi ne 1 }">
			    	<!-- 수정했음! -->
			    	<a href="/review/list?page=${startNavi-1 }">&lt;</a>
			    </c:if>
			    <c:forEach begin="${startNavi }" end="${endNavi }" var="p">
			    	<a href="/review/list?page=${p }">${p }</a>
			    </c:forEach>
			    <c:if test="${endNavi ne maxPage }">
			    	<a href="/review/list?page=${endNavi+1 }">&gt;</a>
			    </c:if>
		    </div>
		    <div class="reviewinsert-btn">
				<c:if test="${sessionScope.member.memberNo ne null && sessionScope.member.memberNo ne ''}" >
			    	<button onClick="reviewinsert();" id="reviewinsert-btn">글쓰기</button>
				</c:if>
		    </div>
			</main>
	    </div>
	</div>
	<script type="text/javascript">
		const reviewDetail = (reviewNo) => {
			location.href ="/review/detail?reviewNo=" + reviewNo;
		}
	
		const reviewinsert = () => {
			location.href = "/review/insert";
		}
	</script>
</body>
</html>