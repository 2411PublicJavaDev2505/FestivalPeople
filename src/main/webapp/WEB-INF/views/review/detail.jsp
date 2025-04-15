<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/review/insert.css">
		<title>후기글 상세조회</title>
	</head>
	<body>
		<div id="container">
			<jsp:include page="../include/header.jsp"/>
			<main>
				<section>
					<div class="review-h1">
						<h1>여행후기</h1>
					</div>
					<div class="review-report-btn">
						<button>신고하기</button>
					</div>
					<div class="reviewtitle-h1">
						<!-- 리뷰제목 -->
						<h1>${review.reviewTitle }</h1>
						<input type="hidden" id="reviewNo" value="${review.reviewNo }">
					</div>
					<div>
						<p><span>아이디|</span></p>
						<p><span>|</span>${review.reviewWriteTime }</p>	
						<p><span>조회수|</span>${review.reviewCount }</p>	
					</div>
					<div>
						<p><div>${review.reviewContent }</div></p>
					</div>
					
				</section>
				<!-- 댓글 -->
				<div class="review-comment-list-area">
							<div class="review-comment-write-area">
								<p>댓글쓰기</p><br>
		<!-- 						<input type="text" name="" size="80"> -->
								<textarea id="commentContent" placeholder="댓글내용을 입력해주세요"></textarea>
								<div>
									<button id="addComment">댓글등록</button>
								</div>	
							</div>
						<ul id="reviewcommentlist">
						<c:forEach items="${review.commentList }" var="comment">
							<li class="reviewcomment-row">
								<p>
									<span>여기부터생각!멤버번호</span>
									<span>${comment.commentTime }</span>
								</p>
								<p>${comment.commentContent }</p>
								<div>
									<button>답글</button>
									<button>수정</button>
									<button>삭제</button>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</main>
				<script>
					document.querySelector("#commentContent").addEventListener("click", function() {
						alert("test");
					});
				</script>
		</div>
	</body>
</html>