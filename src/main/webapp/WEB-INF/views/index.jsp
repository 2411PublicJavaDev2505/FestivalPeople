<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../resources/css/root.css">
    <link rel="stylesheet" href="../resources/css/main.css">
	<link rel="stylesheet" href="../resources/css/include/footer.css">
    <link rel="stylesheet" href="../resources/css/include/header.css">
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
                    <h1>
                        <span class="main-text">마음까지 화사해지는<br>매화 명소</span>
                    </h1>
                </div>
            </div>
            <div class="slidecontroller-detail">
                <a href="#">자세히 보기</a>
            </div>
            <div class="slidecontroller-pagination">
                <div class="progress-bar">
                    <span class="progress"></span>
                </div>
                <div class="page-number">
                    <span class="current-page">01</span> / <span class="total-pages">03</span>
                </div>
                <div class="navigation-buttons">
                    <button class="prev">&#10094;</button>
                    <button class="next">&#10095;</button>
                </div>
            </div>
        </div>
        <div class="simple-slide-container">
            <div class="simple-slide active">
                <img src="../resources/img/maincourse/cherryBlossom.png" alt="봄 정취로 가득한 매화 명소">
            </div>
            <div class="simple-slide next">
                <img src="../resources/img/maincourse/beach.png" alt="여름의 즐거움! 바다와 함께하는 축제">
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/include/footer.jsp" />

    <script>
        let currentSlide = 0; 
        const slides = [
            { src: "../resources/img/maincourse/cherryBlossom.png", alt: "봄 정취로 가득한 매화 명소", tagline: "봄 정취로 가득!", mainText: "마음까지 화사해지는", subText: "매화 명소" },
            { src: "../resources/img/maincourse/beach.png", alt: "여름의 즐거움! 바다와 함께하는 축제", tagline: "여름의 즐거움!", mainText: "시원한 바다와 함께하는", subText: "축제" },
            { src: "../resources/img/maincourse/mountain.jpg", alt: "가을의 낭만! 단풍과 함께하는 여행", tagline: "가을의 낭만!", mainText: "단풍과 함께하는", subText: "여행" }
        ];
        const totalSlides = slides.length;

        const slideContainer = document.querySelector('.simple-slide-container');
        const currentPageElement = document.querySelector('.current-page');
        const progressBar = document.querySelector('.progress');
        const taglineElement = document.querySelector('.tagline');
        const mainTextElement = document.querySelector('.main-text');
        const subTextElement = document.querySelector('.slidecontroller-text-main h1');

        document.querySelector('.prev').addEventListener('click', () => {
            currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
            updateSlide();
            updateProgressBar();
        });

        document.querySelector('.next').addEventListener('click', () => {
            currentSlide = (currentSlide + 1) % totalSlides;
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
            
            slideContainer.innerHTML = '<div class="simple-slide active"><img src="'+slide.src+'" alt="'+slide.alt+'"></div>'
            							'<div class="simple-slide next"><img src="'+nextSlide.src+'" alt="'+nextSlide.alt+'"></div>';
            							currentPageElement.textContent = String(currentSlide + 1).padStart(2, '0');


            taglineElement.textContent = slide.tagline;
            mainTextElement.textContent = slide.mainText;
            subTextElement.innerHTML = '<span class="main-text">'+slide.mainText+'</span><br>'+slide.subText+'';
        }

        updateSlide();
		
    </script>
</body>
</html>
