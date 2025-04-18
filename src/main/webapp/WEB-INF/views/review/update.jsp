<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/insert.css">
	<title>후기게시판 수정</title>
</head>
<body>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<div class="reviewinsert-main">
			<div class="reviewinsert-h3">
				<h3>여행후기 수정</h3>
			</div>
			<main>
		 		<form action="/review/update" method="post" enctype="multipart/form-data">
						<!-- 원래자리로 되돌려주기!!4/18 11:11 아니면 지울것!! -->
						<input type="file" name ="images"> <br>
						<input type="file" name ="images"> <br>
						<input type="file" name ="images"> <br>
		 			<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }"> 
					<div class="review-title">
					<!-- name값 넣어줘야함! -->
						제목 <input type="text" name="reviewTitle" size="80">
					</div>
					<div class="review-content">
						<div><span>내용 </span></div>
						<textarea rows="5" cols="82" name="reviewContent"></textarea>
					</div>
					
					<div class="review-attach">
						<!-- div풀기4/18 11:00 -->
						<!-- 첨부파일버튼 다시 옮기기! -->
<!-- 						<input type="file" name ="images"> <br>  -->
<!-- 						<input type="file" name ="images"> <br>  -->
<!--  						<input type="file" name ="images"> <br>  -->
					</div>
					<div class="reviewinsert-btn">
						<button type="submit" id="submitbtn">수정</button>
						<button type="submit" id="submitbtn-c">삭제</button> 
					</div>
		 		</form> 
			</main>
<%-- 			<jsp:include page="../include/footer.jsp"/> --%>
		</div>
	</div>
</body>
</html>