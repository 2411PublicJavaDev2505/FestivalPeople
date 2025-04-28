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
								<button>신고관리</button>
							</div>
							<div class="right-search-area">
				                <form class="search-form">
				                    <select>
				                        <option value="all">전체</option>
				                        <option value="memberId">회원아이디</option>
				                        <option value="name">회원이름</option>
				                        <option value="nickName">닉네임</option>
				                        <option value="email">이메일</option>
				                        <option value="reportSort">신고누적순</option>
				                    </select>
				                    <input type="text" placeholder="검색" id="">
				                    <button class="search-btn">⌕</button>
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
										<tr class ="report-Information">
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
											<td class="report-target">신고대상?</td>
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
	</body>
</html>