<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>festival List api</title>
	</head>
	<body>
		<h1>🎉 축제 리스트</h1>
    <ul>
        <c:forEach var="festival" items="${festivals}">
            <li>
                <a href="/festival/detail?contentid=${festival.contentid}">
				    <h3>${festival.title}</h3>
				</a>
                <p>📍 주소: ${festival.addr1}</p>
                <p>🗓️ 날짜: ${festival.eventstartdate} ~ ${festival.eventenddate}</p>
                <c:if test="${not empty festival.firstimage}">
                <img src="${festival.firstimage}" alt="축제 이미지" width="300" />
            	</c:if>
            </li>
        </c:forEach>
        
    </ul>
	    
	</body>
</html>