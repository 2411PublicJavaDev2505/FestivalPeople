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
	<div class="background-image">
		<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>
	<jsp:include page="../include/header.jsp"/>
	<div class="notice-board">
	    <div class="notice-title">
	        <span>공지사항</span>
	    </div>
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
	            <tr class="highlight">
	                <td>1</td>
	                <td><b>페피 가족 여러분 환영함</b></td>
	                <td>152</td>
	                <td>25.04.07</td>
	            </tr>
	            <tr>
	                <td>2</td>
	                <td>안내드립니다</td>
	                <td>253</td>
	                <td>23.02.04</td>
	            </tr>
	            <tr>
	                <td>3</td>
	                <td>안내드립니다</td>
	                <td>325</td>
	                <td>23.01.09</td>
	            </tr>
	            <tr>
	                <td>4</td>
	                <td>안내드립니다</td>
	                <td>434</td>
	                <td>22.12.31</td>
	            </tr>
	            <tr>
	                <td>5</td>
	                <td>안내드립니다</td>
	                <td>452</td>
	                <td>22.12.25</td>
	            </tr>
	            <tr>
	                <td>6</td>
	                <td>안내드립니다</td>
	                <td>553</td>
	                <td>22.11.11</td>
	            </tr>
	            <tr>
	                <td>7</td>
	                <td>매랑꽃 별꽃 축제 안내 사항</td>
	                <td>475</td>
	                <td>22.08.11</td>
	            </tr>
	            <tr>
	                <td>8</td>
	                <td>안내드립니다</td>
	                <td>522</td>
	                <td>21.04.09</td>
	            </tr>
	        </tbody>
	    </table>
	    <div class="notice-pagination">
	        <button class="page-btn">&lt;</button>
	        <span class="page-num active">1</span>
	        <span class="page-num">2</span>
	        <span class="page-num">3</span>
	        <span class="page-num">4</span>
	        <span class="page-num">5</span>
	        <button class="page-btn">&gt;</button>
	    </div>
	    <c:if test="${member.memberId ne null && member.managerYn eq 'Y'}">
		    <div class="noticeinsert-btn">
			    	<button onClick="noticeInsert();" id="noticeinsert-btn">글쓰기</button>
			</div>
		</c:if>
	</div>
	<script type="text/javascript">
		const noticeInsert = () => {
			location.href = "/notice/insert";
		}
	</script>


</body>
</html>
