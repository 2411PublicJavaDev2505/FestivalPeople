<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Festival People</title>
    <link rel="stylesheet" href="../resources/css/include/header.css">
    <link rel="stylesheet" href="../resources/css/include/footer.css">
    <link rel="stylesheet" href="../resources/css/include/terms.css">
</head>
<body>
    <!-- 헤더 -->
	<jsp:include page="../include/header.jsp"/>
	<!-- 바탕화면 -->
	<div class="background-image">
		<img src="../resources/img/notice/background.jpg" alt="바탕화면">
    </div>
	<div class="container">
	    <div class="terms-title">
	        <h2>개인정보 처리방침</h2>
	    </div>
		    <div class="terms-board">
		    	<div class="agree">
	                    <p>
	                        (주)○○○ 개인정보처리방침<br/>
	                        (주)○○○은 (이하 "회사"는) 「개인정보 보호법」 제30조에 따라 이용자의 개인정보를 보호하고 
	                        이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리방침을 수립·공개합니다.
	                    </p>
	                    <p>개인정보처리방침은 다음과 같은 내용을 담고 있습니다.</p>
	                    <p>1. 개인정보의 처리 목적</p>
	                    <p>2. 개인정보의 처리 및 보유 기간</p>
	                    <p>3. 처리하는 개인정보의 항목 및 수집 방법</p>
	                    <p>4. 만 14세 미만 아동의 개인정보 처리에 관한 사항</p>
	                    <p>5. 개인정보의 제3자 제공에 관한 사항</p>
	                    <p>6. 개인정보처리의 위탁에 관한 사항</p>
	                    <p>7. 개인정보의 파기절차 및 파기방법</p>
	                    <p>8. 정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항</p>
	                    <p>9. 개인정보의 안전성 확보조치에 관한 사항</p>
	                    <p>10. 개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항</p>
	                    <p>11. 개인정보 보호책임자에 관한 사항</p>
	                    <p>12. 정보주체의 권익침해에 대한 구제방법</p>
	                </div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
