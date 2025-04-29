<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
		<title>후기글 상세조회</title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/review/detail.css">
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<script src="https://cdn.tiny.cloud/1/h2z941nkcufiei057mdhexxykqh6vtiwziq0rhb7ahlx1hua/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	<body>
	 <!-- 바탕화면 -->
	<div class="background-image">
    	 <img src="../resources/img/review/review-background.jpg" alt="바탕화면">
    </div>
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
							<h1>${review.reviewTitle }</h1>
							<div class="review-info-main">
								<div class="review-info">
									<p><span>${review.memberName} |</span></p>
								</div>
								<div class="review-info">
									<p><span> &ensp;</span>${review.reviewWriteTime } |</p>	
								</div>
								<div class="review-info">
									<p><span>&ensp;조회수</span>${review.reviewCount }</p>	
								</div>
								<!-- &ensp; 공백처리코드!! -->
							</div>
						</div>
							<!-- 밑에는 내용! -->
						<div class="review-all-content">
							<div class="review-content">
								<p><div>${review.reviewContent }</div></p>
							</div>
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
							<!--  -->
								<p>댓글쓰기</p><br>
							</div>
							<!-- 4/29text상자 초기화해야하나 몰라 클릭하면 사라지는구현만... -->
							<div class="textarea">
								<textarea rows="2" cols="82" id="commentContent" onclick=this.value=""; placeholder="댓글내용을 입력해주세요"></textarea>
							</div>
							<!-- 댓글내용작성후 초기화하는 코드 작성... 안되면 삭제! -->
							<div class="addComment-btn">
								<button id="addComment" >댓글등록</button>
							</div>	
						</div>
						<!-- 댓글 영역! -->
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
			//textarea 클릭시 초기화...	
			document.getElementById("commentContent").value='';
		
			//댓글삭제	?? 
			const CommentDelete = () => {
				if(confirm("정말 삭제 하시겠습니까???")) {
					location.href ="/review/comment/delete?commentNo=${comment.commentNo}";
				}
			}
		
			//리뷰삭제(신고)
			const reportReview = (num) => {
				location.href = '/report/insert?target=rev&num=' + num;
			}
			const reportComment = (num) => {
				location.href = '/report/insert?target=com&num=' + num;
			}
		
			//게시글삭제
			const reviewDelete = () => {
 				if(confirm("정말 삭제하시겠습니까??")) {
 					location.href = "/review/delete?reviewNo=${review.reviewNo}";
 				}
 			}
		
			//게시글수정
			const reviewupdate = (reviewNo) => {
				location.href ="/review/update?reviewNo="+reviewNo;
			}
			//댓글삭제
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
		
			//댓글 리스트
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
								const reportBtn = document.createElement("button");
								reportBtn.innerText = "신고";
								reportBtn.onclick = function() {
									reportComment(comment.commentNo);
								}
								buttonArea.append(replyBtn, reportBtn);
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