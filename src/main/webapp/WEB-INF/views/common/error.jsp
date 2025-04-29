<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<link rel="stylesheet" href="../resources/css/include/error.css">	
	<title>Error</title>
</head>
	<body>
		<jsp:include page="../include/header.jsp"/>
			<div class="background-image">
		    	 <img src="../resources/img/error.jpg" alt="에러사진">
	    	 </div>
				<div id="error-container">
					<h1>404 error</h1>
					<%-- <span class="error-content">발생한 예외 : ${e }</span> --%>
					<p>
						죄송합니다. 페이지를 찾을 수 없습니다.<br>
						존재하지 않는 주소를 입력하셨거나,<br>
						요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br>
					</p>
					<div id="btn-area">
						<a href="/"><button>메인페이지</button></a>
						<button onclick="history.back();">이전페이지</button>
					</div>
				</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</body>
</html>