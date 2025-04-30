<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/manager/managerList.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">	
		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		<title>회원 목록</title>
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
				                <form class="search-form" action="/manager/search" method="get">
				                    <select name="searchCondition">
				                        <option value="all" ${param.searchContidion == 'all' ? 'selected' : '' }>전체</option>
				                        <option value="memberId" ${param.searchContidion == 'memberId' ? 'selected' : '' }>회원아이디</option>
				                        <option value="name" ${param.searchContidion == 'name' ? 'selected' : '' }>회원이름</option>
				                        <option value="nickName" ${param.searchContidion == 'nickName' ? 'selected' : '' }>닉네임</option>
				                    </select>
				                    <input type="text" placeholder="검색" name="searchKeyword" value="${param.searchKeyword}" >
				                    <button class="search-btn" type="submit">⌕</button>
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
													<button class="deleteButton" onclick="deleteMember('${member.memberNo}','${member.socialYn }','${member.memberName }')">탈퇴</button>
												</td>

											</tr>
										</c:forEach>
								</table>
									<div class="pagination">
									    <c:choose>
									        <c:when test="${not empty param.searchCondition and not empty param.searchKeyword}">
									            <a href="/manager/search?currentPage=1&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}">◁◁</a>
									            <c:if test="${pageInfo.startNavi ne 1}">
									                <a href="/manager/search?currentPage=${pageInfo.startNavi - 1}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}" class="prev">◀</a>
									            </c:if>
									            <c:forEach begin="${pageInfo.startNavi}" end="${pageInfo.endNavi}" var="p">
									                <a href="/manager/search?currentPage=${p}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}">${p}</a>
									            </c:forEach>
									            <c:if test="${pageInfo.endNavi ne pageInfo.maxPage}">
									                <a href="/manager/search?currentPage=${pageInfo.endNavi + 1}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}" class="next">▶</a>
									            </c:if>
									            <a href="/manager/search?currentPage=${pageInfo.maxPage}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}">▷▷</a>
									        </c:when>
									        <c:otherwise>
									            <a href="/manager/mypage?currentPage=1">◁◁</a>
									            <c:if test="${pageInfo.startNavi ne 1}">
									                <a href="/manager/mypage?currentPage=${pageInfo.startNavi - 1}" class="prev">◀</a>
									            </c:if>
									            <c:forEach begin="${pageInfo.startNavi}" end="${pageInfo.endNavi}" var="p">
									                <a href="/manager/mypage?currentPage=${p}">${p}</a>
									            </c:forEach>
									            <c:if test="${pageInfo.endNavi ne pageInfo.maxPage}">
									                <a href="/manager/mypage?currentPage=${pageInfo.endNavi + 1}" class="next">▶</a>
									            </c:if>
									            <a href="/manager/mypage?currentPage=${pageInfo.maxPage}">▷▷</a>
									        </c:otherwise>
									    </c:choose>
									</div>
							</div>
					</div>	
				</main>	
				<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
		<script>
			function customAlert(message) {
			    Swal.fire({
			      icon: 'warning',
			      title: message,
			      text: "",
			    });
			  }
			function deleteMember(memberNo, socialYn,memberName) {
				Swal.fire({
			          title: memberName+"님을 탈퇴시키겠습니까?",
			          icon: 'warning',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: '확인',
			          cancelButtonText: '취소',
			          reverseButtons: false, // 버튼 순서 거꾸로
			          
			        }).then((result) => {
			          if (result.isConfirmed) {
			        	  $.ajax({
								url: "/manager/delmem",
								data : {
									"memberNo" : memberNo,
									"socialYn" : socialYn,
								},
								type : "POST",
								success: function(data) {
									if(data > 0){
										customAlert("회원삭제가 완료되었습니다.");
										location.href = "/manager/mypage";
									}
									else{
										customAlert("회원삭제를 실패하였습니다.");
									}
								},
								error : function() {
									customAlert("통신오류!!");
								}
							});
			          }
			        })
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