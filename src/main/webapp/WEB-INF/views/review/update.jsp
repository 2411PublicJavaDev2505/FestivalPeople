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
						<!-- 첨부파일 이미지 는 재업로드는 ??검색해볼것~
						참고사항 notice 참고하기! -->
		 			<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }"> 
		 			<input type="hidden" name="reviewNo" value="${review.reviewNo }">
					<div class="review-title">
					<!-- 4/21수정 만들면서 아래코드 추가 작성  -->
						제목 <input type="text" name="reviewTitle" value="${review.reviewTitle }" size="80">
					</div>
					<div class="review-content">
						<div><span>내용 </span></div>
						<textarea rows="5" cols="82" name="reviewContent">${review.reviewContent }</textarea>
					</div>
					
					<div class="review-attach">
						<!-- div풀기4/21 -->
						<!-- 첨부파일버튼 다시 옮기기!첨부파일 코드 추가해줘야함! -->
						<input type="file" name ="images"> <br> 
						<input type="file" name ="images"> <br> 
 						<input type="file" name ="images"> <br> 
					</div>
					<div class="reviewinsert-btn">
						<!-- type이러던지 id값 변경해줘야함4/21 -->
						<button type="submit" class=submitbtn">수정</button>
						<button type="submit" id="submitbtn-c">목록으로</button> 
					</div>
		 		</form> 
			</main>
<%-- 			<jsp:include page="../include/footer.jsp"/> --%>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>