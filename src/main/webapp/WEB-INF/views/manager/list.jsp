<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/manager/managerList.css">
		<title>Insert title here</title>
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
								<button>회원관리</button>
								<button>신고관리</button>
								<button id="refreshFestivalBtn">축제 최신화</button>
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
							<div class="member-manage-table">
								<table class ="total-table">
									<tr class ="table-title">
										<th class="id-head">아이디</th>
										<th class="name-head">이름</th>
										<th class="nickname-head">닉네임</th>
										<th class="email-head">이메일</th>
										<th class="report-head">신고누적횟수</th>
									</tr>
										<c:forEach items="${mList }" var="member" varStatus="i">
											<tr class ="member-Infomation">
												<td class="member-Id">${member.memberId }</td>
												<td class="member-Name">${member.memberName }</td>
												<td class="member-Nickname">${member.nickname }</td>
												<td class="member-Email">${member.email }</td>
												<td class="member-Report">${member.reportCount }
													<button>탈퇴</button>
												</td>

											</tr>
										</c:forEach>
								</table>
					            <div class="pagination">
										<a href="/manager/mypage?currentPage=1"> ◁◁ </a>
									<c:if test= "${startNavi ne 1 }">
										<a href="/manager/mypage?currentPage=${startNavi-1 }" class="prev">◀</a>
									</c:if>	
									<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
										<a class="pNum" href="/manager/mypage?currentPage=${p }">${p }</a>
									</c:forEach>					
									<c:if test="${endNavi ne maxPage }">
										<a href="/manager/mypage?currentPage=${endNavi+1 }" class="next">▶</a>
									</c:if>    
										<a href="/manager/mypage?currentPage=${maxPage }"> ▷▷ </a>
								</div>
							</div>
					</div>	
				</main>	
		</div>
		<script>
			document.getElementById("refreshFestivalBtn").addEventListener("click",function(){
				fetch("/festival/insert",{
					method: "GET"
				})
				.then(response => response.text())
				.then(data =>{
					alert("축제 정보 최신화가 되었습니다");
				})
				.catch(error=>{
					alert("최신화 중 오류가 발생 했습니다");
					console.error(error);
				});
			});
		</script>
	</body>
</html>