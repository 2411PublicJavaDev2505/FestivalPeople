<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/review/insert.css">
	<title>후기게시판 등록</title>
</head>
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<body>
		<jsp:include page="../include/header.jsp"/>
		<!-- 바탕화면 -->
		<div class="background-image">
			<img src="../resources/img/review/review-insert-background.jpg" alt="바탕화면">
    	</div>
			<main class="main-container">
				<div class="reviewinsert-main">
					<div class="reviewinsert-h3">
						<h3>여행후기 등록</h3>
					</div>
				 		<form action="/review/insert" method="post" enctype="multipart/form-data">
								<!-- 원래자리로 되돌려주기!!4/18 11:11 -->
								<!--  -->
								<input type="file" name ="images"> <br>
								<input type="file" name ="images"> <br>
								<input type="file" name ="images"> <br>
				 			<input type="hidden" name="memberNo"  value="${sessionScope.member.memberNo }"> 
							<div class="review-title">
							<!-- name값 넣어줘야함! -->
								<input type="text" id="title" name="reviewTitle" class="write-input" placeholder="제목" />
							</div>
							<div class="review-content">
								<textarea id="tiny" name="reviewContent" class="write-textarea" placeholder="내용"></textarea>
							</div>
							
							<div class="review-attach">
								<!-- div풀기4/18 11:00 -->
								<!-- 첨부파일버튼 다시 옮기기! -->
								<!-- 되돌리고 css position: relative 주석처리-->
								<!-- 되돌렸어도 등록하면 상세페이지 이미지 출력??!되는 현상! -->
								<!-- position: relative 지워도 파일선택 안됨현상...다시 되돌려줌!! 
								<!--원인은??-->
		<!--  						<input type="file" name ="images"> <br>   -->
		<!--  						<input type="file" name ="images"> <br>   -->
		<!--   						<input type="file" name ="images"> <br>   -->
							</div>
							<div class="reviewinsert-btn">
									<button type="submit" id="submitbtn">등록</button>
									<button type="submit" id="submitbtn-c">작성취소</button> 
							</div>
				 		</form> 
					</div>
				</main>
<%--  			<jsp:include page="../include/footer.jsp"/> --%>
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
</body>
</html>