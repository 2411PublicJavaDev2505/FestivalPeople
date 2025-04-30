<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/csrf.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>신고 하기 페이지 </title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/report/reportContent.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">	
		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	</head>
	<body>
		<div id="container">
			<jsp:include page="/WEB-INF/views/include/header.jsp" />
				<main>
					<div class=report-main>
						<div class=report-title>
							<h4>
								<c:if test="${target eq 'chat' }">채팅방</c:if>
								<c:if test="${target eq 'rev' }">리뷰</c:if>
								<c:if test="${target eq 'com' }">댓글</c:if>
								 신고하기
							</h4>
						</div>
						<div class=report-sub-title>
							<h6>신고하는 <br> 이유를 알려주세요</h6>
						</div>
						<div class= repost-content>
							<div class=report-check-list>
								<label><input type="checkbox" class="reason" value="부적절한 내용"> 음란성, 욕설 등 부적절한 내용</label><br>
					            <label><input type="checkbox" class="reason" value="광고"> 부적절한 홍보 또는 광고</label><br>
					            <label><input type="checkbox" class="reason" value="개인정보"> 개인정보 유출 위험</label><br>
					            <label><input type="checkbox" class="reason" value="거짓정보"> 거짓된 정보</label><br>
					            <label>
					                <input type="checkbox" id="otherReasonCheck" value="기타"> 기타
   									<input type="text" id="otherTextInput" class="reason" placeholder="사유를 입력해 주세요" disabled style="margin-left: 10px;">
					            </label>
							</div>
							<div class=report-button>
								<button type=submit onclick="history.back()">취소하기</button>
								<button type=submit id="submitReportBtn">신고하기</button>
							</div>
						</div>
						<p class="notice-text">타당한 근거 없이 신고된 내용은 관리자 확인 후 반영되지 않을 수 있습니다.</p>
					</div>
				</main>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
		<script>
			function customAlert(message) {
			    Swal.fire({
			      icon: 'warning',
			      title: message,
			      text: "",
			    });
		  	}
			document.getElementById('otherReasonCheck').addEventListener('change', function () {
				document.getElementById('otherTextInput').disabled = !this.checked;
			});
			
			document.querySelector("#submitReportBtn").addEventListener('click',function() {
				let reason = "";
				let arr = document.querySelectorAll('.reason:checked');
				arr.forEach(idx => {
					reason += idx.value + ",";
				})
				
				let etc = document.querySelector('#otherTextInput').value;
				if(etc.trim() != ""){
					reason += etc;
				}else{
					reason = reason.substring(0,reason.length-1);
				}
				if(reason.trim() == ''){
					customAlert("신고사유를 선택해주세요!");
				}else{
					$.ajax({
						dataType: "json",
						url: "/report/insert",
						data : {
							"reportObject" : "${target}",
							"reportContent" : reason,
							"num" : "${num}"
						},
						type : "POST",
						success : function(data) {
							if(data.check == '0'){
								Swal.fire({
							          title: '로그인이 필요한 서비스입니다.',
							          text: "로그인하시겠습니까?",
							          icon: 'warning',
							          showCancelButton: true,
							          confirmButtonColor: '#3085d6',
							          cancelButtonColor: '#d33',
							          confirmButtonText: '예',
							          cancelButtonText: '아니요',
							          reverseButtons: false, // 버튼 순서 거꾸로
							        }).then((result) => {
							          if (result.isConfirmed) {
										location.href="/member/login";
							          }else{
							        	location.href="/";
							          }
							        })
							}else{
								Swal.fire({
							          title: '신고가 등록되었습니다!',
							          icon: 'warning',
							          showCancelButton: true,
							          confirmButtonColor: '#3085d6',
							          cancelButtonColor: '#d33',
							          confirmButtonText: '확인',
							          cancelButtonText: '메인페이지로',
							          reverseButtons: false, // 버튼 순서 거꾸로
							        }).then((result) => {
							          if (result.isConfirmed) {
							        	  history.back();
							          }else{
							        	  location.href="/";
							          }
							        })
							}
						},
						error: function() {
							customAlert("통신 오류!!");
						}
					});
					
				}
			})

			  // AJAX 신고 제출
// 			  document.getElementById('submitReportBtn').addEventListener('click', function () {
// 			    const form = document.getElementById('reportForm');
// 			    const formData = new FormData(form);

// 			    const selectedReasons = [];
// 			    form.querySelectorAll('input[name="reason"]:checked').forEach(el => {
// 			      selectedReasons.push(el.value);
// 			    });

// 			    if (selectedReasons.length === 0) {
// 			      alert("신고 사유를 선택해주세요.");
// 			      return;
// 			    }
			    
// 			    let reasons = "";
// 			    for(let i = 0; i < selectedReasons.length ; i++){
// 			    	if(i == selectedReasons.length - 1){
// 			    		reasons += selectedReasons[i];
// 			    	}else{
// 				    	reasons += selectedReasons[i] + ",";
// 			    	}
// 			    }

// 			    const data = {
// 			      "reasons" : reasons,
// 			      "otherText" : document.querySelector("#otherTextInput").value
// 			    };
// 			    console.log(data)

// 			    fetch('/report/submit', {
// 			      method: 'POST',
// 			      headers: {
// 			        'Content-Type': 'application/json'
// 			      },
// 			      body: JSON.stringify(data)
// 			    })
// 			    .then(resp => resp.json())
// 			    .then(result => {
// 			      if (result.success) {
// 			        alert("신고가 접수되었습니다.");
// 			        form.reset();
// 			        document.getElementById('otherTextInput').disabled = true;
// 			      } else {
// 			        alert("신고 처리 중 오류가 발생했습니다.");
// 			      }
// 			    })
// 			    .catch(err => {
// 			      console.error(err);
// 			      alert("네트워크 오류가 발생했습니다.");
// 			    });
// 			  });
		</script>
	</body>
</html>