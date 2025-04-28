<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신고 상세</title>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp" />
		<main>
			<div class="report-detail-top">
				<button onclick="location.href='/manager/mypage';">회원관리</button>
				<button onclick="location.href='/manager/report';">신고관리</button>
			</div>
			<div class="report-detail-btn">
				<button onclick="deleteReport();">반려</button>
				<button onclick="reportAccept();">삭제</button>
			</div>
			<div class="report-detail-content">
				신고 대상 : 
					<c:if test="${report.reportObject eq 'CHATROOM' }">
						채팅방 번호 : ${report.chatRoomNo } 
					</c:if> 
					<c:if test="${report.reportObject eq 'REPORT' }">
						후기글 번호 : ${report.reviewNo } 
					</c:if> 
					<c:if test="${report.reportObject eq 'REPORT_COMMENT' }">
						댓글 번호 : ${report.commentNo } 
					</c:if>
				<br>
				${report.reportObjectTitle } <br>
				신고 사유 : ${report.reportContent }<br>
			</div>
		</main>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script type="text/javascript">
		const deleteReport = () => {
			if(confirm("신고를 반려하시겠습니까?")){
				$.ajax({
					url: "/manager/delre",
					data : {
						"reportNo" : "${report.reportNo}",
					},
					type : "GET",
					success : function(data) {
						if(data != '0'){
							alert("반려처리가 완료되었습니다.");
							location.href="/manager/report";
						}else {
							alert("반려처리가 완료되지 않았습니다.");
						}
					},
					error : function() {
						alert("통신오류!!");
					}
				});
			}
		}
		const reportAccept = () => {
			$.ajax({
				url: "/manager/accept",
				data : {
					"reportObject" : "${report.reportObject}",
					"chatRoomNo" : "${report.chatRoomNo}",
					"commentNo" : "${report.commentNo}",
					"reviewNo" : "${report.reviewNo}",
					"reportNo" : "${report.reportNo}"
				},
				type: "POST",
				success : function(data) {
					if(data != '0'){
						alert("신고처리가 완료되었습니다.");
						location.href="/manager/mypage";
					}else{
						alert("신고처리가 완료되지 않았습니다.");
					}
				},
				error : function() {
					alert("통신오류!!");
				}
			});
		}
	</script>
</body>
</html>