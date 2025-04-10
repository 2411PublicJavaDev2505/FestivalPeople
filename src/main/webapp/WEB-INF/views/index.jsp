<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/css/main.css">
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <title>Festival People</title>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />

    <!-- 메인 컨텐츠 -->
    <main class="main-container">
        <!-- 슬라이드 쇼 컨테이너 -->
        <div class="slidecontroller">
            <div class="slidecontroller-text">
                <div class="slidecontroller-text-first">
                    <h3>
                        <span>봄 정취로 가득 </span>
                    </h3>
                </div>
                <div class="slidecontroller-text-main">
                    <h1>
                        <span>마음까지 화사해지는</span>매화 명소
                    </h1>
                </div>
            </div>
            <div class="slidecontroller-detail">
                <a href="http://">자세히 보기</a>
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
                <img src="../resources/img/cherryBlossom.png" alt="봄 정취로 가득한 매화 명소">
            </div>
        </div>
        </div>
        </main>
<%--     <jsp:include page="/WEB-INF/views/include/footer.jsp" /> --%>
    
    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.simple-slide');
        const totalSlides = slides.length;
        const currentPageElement = document.querySelector('.current-page');
        const progressBar = document.querySelector('.progress');
        document.querySelector('.prev').addEventListener('click', () => {
            currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
            updateSlide();
        });
        document.querySelector('.next').addEventListener('click', () => {
            currentSlide = (currentSlide + 1) % totalSlides;
            updateSlide();
        });
        function updateSlide() {
            slides.forEach((slide, index) => {
                slide.classList.toggle('active', index === currentSlide);
            });
            currentPageElement.textContent = String(currentSlide + 1).padStart(2, '0');
            progressBar.style.width = `${((currentSlide + 1) / totalSlides) * 100}%`;
        }
        updateSlide();
    </script>
</body>
</html>
