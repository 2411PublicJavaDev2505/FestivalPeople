<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../resources/css/root.css">
    <link rel="stylesheet" href="../resources/css/main.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <title>Festival People</title>
</head>
<body>
    <div class="background-image">
        <img src="../resources/img/mainback.jpg" alt="바탕화면">
    </div>
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
    <main class="main-container">
        <div class="slidecontroller">
            <div class="slidecontroller-text">
                <div class="slidecontroller-text-first">
                    <h3>
                        <span class="tagline">봄 정취로 가득 </span>
                    </h3>
                </div>
                <div class="slidecontroller-text-main">
                    <h3>
	                    <span class="sub-text wave"></span>
                    </h3>
                    <h1>
                        <span class="main-text"></span>
                    </h1>
                </div>
            </div>
            <div class="slidecontroller-detail">
                <span onclick="showDetail();" id="detailLink">자세히 보기</span>
            </div>
            <div class="slidecontroller-pagination">
                <div class="my-progress-bar">
                    <span class="progress"></span>
                </div>
                <div class="navigation-buttons">
                    <button class="prev">&#10094;</button>
                    <button class="next">&#10095;</button>
                </div>
            </div>
        </div>
        <div class="simple-slide-container" >
        	<div class="simple-slide active">
                <img src="" alt="" onclick="showDetail();">
            </div>

        </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    <script>
    
    let currentSlide = 0;
	//메인페이지 사진 및, 제목 정보 받아오기 
    const slides = [
        <c:forEach var="festival" items="${rfestivals}" varStatus="loop">
        {
            src: "${festival.festivalFilePath}",
            alt : "${festival.festivalStartDate}",
            tagline: "${festival.festivalEndDate}",
            subText: "<이번달 추천 축제>",
            mainText: "${festival.festivalName}",
            festivalNo: "${festival.festivalNo}"
        }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
	const totalSlides = slides.length;
    const slideContainer = document.querySelector('.simple-slide-container');
    const currentPageElement = document.querySelector('.current-page');
    const progressBar = document.querySelector('.progress');
    const taglineElement = document.querySelector('.tagline');
    const subTextElement = document.querySelector('.sub-text');
    const mainTextElement = document.querySelector('.main-text');
    
    const showDetail = () => {
		console.log(slides[currentSlide].festivalNo);
    	location.href = "/festival/detail/" + slides[currentSlide].festivalNo;
    }


        document.querySelector('.prev').addEventListener('click', () => {
            currentSlide = (currentSlide - 1 + slides.length) % slides.length;
            updateSlide();
            updateProgressBar();
        });

        document.querySelector('.next').addEventListener('click', () => {
            currentSlide = (currentSlide + 1) % slides.length;
            updateSlide();
            updateProgressBar();
        });


        function updateProgressBar() {
            const progress = ((currentSlide + 1) / totalSlides) * 100;
            progressBar.style.width = progress + '%';
        }
        
        function updateSlide() {
            
            const slide = slides[currentSlide];
            const nextSlide = slides[(currentSlide + 1) % totalSlides];
            
            let cImage = document.querySelector(".simple-slide.active img");
            
            $(".simple-slide.active ").fadeOut("slow", function() {
	            cImage.src = slide.src;
	            cImage.alt = slide.alt;
            });
            
            
           	$(".simple-slide.active ").fadeIn("slow");

            taglineElement.textContent = slide.tagline;
            subTextElement.textContent = slide.subText;
            mainTextElement.textContent = slide.mainText;
            $(".slidecontroller-text-main h3 span").show();
        }
		
        setInterval(function() {
        	currentSlide = (currentSlide + 1) % slides.length;
            updateSlide();
            updateProgressBar();
	    }, 5000);
      

        updateSlide();
        updateProgressBar();

    </script>
</body>
</html>
