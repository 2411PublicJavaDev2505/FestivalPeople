<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<link rel="stylesheet" href="../resources/css/review/search.css">
	<title>후기 게시판 List 검색</title>
</head>
<body>
	<!-- 바탕화면 -->
	<div class="background-image">
    	 <img src="../resources/img/review/review-background.jpg" alt="바탕화면">
    </div>
     	<jsp:include page="../include/header.jsp"/>
		    <div class="review-all">
			    <div class="reviewlist-h3">
				    <span>여행후기</span>
			    </div>
		   	<div class="reviewsearch">
		        <form action="/review/search" method="get" >
			        <select class="review-searchbar" name="searchCondition">
			            <option value="all"<c:if test="${searchCondition eq 'all' }">selected</c:if>>전체</option>
			            <option value="review_title"<c:if test="${searchCondition eq 'review_title' }">selected</c:if>>제목</option>
			            <option value="review_content"<c:if test="${searchCondition eq 'review_content' }">selected</c:if>>내용</option>
			        </select>
			        <input class="searchbox" type="text" name="searchKeyword" placeholder="검색" value="${searchKeyword }">
			        <button  type="submit" class="search-btn">⌕</button>
		        </form>
		    </div>
		    <!-- 후기게시판 -->
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
					<c:forEach var="review" items="${seachList }">
						<tr>
							<td>${review.reviewNo}</td>
							<td>${review.nickname}</td>
							<td id="review-title"><a onclick="reviewDetail('${review.reviewNo}');">${review.reviewTitle }</a></td>
							<td>${review.reviewWriteTime }</td>
							<td>${review.reviewCount }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="rivew-pagination">
				<c:if test="${startNavi ne 1 }">
					<button class="page-btn" onclick="prev();">&lt;</button>
				</c:if>
					<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
						<c:if test="${p eq currentPage }">
							<span class="page-num active" onclick="move('${p}');">${p }</span>
						</c:if>
						<c:if test="${p ne currentPage }">
							<span class="page-num" onclick="move('${p}');">${p }</span>
						</c:if>
					</c:forEach>
				<c:if test="${endNavi ne maxPage }">
					<button class="page-btn" onclick="next();">&gt;</button>
				</c:if>
			</div>
			<div class="reviewinsert-btn">
				<c:if test="${sessionScope.member.memberYn ne null && sessionScope.member.memberYn eq 'Y'}" >
			    	<button onClick="reviewinsert();" id="reviewinsert-btn">글쓰기</button>
				</c:if>
		    </div>
	    </div>
	    <!-- 푸터 -->
    	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		<script type="text/javascript">
			const reviewDetail = (reviewNo) => {
				location.href ="/review/detail?reviewNo=" + reviewNo;
			}
		
			const reviewinsert = () => {
				location.href = "/review/insert";
			}
			const prev = () => {
				location.href="/review/search?searchCondition=${searchCondition }&searchKeyword=${searchKeyword}&page=" +(parseInt("${startNavi}") -1);
			}
			const move =(p) => {
				location.href="/review/search?searchCondition=${searchCondition }&searchKeyword=${searchKeyword}&page=" +p;
			}
			const next = () => {
				location.href="/review/search?searchCondition=${searchCondition }&searchKeyword=${searchKeyword}&page=" +(parseInt("${endNavi}")+1);
			}
		</script>
	</body>
</html>