<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Festival People</title>
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <link rel="stylesheet" href="../resources/css/notice/list.css">
</head>
<body>
	<!-- 바탕화면 -->
	<div class="background-image">
		<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>
    <!-- 헤더 -->
	<jsp:include page="../include/header.jsp"/>
	<div class="notice-board">
	    <div class="notice-title">
	        <span>공지사항</span>
	    </div>
	    <!-- 공시사항 게시판 -->
	    <table class="notice-table">
	        <thead>
	            <tr>
	                <th>번호</th>
	                <th>제목</th>
	                <th>조회수</th>
	                <th>작성일자</th>
	            </tr>
	        </thead>
	        <tbody>
<!-- 	            <tr class="highlight"> -->
<!-- 	                <td>1</td> -->
<!-- 	                <td><b>페피 가족 여러분 환영함</b></td> -->
<!-- 	                <td>152</td> -->
<!-- 	                <td>25.04.07</td> -->
<!-- 	            </tr> -->
	        	<c:forEach items="${nList }" var="notice" varStatus="i">
		            <tr>
		                <td>${(currentPage-1)*10 + i.index + 1}</td>
		                <td id="notice-title"><b onclick="showDetail('${notice.noticeNo}');">${notice.noticeTitle }</b></td>
		                <td>${notice.noticeCount }</td>
		                <td>${notice.noticeWriteDate }</td>
		            </tr>
	        	</c:forEach>
	        </tbody>
	    </table>
	    <!-- 페이지네이션 -->
	    <div class="notice-pagination">
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
	        <c:if test="${pageInfo.endNavi eq maxPage }">
		        <button class="page-btn" onclick="next();">&gt;</button>
	        </c:if>
	    </div>
	    <c:if test="${member.memberId ne null && member.managerYn eq 'Y'}">
		    <div class="noticeinsert-btn">
			    	<button onClick="noticeInsert();" id="noticeinsert-btn">글쓰기</button>
			</div>
		</c:if>
	</div>
	<!-- 자바스크립트 -->
	<script type="text/javascript">
		const showDetail = (noticeNo) => {
			location.href = "/notice/detail?noticeNo=" + noticeNo;
		}
		const noticeInsert = () => {
			location.href = "/notice/insert";
		}
		const prev = () => {
			location.href="/notice/list?currentPage=" + ("${pageInfo.startNavi}" - 1);
		}
		const move = (p) => {
			location.href = "/notice/list?currentPage=" + p;
		}
		const next = () => {
			location.href="/notice/list?currentPage=" + ("${pageInfo.endNavi}" + 1);
		}
	</script>
</body>
</html>
