<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>신고 하기 페이지 </title>
		<link rel="stylesheet" href="../resources/css/include/header.css">
		<link rel="stylesheet" href="../resources/css/report/reportContent.css">
		<link rel="stylesheet" href="../resources/css/include/footer.css">	
	</head>
	<body>
		<div id="container">
			<jsp:include page="/WEB-INF/views/include/header.jsp" />
				<main>
					<div class=report-main>
						<div class=report-title>
							<h4>신고하기</h4>
						</div>
						<div class=report-sub-title>
							<h6>신고하는 <br> 이유를 알려주세요</h6>
						</div>
						<form id="reportForm" action="/report/submit" method="post">
							<div class= repost-content>
								<div class=report-check-list>
									<label><input type="checkbox" name="reason" value="부적절한 내용"> 음란성, 욕설 등 부적절한 내용</label><br>
						            <label><input type="checkbox" name="reason" value="광고"> 부적절한 홍보 또는 광고</label><br>
						            <label><input type="checkbox" name="reason" value="개인정보"> 개인정보 유출 위험</label><br>
						            <label><input type="checkbox" name="reason" value="거짓정보"> 거짓된 정보</label><br>
						            <label>
						                <input type="checkbox" id="otherReasonCheck" name="reason" value="기타"> 기타
      									<input type="text" id="otherTextInput" name="otherText" placeholder="사유를 입력해 주세요" disabled style="margin-left: 10px;">
						            </label>
								</div>
								<div class=report-button>
									<button type=submit onclick="history.back()">취소하기</button>
									<button type=submit id="submitReportBtn">신고하기</button>
								</div>
							</div>
						</form>
						<p class="notice-text">타당한 근거 없이 신고된 내용은 관리자 확인 후 반영되지 않을 수 있습니다.</p>
					</div>
				</main>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</div>
		<script>
		 document.getElementById('otherReasonCheck').addEventListener('change', function () {
			    document.getElementById('otherTextInput').disabled = !this.checked;
			  });

			  // AJAX 신고 제출
			  document.getElementById('submitReportBtn').addEventListener('click', function () {
			    const form = document.getElementById('reportForm');
			    const formData = new FormData(form);

			    const selectedReasons = [];
			    form.querySelectorAll('input[name="reason"]:checked').forEach(el => {
			      selectedReasons.push(el.value);
			    });

			    if (selectedReasons.length === 0) {
			      alert("신고 사유를 선택해주세요.");
			      return;
			    }

			    const data = {
			      reasons: selectedReasons,
			      otherText: formData.get('otherText')
			    };

			    fetch('/report/submit', {
			      method: 'POST',
			      headers: {
			        'Content-Type': 'application/json'
			      },
			      body: JSON.stringify(data)
			    })
			    .then(resp => resp.json())
			    .then(result => {
			      if (result.success) {
			        alert("신고가 접수되었습니다.");
			        form.reset();
			        document.getElementById('otherTextInput').disabled = true;
			      } else {
			        alert("신고 처리 중 오류가 발생했습니다.");
			      }
			    })
			    .catch(err => {
			      console.error(err);
			      alert("네트워크 오류가 발생했습니다.");
			    });
			  });
		</script>
	</body>
</html>