<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>후기글 상세조회</title>
	</head>
	<body>
		<section>
			<h1>후기글 - 상세조회</h1>
			${review }
		</section>
		<!-- 댓글 -->
		<div class="review-comment-list-area">
			<ul id="reviewcommentlist">
				<li class="reviewcomment-row">
					<p>댓글쓰기</p><br>
					<input type="text" name="" size="80">
					<div>
						<button>댓글등록</button>
					</div>
					<p>
						<span>여기부터생각!멤버번호</span>
						<span>답글시간날짜</span>
					</p>
					<div>
						<button>답글</button>
						<button>수정</button>
						<button>삭제</button>
					</div>
				</li>
			</ul>
		</div>
	</body>
</html>