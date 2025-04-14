<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/include/managerList.css">
		<title>Insert title here</title>
	</head>
	<body>
		<div id="container">
			<jsp:include page="/WEB-INF/views/include/header.jsp" />
				<main>
					<div class="manager-main-page">
						<div class="manager-select-search">
							<div class="left-select-area">
								<button>회원관리</button>
								<button>신고관리</button>
								<button>축제최신화</button>
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

					</div>	
				</main>	
		</div>
	
	
	
	</body>
</html>