<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<link rel="stylesheet" href="../resources/css/review/update.css">
	<title>후기게시판 수정</title>
</head>
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<body>
	<!-- 바탕화면 -->
	<div class="background-image">
		<img src="../resources/img/review/review-insert-background.jpg" alt="바탕화면">
   	</div>
	<div id="container">
	<jsp:include page="../include/header.jsp"/>
		<div class="reviewinsert-main">
			<div class="reviewinsert-h3">
				<h3>여행후기 수정</h3>
			</div>
			<main>
		 		<form action="/review/update" method="post" enctype="multipart/form-data">
		 			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 			<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }"> 
		 			<input type="hidden" name="reviewNo" value="${review.reviewNo }">
		 			<div class="review-title">
						<input type="text" name="reviewTitle" maxlength="30" value="${review.reviewTitle }" size="80">
					</div>
					<div class="review-content">
						<textarea rows="5" cols="82" name="reviewContent">${review.reviewContent }</textarea>
					</div>
					<div class="review-attach">
						<div class="review-file-input">
							<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
							<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
							<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
						</div>
						<div class="reviewupdate-btn">
							<button type="submit"  id="submitbtn">수정</button>
							<button type="submit" id="submitbtn-c">목록으로</button> 
						</div>
					</div>
		 		</form> 
			</main>
			
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
		<!-- 푸터 -->
    		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</body>
</html>