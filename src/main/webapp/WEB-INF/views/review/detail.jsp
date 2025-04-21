<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/review/detail.css">
		<title>후기글 상세조회</title>
	</head>
	<body>
		<div id="container">
			<jsp:include page="../include/header.jsp"/>
				<div class="reviewdetail-main">
					<div class="review-h3">
						<h3>여행후기</h3>
					</div>
					<main>
					<section>
							<div class="review-report-btn">
								<button>신고하기</button>
							</div>
						<div class="reviewtitle-h1">
							<!-- 리뷰제목 -->
							<h1>${review.reviewTitle }</h1>
<!-- 							<input type="hidden" id="reviewNo" value="${review.reviewNo }"> -->
						</div>
						<div class="review-info-main">
							<div class="review-info">
								<!-- 작성자 안뜸현상! -->
								<p><span>작성자|</span>${review.memberName}</p>
							</div>
							<div class="review-info">
								<p><span>|</span>${review.reviewWriteTime }</p>	
							</div>
							<div class="review-info">
								<p><span>|조회수|</span>${review.reviewCount }</p>	
							</div>
						</div>
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
						<!-- 4/18 15:05분 수정하기버튼 추가! 요구사항에 작성자가쓴글만 삭제하는 기능은??? -->
						<!-- 4/18 16:04삭제하기 버튼추가! -->
						<!-- 4/19 12:05 목록으로 버튼 추가! -->
						<div class="review-update-btn">
							<div class="">
								<button class="back-list-btn" onclick="location.href='/review/list';">목록으로</button>
							</div>
							<c:if test="${sessionScope.member.memberNo ne null && sessionScope.member.memberNo ne '' }">
<!-- 								<button onclick="reviewupdate();" id="review-update-btn">수정하기</button> -->
								<!-- 4/21 코드수정하면서 위에것은주석처리함 -->
								<button onclick="reviewupdate(${review.reviewNo});" id="review-update-btn">수정하기</button>
							</c:if>
						</div>
						<div class="review-delete-btn">
							<c:if test="${sessionScope.member.memberNo ne null && sessionScope.member.memberNo ne '' }">
								<button onclick="reviewDelete();">삭제하기</button>
							</c:if>
						</div>
						
					</section>
					<input type="hidden" value="${review.reviewNo }" id="reviewNo">
					<input type="hidden" value="${sessionScope.member.memberNo}" id="memberNo">
					<!-- 댓글 -->
					<div class="review-comment-list-area">
						<div class="review-comment-write-area">
							<div class="comentwrite-p">
								<p>댓글쓰기</p><br>
							</div>
							<textarea id="commentContent" placeholder="댓글내용을 입력해주세요"></textarea>
							<div>
								<button id="addComment">댓글등록</button>
							</div>	
						</div>
						<div class="comment-list-area">
							<ul id="reviewcommentlist">
								<c:forEach items="${review.commentList }" var="comment">
									<li class="reviewcomment-row">
										<p>
											내용:<span>${comment.commentContent }</span>
											작성시간:<span>${comment.commentTime }</span>
										</p>
										<div class="comment-btn-area">
											<button class="replyBtn">답글</button>
											<button class="modifyBtn">수정</button>
											<button class="deleteBtn">삭제</button>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</main>
			</div>
		</div>
		<script>
			//이것도 안먹힘...4/18 17:48종료!!
			const reviewDelete = () => {
 				if(confirm("정말 삭제하시겠습니까??")) {
 					location.href = "/review/delete?reviewNo=${review.reviewNo}";
 				}
 			}
		
			
			//4/21 코드수정함!
// 			const reviewupdate = () => {
// 				location.href ="/review/update";
// 			}
			const reviewupdate = (reviewNo) => {
				location.href ="/review/update?reviewNo="+reviewNo;
			}
		
			
			const reviewNo = "${review.reviewNo}";
		
			function getCommentList() {
				fetch("/review/comment/list?reviewNo="+reviewNo)
				.then(response => response.json())
				.then(cList => {
					//#commentList 확인필요!
					const cListTag = document.querySelector("#commentList");
					cListTag.innerHTML ="";
					for(let comment of cList) {
						//li태그
						const commentRow = document.createElement("li");
						commentRow.classList.add("reviewcomment-row");
						
						//p태그(출력할 화면정해야함!) (코드확인필요)
						const commentPtag = document.createElement("p");
						//comment-writer 인지 어디다 적을지 정해야함(작성자,아이디,닉네임이냐)comment-writer"?
						commentPtag.classList.add("comment-writer");
						
						//작성자,아이디,닉네임(코드확인필요)
						const memberIdTag = document.createElement("span");
						memberIdTag.innerText ="아이디";
						
						//작성일(코드확인필요)
						const commentTimeTag = document.createElement("span");
						commentTimeTag.innerText = comment.commentCreateDate;
						
						//내용 
						const contentTag = document.createElement("p");
						contentTag.innerText = document.commentContent;
						
						//버튼영역
						const buttonArea = document.createElement("div");
						buttonArea.classList.add("comment-btn-area");
						const replyBtn = document.createElement("button");
						replyBtn.innerText ="답글";
						const modifyBtn = document.createElement("button");
						modifyBtn.innerText = "수정";
						const deleteBtn = document.createElement("button");
						deleteBtn.innerText = "삭제";
						buttonArea.append(replyBtn, modifyBtn, deleteBtn);
						//list 붙여넣기
						commentPtag.append(memberIdTag,commentTimeTag);
						commentRow.append(commentPtag,contentTag,buttonArea);
						// 댓글 목록(ul) 에 댓글(li) 추가?!
						cListTag.append(reviewcomment-row);
					}
				})
				.catch(error => alert("Error :"  +error))
			}
		
			
			document.querySelector("#addComment").addEventListener("click", function() {
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
						alert("댓글 등록이 완료되지 않았습니다");
					}
				})
				.catch(error => alert("Error :" , error));
				});
		</script>
	</body>
</html>