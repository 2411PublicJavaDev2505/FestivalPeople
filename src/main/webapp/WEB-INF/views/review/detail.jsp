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
				<input type="hidden" value="${review.reviewNo }" id="reviewNo">
<%-- 				<input type="hidden" value="${comment.commentNo }" id="commentNo"> --%>
				<input type="hidden" value="${sessionScope.member.memberNo}" id="memberNo">
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
									<span>${comment.commentNo }</span>
<!-- 									<span>여기부터생각!멤버번호</span> -->
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
// 				const reviewNo = "${review.reviewNo}";
				
// 				function getCommentList() {
// 					fetch("/review/comment/list?reviewNo="+reviewNo)
// 					.then(response => response.json())
//  					.then(cList => console.log(cList))
// 					.catch(error => alert("Error :"  +error))
// 				}
				
				//****등록하면 에러페이지 뜸 확인필요**** commentNo값 가져오지 못함!!!!!
				document.querySelector("#addComment").addEventListener("click", function() {
						const commentContent = document.querySelector("#commentContent").value;
						const reviewNo = document.querySelector("#reviewNo").value;
						const memberNo = document.querySelector("#memberNo").value;
						
// 						const commentNo = document.querySelector("#commentNo").value;
						const data = {"reviewNo" : reviewNo, "commentContent": commentContent, "memberNo" : memberNo};
						//console.log(data)
						fetch("/review/comment/insert", {
							method:"POST"
 							,headers: {"Content-type": "application/json"}
						, body: JSON.stringify(data)})
						.then(response => response.text())
						.then(result => {
							if(result > 0 ){
								alert("댓글이 등록되었습니다");
 								getCommentList()
						}else {
							alert("댓글 등록이 완료되지 않았습니다");
						}
					})
					.catch(error => alert("Error :" , error));
					});
				</script>
		</div>
	</body>
</html>