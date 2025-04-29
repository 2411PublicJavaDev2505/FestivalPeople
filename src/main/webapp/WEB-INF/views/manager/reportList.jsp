<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>신고 내역 확인 페이지 입니다</title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/report/list.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">	
	</head>
	<body>
		<!-- 바탕화면 -->
		<div class="background-image">
			<img src="../resources/img/manager/manager-background.jpg" alt="바탕화면">
	    </div>
		<div id="container">
			<jsp:include page="/WEB-INF/views/include/header.jsp" />
			<main>
				<div class="manager-total-container">
					<div class="manager-select-search">
						<div class="left-select-area">
							<a href="/manager/mypage"><button>회원관리</button></a>
							<a href="/manager/report"><button>신고관리</button></a>
							<button id="refreshFestivalBtn">축제 최신화</button>
						</div>
						<div class="right-search-area">
			                <form class="search-form" action="/manager/rSearch" method="get">
			                    <select name="searchCondition">
			                        <option value="all">전체</option>
			                        <option value="chatroom">채팅방</option>
			                        <option value="review">후기</option>
			                        <option value="comment">댓글</option>
			                    </select>
			                    <input type="text" placeholder="신고 내용으로 검색" name="searchKeyword" value="${param.searchKeyword }">
			                    <button class="search-btn" type="submit">⌕</button>
			                </form>
						</div>
					</div>
					<div class="report-list-table">
						<table class ="total-table">
							<tr class ="table-title">
								<th class="report-no">번호</th>
								<th class="report-division">구분</th>
								<th class="report-content">신고내용</th>
								<th class="report-target">신고대상</th>
								<th class="reporter">신고자</th>
							</tr>
							<c:forEach items="${rList }" var="report" varStatus="i">
								<tr class ="report-Information" onclick="reportDetail('${report.reportNo}');">
									<td class="report-no">${report.reportNo}</td>
									<c:if test="${report.reportObject eq 'CHATROOM' }">
										<td class="report-division">채팅방</td>
									</c:if>
									<c:if test="${report.reportObject eq 'REPORT' }">
										<td class="report-division">후기</td>
									</c:if>
									<c:if test="${report.reportObject eq 'REPORT_COMMENT' }">
										<td class="report-division">댓글</td>
									</c:if>
									<td class="report-content">${report.reportContent }</td>
									<c:if test="${report.chatRoomNo ne '0' }">
										<td class="report-target">${report.chatRoomNo }</td>
									</c:if>
									<c:if test="${report.commentNo ne '0' }">
										<td class="report-target">${report.commentNo }</td>
									</c:if>
									<c:if test="${report.reviewNo ne '0' }">
										<td class="report-target">${report.reviewNo }</td>
									</c:if>
									<td class="reporter">${report.memberNo }</td>
								</tr>
							</c:forEach>
						</table>
			            <div class="pagination">
							<a href="/manager/report?currentPage=1">◁◁</a>
							<c:if test= "${pageInfo.startNavi ne 1}">
								<a href="/manager/report?currentPage=${pageInfo.startNavi-1}" class="prev">◀</a>
							</c:if>	
							<c:forEach begin="${pageInfo.startNavi}" end="${pageInfo.endNavi}" var="p">
								<a href="/manager/report?currentPage=${p}">${p}</a>
							</c:forEach>					
							<c:if test="${pageInfo.endNavi ne pageInfo.maxPage}">
								<a href="/manager/report?currentPage=${pageInfo.endNavi+1}" class="next">▶</a>
							</c:if>    
				           	<a href="/manager/report?currentPage=${pageInfo.maxPage}"> ▷▷ </a>
			            </div>
					</div>
				</div>	
			</main>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
		<script type="text/javascript">
			function reportDetail(reportNo) {
				location.href="/manager/rdetail?reportNo="+reportNo;
			}
			
			
			
			document.getElementById("refreshFestivalBtn").addEventListener("click",function(){
				fetch("/festival/insert",{
					method: "GET"
				})
				.then(response => response.text())
				.then(data =>{
					customAlert("축제 정보 최신화가 되었습니다");
				})
				.catch(error=>{
					customAlert("최신화 중 오류가 발생 했습니다");
					console.error(error);
				});
			});
			
		</script>	
	</body>
</html>