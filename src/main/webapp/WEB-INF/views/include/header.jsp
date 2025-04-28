<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<header class="main-header">
    <div class="logo-container">
        <a href="/"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="Festival People"></a>
    </div>
    <nav class="main-nav">
        <ul class="group1">
            <li style="--offset: 0;"><a href="/intro">소개</a></li>
            <li style="--offset: 1;"><a href="/festival/list">축제</a></li>
            <li style="--offset: 2;"><a onclick="goCourse();">코스 추천</a></li>
            <li style="--offset: 3;"><a onclick="goChat();">같이 갈래?</a></li>
        </ul> 
        <ul  class="group2">
            <li style="--offset: 4;"><a href="/review/list">여행 후기</a></li>
            <li style="--offset: 5;"><a href="/notice/list">공지사항</a></li>
            <c:if test="${member.memberId eq null }">
	            <li style="--offset: 6;"><a href="/member/login">로그인</a></li>
            </c:if>
            <c:if test="${member.memberId ne null }">
	            <li style="--offset: 6;"><a href="/member/logout">로그아웃</a></li>
            </c:if>
            <c:if test="${member.memberId eq null }">
	            <li style="--offset: 7;"><a href="/member/insert">회원가입</a></li>
            </c:if>
            <c:if test="${member.memberId ne null && member.managerYn eq 'N'}">
	            <li style="--offset: 7;"><a href="/member/detail">마이페이지</a></li>
            </c:if>
            <c:if test="${member.memberId ne null && member.managerYn eq 'Y'}">
	            <li style="--offset: 7;"><a href="/manager/mypage">관리자페이지</a></li>
            </c:if>
        </ul>
    </nav>
    <script type="text/javascript">
		function customConfirm(url) {
	        Swal.fire({
	          title: '로그인이 필요한 서비스입니다.',
	          text: "로그인하시겠습니까?",
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#3085d6',
	          cancelButtonColor: '#d33',
	          confirmButtonText: '로그인',
	          cancelButtonText: '취소',
	          reverseButtons: false, // 버튼 순서 거꾸로
	          
	        }).then((result) => {
	          if (result.isConfirmed) {
	            location.href = url;
	          }
	        })
	      }
    	const goChat = () => {
    		let memberId = '${member.memberId}';
    		if(memberId.trim() == ''){
    			customConfirm("/member/login");
    		}else {
    			location.href = "/chat/list";
    		}
    	}
    	
    	const goCourse = () => {
    		let memberId = '${member.memberId}';
    		if(memberId.trim() == ''){
				customConfirm("/member/login");
    		}else {
    			location.href = "/course/list";
    		}
    	}
    	
    </script>
</header>