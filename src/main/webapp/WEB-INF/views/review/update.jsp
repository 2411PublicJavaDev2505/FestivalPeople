<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- 4/23등록jsp랑 같게 해주기위해 insert.jsp 있는 코드추가!  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/insert.css">
	<title>후기게시판 수정</title>
</head>
	<!-- 4/23 두번째 추가! -->
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
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
						<!-- 4/23 16:00수정  -->
		 			<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }"> 
		 			<input type="hidden" name="reviewNo" value="${review.reviewNo }">
		 			<!-- 4/22 추가해볼것!! 4/23 주석처리! -->
<%-- 		 			<input type="hidden" name="reviewTitle" value="${review.reviewTitle }"> --%>
<%-- 		 			<input type="hidden" name="reviewContent" value="${review.reviewContent }"> --%>
		 			<!-- 4/23 추가 주석처리 -->
<%-- 		 			<input type="hidden" name="reviewCount" value="${review.reviewCount }"> --%>
<%-- 		 			<input type="hidden" name="reviewYn" value="${review.reviewYn }"> --%>
		 			<!-- 4/23 11:28 등록 jsp 스크립트? 추가! -->
		 			<!-- 안먹혀서 다시 지움! -->
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
						<!-- hidden값도 적어줘야함?4/21 12:38분 수정하기 전체 종료!!! -->
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
			<script>
				  tinymce.init({
				    selector: 'textarea',
				    plugins: [
				      // Core editing features
				      'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
				      // Your account includes a free trial of TinyMCE premium features
				      // Try the most popular premium features until May 1, 2025:
				      'checklist', 'mediaembed', 'casechange', 'formatpainter', 'pageembed', 'a11ychecker', 'tinymcespellchecker', 'permanentpen', 'powerpaste', 'advtable', 'advcode', 'editimage', 'advtemplate', 'ai', 'mentions', 'tinycomments', 'tableofcontents', 'footnotes', 'mergetags', 'autocorrect', 'typography', 'inlinecss', 'markdown','importword', 'exportword', 'exportpdf'
				    ],
				    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
				    tinycomments_mode: 'embedded',
				    tinycomments_author: 'Author name',
				    mergetags_list: [
				      { value: 'First.Name', title: 'First Name' },
				      { value: 'Email', title: 'Email' },
				    ],
				    ai_request: (request, respondWith) => respondWith.string(() => Promise.reject('See docs to implement AI Assistant')),
				  });
			</script>
		</div>
	</div>
</body>
</html>