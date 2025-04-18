<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <title>공지사항 - 상세</title>
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <link rel="stylesheet" href="../resources/css/notice/detail.css">
</head>
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<body>
    <div class="background-image">
    	<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>

    <jsp:include page="/WEB-INF/views/include/header.jsp" />

    <main class="main-container">
        <div class="notice-write-container">
            <div class="write-title-bar">
              <span>공지사항</span>
            </div>
              <div class="form-row-title">
                ${notice.noticeTitle }
              </div>
              <div class="form-row-content">
              	<img alt="공지사항 사진" src="${notice.noticeFilePath}"> <br>
                ${notice.noticeContent }
              </div>
              <div class="form-row-btn">
                <button class="btn-list-btn" onclick="location.href='/notice/list';">목록으로</button>
                <c:if test="${sessionScope.member.managerYn eq 'Y' }">
	                <button class="btn-submit-btn" onclick="updateNotice();">수정하기</button>
	                <button class="btn-delete-btn" onclick="deleteNotice();">삭제하기</button>
                </c:if>
              </div>
   		</div>
    </main>
    <script>
    	const deleteNotice = () => {
    		if(confirm("정말 삭제하시겠습니까?")){
    			location.href = "/notice/delete?noticeNo="+"${notice.noticeNo}";
    		}
    	}
    	const updateNotice = () => {
    		location.href = "/notice/update?noticeNo=" + "${notice.noticeNo}";
    	}
	</script>
</body>
</html>