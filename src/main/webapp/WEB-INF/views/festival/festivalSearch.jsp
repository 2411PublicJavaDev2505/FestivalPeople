<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/festival/festivalSearch.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">
		<title>Festival Main Page</title>
	</head>
	<body>
		
	    <div id="container">
	    <div class="background-image">
    	 	<img src="../resources/img/festival/우도.jpg" alt="바탕화면">
    	 </div>
		<jsp:include page="../include/header.jsp"/>
	       <main class="festival-main">
	           <div class="buttons">
	               
	               <div class="festival-search">
	                   <form class="search-form" method="get" action="/festival/search">
						    <select name="searchCondition">
						        <option value="all"<c:if test="${search.searchCondition eq 'all' }">selected</c:if>>전체</option>
						        <option value="name"<c:if test="${search.searchCondition eq 'name' }">selected</c:if>>축제명</option>
						        <option value="location"<c:if test="${search.searchCondition eq 'location' }">selected</c:if>>지역</option>
						    </select>
						    <input type="text" name="searchKeyword" value="${param.searchKeyword }" placeholder="검색어를 입력하세요">
						    <button type="submit" class="search-btn">⌕</button>
						</form>
	               </div>
	           </div>
	   
	           
	           <div class="festival-list">
	               <div class="festival-list-track">
					    <c:forEach var="festival" items="${festivals}">
					        <c:if test="${not empty festival.festivalFilePath}">
					            <div class="festival-card">
					                <a href="/festival/detail/${festival.festivalNo}">
					                    <img src="${festival.festivalFilePath}" alt="${festival.festivalName}" />
					                </a>
					                <h4>${festival.festivalName}</h4>
					            </div>
					        </c:if>
					    </c:forEach>
					</div>
               </div>
	               
			   <div class="pagination">
					<a href="/festival/search?searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}&currentPage=1"> ◁◁ </a>
					<c:if test= "${startNavi ne 1 }">
						<a href="/festival/search?searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}&currentPage=${startNavi-1 }" class="prev">◀</a>
					</c:if>	
					<c:forEach begin="${startNavi }" end="${endNavi }" var="p">
						<a href="/festival/search?searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}&currentPage=${p}">${p}</a>
					</c:forEach>					
					<c:if test="${endNavi ne maxPage }">
						<a href="/festival/search?searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}&currentPage=${endNavi+1}" class="next">▶</a>
					</c:if>    
		           	<a href="/festival/search?searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}&currentPage=${maxPage}"> ▷▷ </a>
	            </div>
	       </main>
	       <jsp:include page="/WEB-INF/views/include/footer.jsp" />
	   </div>
	</body>
</html>