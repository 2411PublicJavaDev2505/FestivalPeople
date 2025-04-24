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
		 			<div class="review-title">
					<!-- 4/21수정 만들면서 아래코드 추가 작성  -->
						제목 <input type="text" name="reviewTitle" value="${review.reviewTitle }" size="80">
					</div>
					<!-- 4/23 20:33분 코드 추가! 안되면 원복하기! -->
					<div class="review-content">
						<div><span>내용 </span></div>
						<textarea rows="5" cols="82" name="reviewContent">
						<div class="review-imagefile">
							<c:if test="${review.reviewFilePath1 ne null }">
								<img alt="review-img" src="${review.reviewFilePath1 }" id="review-file">
							</c:if>
							<c:if test="${review.reviewFilePath2 ne null }">
								<img alt="review-img" src="${review.reviewFilePath2 }" id="review-file">
							</c:if>
							<c:if test="${review.reviewFilePath3 ne null }">
								<img alt="review-img" src="${review.reviewFilePath3 }" id="review-file">
							</c:if>
						${review.reviewContent }</textarea>
					</div>
					
					<div class="review-attach">
						<!-- div풀기4/21 -->
						<!-- 첨부파일버튼 다시 옮기기!첨부파일 코드 추가해줘야함! -->
						<!-- 4/23 이미지수정파일코드작성 20:06 -->
						<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
						<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
						<input type="file"  id="images" name ="images" onchange="changeFile();"> <br> 
					
<!--  						<input type="file" name ="images"> <br>  -->
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
				  //여기부터 4/23일20:05분 코드추가
				  const changeFile() = () => {
					  let formData = new FormData();
					  let fileInput = $("#images")[0]);
					  if (fileInput.files.length > 0) {
						  $.ajax({
							  url: "/review/updatefile",
							  data: formData,
							  type: "POST",
							  contentType: false,
					          processData: false,
					          success: function(data) {
					        	  document.querySelector("#review-file").src = data;
					          },
					          error:function() {
					        	  alert("통신오류");
					          }
						  });
						  
					  }
				  }
			</script>
		</div>
	</div>
</body>
</html>