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
		        <form action="" >
			        <select class="review-searchbar" name="reviewSearch">
			            <option value="all">전체</option>
			            <option value="review_title">제목</option>
			            <option value="review_content">내용</option>
			        </select>
			        <input class="searchbox" type="text" name="searchKeyword" placeholder="검색">
			        <button class="search-btn">⌕</button>
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
		            <tr>
		                <td>555</td>
		                <td>user1</td>
		                <td>외로움을 달랠남자구합니다..</td>
		                <td>25/04/07</td>
		                <td>50033</td>
		            </tr>
		            <tr>
		                <td>554</td>
		                <td>user02</td>
		                <td>같이갈래 후기글 남깁니다..</td>
		                <td>25/04/05</td>
		                <td>30003</td>
		            </tr>
		            <tr>
		                <td>553</td>
		                <td>user03</td>
		                <td>벚꽃아 개나리한테 좀 배우...</td>
		                <td>25/04/03</td>
		                <td>555</td>
		            </tr>
		            <tr>
		                <td>552</td>
		                <td>kintex</td>
		                <td>2025서울모빌리티쇼..</td>
		                <td>25/04/03</td>
		                <td>10234</td>
		            </tr>
		            <tr>
		                <td>551</td>
		                <td>strawber</td>
		                <td>논산딸기먹기 헬기타기 사..</td>
		                <td>25/03/24</td>
		                <td>9414</td>
		            </tr>
		        </table>
		    </div>
		    <div class="page">
			    <a href="#"><</a>
			    <a href="#">1</a>
			    <a href="#">2</a>
			    <a href="#">3</a>
			    <a href="#">4</a>
			    <a href="#">5</a>
			    <a href="#">></a>
		    </div>
		    <div class="reviewinsert-btn">
<!-- 				<a href="/review/insert">글쓰기</a> -->
		    	<button onClick="reviewinsert();" id="reviewinsert-btn">글쓰기</button>
		    </div>
			</main>
	    </div>
	</div>
	<script type="text/javascript">
		const reviewinsert = () => {
			location.href = "/review/insert";
		}
	</script>
</body>
</html>