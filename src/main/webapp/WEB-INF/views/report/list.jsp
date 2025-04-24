<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
										<c:forEach items="${mList }" var="member" varStatus="i">
											<tr class ="report-Information">
												<td class="report-no">${member.memberNo}</td>
												<td class="report-division">${member.memberId }</td>
												<td class="report-content">${member.memberId }</td>
												<td class="report-target">${member.memberId }</td>
												<td class="reporter">${member.memberId }</td>

											</tr>
										</c:forEach>
								</table>
					            <div class="pagination">
										<a href="/report/list?currentPage=1"> ◁◁ </a>
									<c:if test= "${startNavi ne 1 }">
										<a href="/report/list??currentPage=${startNavi-1 }" class="prev">◀</a>
									</c:if>	
									<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
										<a href="/report/list??currentPage=${p }">${p }</a>
									</c:forEach>					
									<c:if test="${endNavi ne maxPage }">
										<a href="/report/list??currentPage=${endNavi+1 }" class="next">▶</a>
									</c:if>    
										<a href="/report/list??currentPage=${maxPage }"> ▷▷ </a>
								</div>
							</div>
					</div>	
				</main>
				<jsp:include page="/WEB-INF/views/include/footer.jsp" />
			</div>	
	</body>
</html>