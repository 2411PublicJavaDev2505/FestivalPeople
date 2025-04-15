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
                <a href="/festival/detail?contentid=${festival.festivalNo}">
				    <h3>${festival.festivalName}</h3>
				</a>
                <p>📍 주소: ${festival.festivalStartDate}</p>
                <p>🗓️ 날짜: ${festival.festivalStartDate} ~ ${festival.festivalEndDate}</p>
                <c:if test="${not empty festival.festivalFilePath}">
                <img src="${festival.festivalFilePath}" alt="축제 이미지" width="300" />
            	</c:if>
            </li>
        </c:forEach>
        
    </ul>
	    
	</body>
</html>