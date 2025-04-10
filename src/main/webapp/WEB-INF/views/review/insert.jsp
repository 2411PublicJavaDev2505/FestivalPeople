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
			<div class="reviewwinsert-h3">
				<h3>여행후기 등록</h3>
			</div>
			<main>
		 		<form action="" method="" enctype="multipart/form-data"> 
					<div class="제목(수정)">
						제목 <input type="text" name="" size="50"> <br>
					</div>
					<div class="내용(수정)">
						내용 <textarea rows="4" cols="50" name=""></textarea> <br>
					</div>
					사진첨부1 <input type="file" name="images"><br>
					사진첨부2 <input type="file" name="images"><br>
					사진첨부3 <input type="file" name="images"><br>
					<div class="reviewinsert-btn">
						<button type="submit" id="submitbtn">등록</button>
						<button type="submit" id="submitbtn-c">작성취소</button> 
					</div>
		 		</form> 
			</main>
<%-- 			<jsp:include page="../include/footer.jsp"/> --%>
		</div>
	</div>
</body>
</html>