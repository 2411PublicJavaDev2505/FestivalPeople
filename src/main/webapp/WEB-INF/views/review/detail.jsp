<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- 4/25일 아래코드 추가! -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
		<title>후기글 상세조회</title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/review/detail.css">
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	<body>
		<main class="main-container">
		<div id="container">
			<jsp:include page="../include/header.jsp"/>
				<div class="reviewdetail-main">
					<div class="review-h3">
						<h3>여행후기</h3>
					</div>
					<section>
							<div class="review-report-btn">
								🚨<button class="report-btn" onclick="reportReview('${review.reviewNo}');">신고하기</button>
							</div>
						<div class="reviewtitle-h1">
							<!-- 리뷰제목 -->
							<!-- 4/25 12:36 review-info-main 여기안에 넣어줬음! -->
							<h1>${review.reviewTitle }</h1>
<!-- 							<input type="hidden" id="reviewNo" value="${review.reviewNo }"> -->
							<div class="review-info-main">
								<div class="review-info">
									<p><span>${review.memberName}</span></p>
								</div>
								<div class="review-info">
									<p><span>|</span>${review.reviewWriteTime }</p>	
								</div>
								<div class="review-info">
									<p><span>|조회수</span>${review.reviewCount }</p>	
								</div>
							</div>
						</div>
							<!-- 밑에는 내용! -->
						<div class="review-all-content">
							<div class="review-content">
								<p><div>${review.reviewContent }</div></p>
							</div>
							<!-- 사진내용 출력?!4/18 12:22뜨는지안뜨는지확인 확인되어서 커밋하고 지우기! -->
							<div class="review-imagefile">
								<c:if test="${review.reviewFilePath1 ne null }">
									<img alt="review-img" src="${review.reviewFilePath1 }">
								</c:if>
								<c:if test="${review.reviewFilePath2 ne null }">
									<img alt="review-img" src="${review.reviewFilePath2 }">
								</c:if>
								<c:if test="${review.reviewFilePath3 ne null }">
									<img alt="review-img" src="${review.reviewFilePath3 }">
								</c:if>
							</div> 
						</div>
						<!-- 4/18 15:05분 수정하기버튼 추가! 요구사항에 작성자가쓴글만 삭제하는 기능은??? -->
						<!-- 4/18 16:04삭제하기 버튼추가! -->
						<!-- 4/19 12:05 목록으로 버튼 추가! -->
						
							<div class="review-update-all-btn">
								<button class="back-list-btn" onclick="location.href='/review/list';">목록으로</button>
								<c:if test="${sessionScope.member.memberYn ne null && sessionScope.member.memberNo eq review.memberNo}" >
									<button class="review-update-btn" onclick="reviewupdate(${review.reviewNo});" id="review-update-btn">수정하기</button>
									<button class="review-delete-btn" onclick="reviewDelete();">삭제하기</button> 
								</c:if>
							</div>
						</section>
					<input type="hidden" value="${review.reviewNo }" id="reviewNo">
					<input type="hidden" value="${sessionScope.member.memberNo}" id="memberNo">
					<!-- 댓글 -->
					<div class="review-comment-list-area">
						<div class="review-comment-write-area">
							<div class="comentwrite-p">
							<!-- 댓글쓰기 text아래로 내리는 방법은?? -->
								<p>댓글쓰기</p><br>
							</div>
							<textarea row="4" cols="82" id="commentContent" placeholder="댓글내용을 입력해주세요"></textarea>
							<div class="addComment-btn">
								<!-- ***여기 id값 건들지말것!**** -->
								<button id="addComment">댓글등록</button>
							</div>	
						</div>
						<!--  댓글 목록!내가 가지고 있는것으로 일단수정! -->
						<div class="comment-list-area">
							<ul id="commentList">
								<c:forEach items="${review.commentList }" var="comment">
									<li class="comment-row">
										<p>
											<span>닉네임</span>
											작성시간 : <span>${comment.commentTime }</span>
										</p>
											내용: <p>${comment.commentContent }</p>
											
											<div class="comment-btn-area">
											<button class="replyBtn">답글(삭제 예정)</button>
											<button class="deleteBtn" onclick="CommentDelete();">삭제</button>
											<button onclick="reportComment('${comment.commentNo}');">신고</button>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
			</div>
		</div>
	</main>
		<script>
			//리뷰삭제!!!4/27일 지울것!!
			
			const CommentDelete = () => {
				if(confirm("정말 삭제 하시겠습니까???")) {
					location.href ="/review/comment/delete?commentNo=${comment.commentNo}";
				}
			}
		
			//리뷰삭제
			const reportReview = (num) => {
				location.href = '/report/insert?target=rev&num=' + num;
			}
			const reportComment = (num) => {
				location.href = '/report/insert?target=com&num=' + num;
			}
		
			
			const reviewDelete = () => {
 				if(confirm("정말 삭제하시겠습니까??")) {
 					location.href = "/review/delete?reviewNo=${review.reviewNo}";
 				}
 			}
		
		
			const reviewupdate = (reviewNo) => {
				location.href ="/review/update?reviewNo="+reviewNo;
			}
			
			const deleteComment = (commentNo) => {
				$.ajax({
					url: "/review/comment/delete",
					data: {
						"commentNo" : commentNo,
					},
					type: "GET",
					success : function(data) {
						if(data != '0')
							alert("댓글 삭제 성공!");
						getCommentList();
					},
					fail : function() {
						alert("통신 오류!!");
					}
				});
			}
		
			
			const reviewNo = "${review.reviewNo}";
		
			function getCommentList() {
				fetch("/review/comment/list?reviewNo=${review.reviewNo}")
				.then(response => response.json())
				.then(cList => {
					const cListTag = document.querySelector("#commentList");
					cListTag.innerHTML ="";
					for(let comment of cList) {
						
						const commentRow = document.createElement("li"); //** <li></li> 태그를 만든다!!!
						commentRow.classList.add("comment-row"); //**<li class="reviewcomment-row"></li>
						
						
						const commentPtag = document.createElement("p"); 
						commentPtag.classList.add("comment-writer");
						
						
						const nickNameTag = document.createElement("span");
						nickNameTag.innerText = comment.nickname;
						
						
						const writeDateTag = document.createElement("span");
						writeDateTag.innerText = comment.commentTime;
						
						
						const contentTag = document.createElement("p");
						contentTag.innerText = comment.commentContent;
						
						const buttonArea = document.createElement("div");
						
						if( '${sessionScope.member.memberNo}'.trim() != ''){
							buttonArea.classList.add("comment-btn-area");
							const replyBtn = document.createElement("button");
							replyBtn.innerText ="답글";
							if(comment.memberNo == '${sessionScope.member.memberNo}'){
								const deleteBtn = document.createElement("button");
								deleteBtn.innerText = "삭제";
								deleteBtn.onclick= function() {
									deleteComment(comment.commentNo);
								};
								buttonArea.append(replyBtn, deleteBtn);
							}else{
								buttonArea.append(replyBtn);
							}
						}
					
						commentPtag.append(nickNameTag,writeDateTag);
						commentRow.append(commentPtag,contentTag,buttonArea);
						
						cListTag.append(commentRow);
					}
				})
				.catch(error => alert("Error :"  +error))
			}
		
			
			document.querySelector("#addComment").addEventListener("click", function() {
				
				if('${sessionScope.member.memberNo}'.trim() == ''){
					alert("로그인 해주세요!");
					return 0;
				}else if(document.querySelector("#commentContent").value.trim() == ''){
					alert("내용을 입력해주세요!");
					return 0;
				}
				
				const commentContent = document.querySelector("#commentContent").value;
				const reviewNo = document.querySelector("#reviewNo").value;
				const memberNo = document.querySelector("#memberNo").value;
				
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
						getCommentList();
					}else {
						alert("댓글이 등록되지 않았습니다.");
						getCommentList();
					}
				})
				.catch(error => alert("Error :" , error));
				});
			getCommentList();
		</script>
	</body>
</html>