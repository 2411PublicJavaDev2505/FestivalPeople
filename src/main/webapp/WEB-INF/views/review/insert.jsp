<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/insert.css">
	<title>후기게시판 등록</title>
</head>
<body>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<div class="reviewinsert-main">
			<div class="reviewinsert-h3">
				<h3>여행후기 등록</h3>
			</div>
			<main>
		 		<form action="/review/insert" method="post" enctype="multipart/form-data">
						<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }"> 
					<div class="review-title">
						제목 <input type="text" name="reviewTitle" size="80">
					</div>
					<div class="review-content">
						<div><span>내용 </span></div>
						<textarea rows="5" cols="82" name="reviewContent"></textarea>
					</div>
						<div class="review-attach">
							<!-- div풀기4/18 11:00 -->
							<!-- 첨부파일버튼 다시 옮기기! -->
							<!-- 되돌리고 css position: relative 주석처리-->
							<!-- 되돌렸어도 등록하면 상세페이지 이미지 출력??!되는 현상! -->
							<!-- position: relative 지워도 파일선택 안됨현상...다시 되돌려줌!! 
							<!--원인은??-->
							<!-- css에 position: relative 지웠더니 3개버튼 잘눌림! -->
	 						<input type="file" name ="images"> <br>  
	 						<input type="file" name ="images"> <br>  
	  						<input type="file" name ="images"> <br>  
						</div>`
					<div class="reviewinsert-btn">
						<button type="submit" id="submitbtn">등록</button>
						<button type="submit" id="submitbtn-c">작성취소</button> 
					</div>
		 		</form> 
			</main>
<%--  			<jsp:include page="../include/footer.jsp"/> --%>
		</div>
	</div>
</body>
</html>