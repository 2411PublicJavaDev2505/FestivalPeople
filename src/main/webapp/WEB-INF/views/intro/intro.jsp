<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resources/css/include/header.css">
	<link rel="stylesheet" href="../resources/css/intro/intro.css">
	<title>사이트 소개</title>
</head>
<body>
		<jsp:include page="../include/header.jsp"/>
		<!-- 바탕화면 -->
		<div class="background-image">
			<img src="../resources/img/review/review-insert-background.jpg" alt="바탕화면">
		</div>
			<main class="container">
				<div class="card">
					<img src="../resources/img/intro/logo.png">
					<div class="card__content">
						<p class="card__title">Festival People 는</p>
						<p class="card__description">소개내용</p>
						<button class="card__button">Live Demo</button>
						<button class="card__button secondary">Source Code</button>
					</div>
				</div>
				
			</main>
</body>
	
</html>