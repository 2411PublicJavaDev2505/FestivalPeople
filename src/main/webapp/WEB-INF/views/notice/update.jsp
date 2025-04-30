<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <link rel="stylesheet" href="../resources/css/notice/update.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>Festival People</title>
</head>
	<!-- 에디터 API -->
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<body>
	<!-- 바탕화면 -->
    <div class="background-image">
    	<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>
	<!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
	<!-- 메인 컨테이너 -->
    <main class="main-container">
        <div class="notice-write-container">
            <div class="write-title-bar">
            	<span>공지사항 수정</span>
            </div>
            <form class="write-form" enctype="multipart/form-data" action="/notice/update" method="post">
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            	<input type="hidden" value="${notice.noticeNo }" name="noticeNo">
	            <div class="form-row">
	            	<input type="text" id="title" name="noticeTitle" class="write-input" placeholder="제목" value="${notice.noticeTitle }" />
	            </div>
	            <div class="form-row">
	            	<img alt="공지사항 파일" src="${notice.noticeFilePath }" id="notice-file">
					<textarea id="tiny" name="noticeContent" class="write-textarea" placeholder="내용">
						${notice.noticeContent }
					</textarea>
	            </div>
	            <div class="form-row file-row">
					<input type="file" id="file" name="file" onchange="changeFile();"/>
	            </div>
	            <div class="form-row-btn">
					<button type="submit" class="btn-submit-btn">수정</button>
					<button type="button" class="btn-cancel-btn" onclick="location.href='/notice/list';">수정취소</button>
	            </div>
          	</form>
   		</div>
    </main>
    <!-- 스크립트 -->
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
	 	const changeFile = () => {
	 		let formData = new FormData();
		    let fileInput = $("#file")[0];
		    if (fileInput.files.length > 0) {
		        formData.append("file", fileInput.files[0]);
		        $.ajax({
		        	url: "/notice/updatefile",
		        	data: formData,
		        	type: "POST",
		        	contentType: false,
		            processData: false, 
		        	success: function(data) {
		        		document.querySelector("#notice-file").src = data;
		        	},
		        	error: function() {
		        		alert("통신 오류!!");
		        	}
		        });
		    }
	 	}
	</script>
</body>
</html>