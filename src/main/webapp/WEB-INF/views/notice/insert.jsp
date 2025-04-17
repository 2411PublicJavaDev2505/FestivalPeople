<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Festival People</title>
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <link rel="stylesheet" href="../resources/css/notice/insert.css">
</head>
<body>
    
    <div class="background-image">
    	<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>

    <jsp:include page="/WEB-INF/views/include/header.jsp" />

    <main class="main-container">
    	<form action="/notice/insert" method="post" enctype="multipart/form-data">
        <input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }">
        <div class="notice-write-container">
            <div class="write-title-bar">
              <span>공지사항 작성</span>
            </div>
              <div class="form-row">
                <input type="text" id="title" name="noticeTitle" class="write-input" placeholder="제목" />
              </div>
              <div class="form-row">
                <textarea id="content" name="content" class="write-textarea" placeholder="내용"></textarea>
              </div>
              <div class="form-row file-row">
                <input type="file" id="file" name="file" />
              </div>
              <div class="form-row btn-row">
                <button type="submit" class="btn submit-btn">등록</button>
                <button type="button" class="btn cancel-btn">작성취소</button>
              </div>
          </div>
          </form>
    </main>
</body>
</html>