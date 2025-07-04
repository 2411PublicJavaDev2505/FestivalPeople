<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>후기 게시판 List 전체</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<link rel="stylesheet" href="../resources/css/review/list.css">
</head>
<body>
    <!-- 바탕화면 -->
	<div class="background-image">
		<img src="../resources/img/review/review-background.jpg" alt="바탕화면">
    </div>
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
			                <td><fmt:formatDate value="${review.reviewWriteTime }" pattern="yyyy.MM.dd HH:mm"/></td>
			                <td>${review.reviewCount }</td>
			            </tr>
		            </c:forEach>
		        </tbody>
			</table>
				<div class="rivew-pagination">
					<c:if test="${pageInfo.startNavi ne 1}">
						<button class="page-btn" onclick="prev();">&lt;</button>
					</c:if>
						<c:forEach begin="${pageInfo.startNavi }" end="${pageInfo.endNavi }" var="p">
							<c:if test="${p eq currentPage }">
								<span class="page-num active" onclick="move('${p}');">${p }</span>
							</c:if>
							<c:if test="${p ne currentPage }">
								<span class="page-num" onclick="move('${p}');">${p }</span>
							</c:if>
						</c:forEach>
					<c:if test="${pageInfo.endNavi ne pageInfo.maxPage }">
						<button class="page-btn" onclick="next();">&gt;</button>
					</c:if>
				</div>
				<c:if test="${sessionScope.member.memberId ne null && sessionScope.member.memberYn eq 'Y'}" >
				    <div class="reviewinsert-btn">
				    	<button onClick="reviewinsert();" id="reviewinsert-btn">글쓰기</button>
				    </div>
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
				location.href="/review/list?page=" +(parseInt("${pageInfo.startNavi}") -1);
			}
			const move = (p) => {
				location.href ="/review/list?page="+p;
			}
			const next = () => {
				location.href="/review/list?page=" + (parseInt("${pageInfo.endNavi}") + 1);
			}
		</script>
	</body>
</html>