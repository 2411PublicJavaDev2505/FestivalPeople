
<img src="./docimg/main_logo.png">

# Festival People(축제, 코스 추천 사이트)

## 팀 소개

<img src="./docimg/팀명.png">
Rechec

## 팀원 소개

<img src="./docimg/팀원소개.png">

## 기획의도

<img src="./docimg/기획의도.png">

## 차별성

<img src="./docimg/차별성.png">

## 개발일정

<img src="./docimg/개발일정.png">

## 프로젝트 개발환경

- DB는 오라클 11g XE 버전을 이용하였습니다.
- 프론트엔드 & 백엔드 개발은 Intellij IDEA Ultimate 버전을 이용하여 개발하였습니다.

## 프로젝트 실행 방법

1. 오라클 11g를 설치한 후에 application.yml 에 있는

```
spring.datasource.username
```
```
spring.datasource.password
```

를 참고해서 계정을 만듭니다. 
이때
```
spring.datasource.url
```
을 확인해서 spring.datasource.url 을 변경한 후에 거기에 계정을 만드는 걸로 합니다.
2. 그 계정에 RESOURCE, CONNECT 권한을 부여합니다. 
3. [CREATE SQL](./GNTOUR_CREATE.sql) 를 참고해서 테이블을 구성합니다.
4. [INSERT SQL](./INSERT_TRAVEL_INFO.sql) 를 참고해서 데이터를 구성합니다.
5. 환경변수를 다음과 같이 설정합니다.
```
GANGNEUNG_UPLOAD_FOLDER_PATH: [업로드할 폴더 경로] +"/"
EMAIL_APP_ID: [GMAIL 계정]
EMAIL_APP_PW: [GMAIL APP PASSWORD]
```
6. 그런다음 Intellij 에서 실행을 합니다.

## 기술 스택

![HTML](https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
<br>
![Tomcat](https://img.shields.io/badge/apache%20tomcat-F8DC75?style=for-the-badge&logo=apache%20tomcat&logoColor=black)
![GitHub](https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white)
![IntelliJ IDEA](https://img.shields.io/badge/intellij%20idea-000000?style=for-the-badge&logo=intellij%20idea&logoColor=white)
![Thymeleaf](https://img.shields.io/badge/thymeleaf-005F0F?style=for-the-badge&logo=thymeleaf&logoColor=white)
<br>
![Spring Boot](https://img.shields.io/badge/spring%20boot-6DB33F?style=for-the-badge&logo=spring%20boot&logoColor=white)
![Oracle](https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![Java](https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white)
![Canvas](https://img.shields.io/badge/canvas-E72429?style=for-the-badge&logo=canvas&logoColor=white)


## 주요기능
### 회원가입 

|기능명|상세|
|--|--|
|||
|||
|| 
||
|||

### 축제 리스트 출력(추천)

|기능명|상세|
|--|--|
|메인페이지 축제 추천| 메인 화면에 국내 기준 맑은 지역에서 진행되고 있는 축제 10개를 무작위추출하여 출력됩니다.|
|축제리스트 조회(비회원)| 비회원의 경우 현재 진행중인 국내 축제를 확인할수 있습니다.|
|추천 축제 리스트 조회(회원)| 회원의 경우 상단 부분에 "우리지역 축제" 버튼으로 추천되는 축제를 확인할수 있습니다. 추천 되는 축제는 회원정보에 등록되어있는 주소지 기반으로 가까운 지역의 일기예보가 맑은 지역의 축제를 확인할수 있습니다. 추천되는 축제의 경우 회원의 주소지에 맞춤으로 추천되어 주소지가 다를 경우 다른 축제가 추천 될수 있습니다. "진행중인 축제" 를 선택할 경우 현재 진행중인 축제를 확인할수 있습니다. 
|축제 리스트 조회(회원)| 추천되는 리스트 밑의  "전국축제리스트" 버튼을 선택할시 전국 진행중인 국내 축제를 확인 할수 있습니다.
|축제 정보 검색|현재 진행중인 축제를 축제명, 지역, 전체 로 설정하여 검색 하여 해당하는 축제를 확인할수 있습니다. |


### 축제 디테일 출력

|기능명|상세|
|--|--|
|축제 상세 정보 조회| 메인페이지에서 자세히 보기 또는, 축제 페이지에서 축제 사진 선택시 상세 정보를 확인할 수 있습니다. 상세 페이지에서는 축제 이름, 축제 일정, 개최 장소 및 대표 전화번호를 확인할수 있습니다.  |
|축제지역 일기예보| 현재 진행중인 축제 개최 장소 기반의 당일+2일간의 실시간 일기예보를 출력합니다. 개최 지역에 따라 일기예보는 다르게 출력됩니다.|
|지도| 현재 진행중인 축제 개최 장소의 지도를 확인할수 있습니다. 길찾기 버튼 선택시 kakao지도로 연결되며, 회원인 경우 추천 코스 선택시 해당 추천되는 코스페이지로 이동할수 있습니다|

### 코스 추천 페이지

|기능명|상세|
|--|--|
|축제 추천|로그인한 회원정보의 주소지를 기준으로 전국적으로 날씨가 좋은 지역만 추려 저장된 주소지와 가장 가까운 지역의 축제들을 추천합니다.|
|축제 정보 출력|추천되는 축제들의 카드에 마우스를 올릴 경우 해당 축제의 간략한 정보가 노출되며 선택이 가능합니다.|
|슬라이드|축제의 종료일자가 넉넉한 순으로 순차적으로 축제 추천리스트를 넘기며 확인이 가능합니다.|
|축제 검색|추천되는 축제리스트 외에도 지역, 축제명을 키워드로 검색하여 해당 정보가 담긴 축제들을 추가로 검색하여 리스트 확인이 가능합니다.|

### 코스 추천 디테일 페이지

|기능명|상세|
|--|--|
|코스 선택|축제 카드를 클릭하여 상세페이지로 이동시 지도에 축제 주소지 마커와 축제의 포스터가 기본으로 생성 되어있으며, 상단에 식당, 숙박업소, 카페, 주변관광지, 주차장, 문화시설 등 카테고리를 선택할 수 있도록 되어있습니다.|
|카테고리 선택|6개의 카테고리 중 원하는 카테고리를 선택시 축제 주소지 기준 주변 가장 가까운 장소가 선택되며 지도에 마커가 표시되며 하단에 해당 장소의 이름과 iframe을 통해 정보를 확인하며 디테일한 사항은 url을 통해 자동 해당 장소의 페이지로 이동이 가능합니다.|
|여행지 필터 기능|검색창의 우측에는 필터 아이콘이 있고 클릭 시 강릉시의 세부지도와 카테고리를 선택할 수 있는 팝업창이 뜹니다. 사용자는 권역별(주문진권, 시내권, 경포권, 대관령권, 정동진 옥계권) 또는 카테고리(산·트래킹, 바다·해안, 호수·공원, 전시, 역사·유적, 레저·체험)를 선택(복수 선택 가능)하여 원하는 정보를 찾을 수 있습니다.|
|여행지 즐겨찾기 기능|썸네일 오른쪽 상단에 있는 별표 이모티콘을 통해 즐겨찾기로 설정하거나 해제할 수 있습니다. 여행지 세부 정보 조회 페이지에서도 즐겨찾기를 설정하거나 해제할 수 있습니다.|

### 커뮤니티(채팅)
|기능명|상세|
|--|--|
|채팅방 전체 리스트 출력|커뮤니티의 역할을 하는 채팅방의 목록을 확인할 수 있는 기능으로 왼쪽에는 사용자가 속한 방을, 오른쪽은 사이트 내의 모든 채팅방의 목록을 확인할 수 있습니다.|
|채팅방 생성 기능|왼쪽 채팅방 생성 버튼을 누르고 채팅방의 제목, 태그, 대표사진, 정원수를 입력하여 새로운 방을 만들 수 있습니다.|
|채팅방 삭제|오른쪽 메뉴 버튼을 누르면 슬라이드 창이 뜹니다. 채팅방을 생성한 방장은 오른쪽 메뉴 버튼을 이용하여 채팅방을 삭제할 수 있습니다. 또한 관리자는 신고 리스트에서 신고당한 채팅방을 삭제할 수 있습니다.|
|채팅방 강퇴|방장의 메뉴창에는 회원 닉네임 옆에 내보내기 버튼이 있습니다. 이 버튼을 통해 방장은 가입된 회원을 강제 퇴실시킬 수 있습니다.|
|채팅방 검색|리스트 오른쪽 상단에 있는 검색창을 통해 사용자는 제목 및 태그의 키워드를 통한 채팅방을 검색할 수 있습니다.|
|채팅방 입장|사용자는 왼쪽 또는 오른쪽 채팅방 목록의 제목을 누르면 방에 입장할 수 있습니다. 처음 입장하는 채팅방일 경우 가입 여부를 묻는 팝업창이 뜨고 확인을 누르면 자동가입 되며 왼쪽의 내가 속한 리스트 목록에 방이 추가됩니다.|
|채팅방 나가기|방장이 아닌 회원은 메뉴에서 채팅방 나가기를 통해 탈퇴할 수 있고, 탈퇴한 채팅방은 내가 속한 리스트 목록에서 삭제됩니다.|
|채팅메시지 작성|채팅방에 입장하면 하단의 입력창에 대화를 입력하거나 파일을 첨부하여 메시지를 보낼 수 있습니다.|
|채팅메시지 내용 검색|입장한 채팅방 내에서 상단 검색창에 키워드를 입력하여 대화 내용을 조회할 수 있습니다. 해당 글자는 노란색 하이라이트로 강조되어 표시되며 상단으로 이동하면서 확인할 수 있습니다.|
|채팅방 알림|좌측 내가 속한 리스트에서는 현재 입장하지 않은 방의 안읽은 메시지 숫자를 확인할 수 있습니다.|


### 여행후기 페이지(박재일)

|기능명|상세|
|--|--|
|후기게시판 전체 출력(검색)|회원 및 비회원 모두 여행 후기 목록을 출력 및 조회 할수 있습니다 |
|후기글 상세조회|게시글 클릭시 제목, 작성자 닉네임, 작성일시, 조회수, 내용 및 댓글 목록을 조회할수 있습니다 |
|후기글 검색|모든 사용자는 제목 및 내용을 검색해서 조회 할수 있습니다 |
|후기글 작성|회원인 사용자만 후기글을 작성 할수 있습니다.|
|후기글 수정|로그인한 회원은 자신이 작성한 글에 한해 제목 및 내용 이미지를 수정 할수 있습니다.|
|후기글 삭제|후기 게시글 작성자와 관리자는 등록된 글을 삭제 할수 있습니다 |
|후기게시판 댓글 조회|모든 사용자는 후기게시판에 작성된 댓글을 볼 수 있습니다.|
|후기게시판 댓글 작성|로그인한 회원은 자신의 글과 다른회원의 댓글을 작성 할수 있습니다. 비회원은 댓글을 작성할수 없으며 로그인 해주세요 창이 뜹니다. |
|후기게시판 댓글 수정|로그인한 회원은 자신이 등록한 댓글에 대해서만 수정 할수 있습니다. |
|후게게시판 댓글 삭제|로그인한 회원은 자신이 등록한 댓글에 대해서만 삭제 할수 있습니다. |



### 공지사항

|기능명|상세|
|--|--|
|공지사항 상세조회|모든 사용자는 게시글 클릭 시 공지사항의 제목과 내용을 조회할 수 있습니다.|
|공지사항 작성|관리자는 제목, 내용 및 파일첨부를 이용하여 공지사항을 작성할 수 있습니다.|
|공지사항 수정|관리자는 공지사항을 수정할 수 있습니다. |
|공지사항 삭제|관리자는 공지사항을 삭제할 수 있습니다.|

### 신고 기능

|기능명|상세|
|--|--|
|채팅방 신고|신고사유를 작성해 채팅방을 신고할 수 있으며 관리자측에서 확인 후 삭제처리가 가능합니다.|
|후기게시글 신고|신고사유를 작성해 후기게시글을 신고할 수 있으며 관리자측에서 확인 후 삭제처리가 가능합니다. |
|후기 댓글 신고|신고사유를 작성해 후기댓글을 신고할 수 있으며 관리자측에서 확인 후 삭제처리가 가능합니다.|


### 마이페이지

|기능명|상세|
|--|--|
|QnA 조회|사용자는 여태까지 자신이 작성한 QnA 에 대해서 페이징 형식으로 확인할 수 있습니다. 등록일, 제목, 답변 상태, 답변 등록일을 확인할 수 있습니다. 관리자는 사용자가 등록한 QnA 들을 확인할 수 있습니다.|
|QnA 작성/삭제|질문에 대한 작성 및 삭제 권한은 회원으로 한하며, 로그인이 되어있지 않을 경우 로그인을 해달라는 경고창을 띄워  로그인을 유도하도록 합니다. 질문 작성 시 첨부파일을 추가하여 질문을 할 수 있으며, 질문 삭제는 자신의 글만 삭제할 수 있도록 제한합니다. |
|QnA 답변|사용자에게 받은 질문에 대한 답변은 관리자만 할 수 있습니다. 사용자는 질문에 대한 답변을 마이페이지의 링크를 통해서 확인할 수 있습니다.|
|QnA 답변 삭제|사용자, 관리자는 자신이 단 QnA 답변에 대해서 삭제할 수 있습니다.|

### 관리자 페이지

|기능명|상세|
|--|--|
|회원 목록 조회|관리자는 관리자 페이지 내에서 모든 회원의 아이디, 이름, 닉네임, 이메일 주소, 신고누적횟수를 확인할 수 있습니다.|
|회원 검색|관리자는 회원의 아이디, 이름, 닉네임을 검색해서 조회할 수 있습니다.|
|회원 탈퇴|신고가 누적되거나 부적절한 활동 이력이 있는 회원은 임의로 강제 탈퇴 시킬수 있습니다.|
|신고 조회|현재 접수된 신고의 리스트를 조회 할 수 있습니다.|
|신고 상세 조회|신고를 클릭 시 상세 내용이 보이며, 신고사유와 피신고자, 신고내용 정보가 조회됩니다.|
|신고 삭제|채팅, 후기 게시글, 후기 댓글 등 신고 받은 게시물을 확인하고 삭제할 수 있습니다.|
|신고 반려|관리자가 문제 없다고 판단한 내용은 반려처리로 현상태 유지시킬 수 있습니다.|

## 화면 구현

### 1. 메인

![](./docimg/화면_메인.png)

### 2. 소개 페이지

![](./docimg/화면_마커추가요청.png)

### 3. 로그인

![](./docimg/화면_로그인.png)

### 4. 회원 가입

![](./docimg/화면_회원가입.png)
![](./docimg/화면_이메일인증.PNG)

### 5. 아이디 찾기

![](./docimg/화면_아이디찾기.png)

### 6. 비밀번호 찾기

![](./docimg/화면_비밀번호찾기.png)
![](./docimg/화면_임시비밀번호이메일.PNG)

### 7. 축제 리스트

![](./docimg/화면_여행지리스트.png)
![](./docimg/화면_여행지필터.png)

### 8. 축제 디테일 

![](./docimg/화면_여행지상세정보-정보.png)

### 9. 코스 리스트

![](./docimg/화면_여행지상세정보-리뷰.png)

### 10. 코스 디테일

![](./docimg/화면_리뷰팝업창.png)

### 11. 같이갈래?

![](./docimg/화면_여행지리뷰신고.png)

### 12. 같이갈래 디테일

![](./docimg/즐겨찾기%20리스트%20최신순.png)

### 13. 여행 후기

![](./docimg/나의%20리뷰.png)

### 14. 여행 후기 디테일

![](./docimg/나의%20여행일기%20리스트%20데아터%20있을때.png)

### 15. 공지사항

![](./docimg/나의%20여행일기%20상세조회.png)

### 16. 공지사항 디테일

![](./docimg/나의%20여행일기%20등록.png)
![](./docimg/나의%20여행일기%20수정.png)
### 17. 공지사항 리스트 조회
![](./docimg/화면_사용자공지사항리스트.png)


### 18. 마이페이지

### 19. 관리자 페이지


### 20. QnA 작성
![](./docimg/화면_사용자문의작성.png)


![](./docimg/화면_관리자로그인.png)
![](./docimg/화면_관리자블랙리스트.png)
![](./docimg/화면_관리자회원상태변경.png)
![](./docimg/화면_관리자신고리스트.png)
![](./docimg/화면_관리자마커승인요청리스트.png)
![](./docimg/화면_관리자마커승인요청상세.png)
![](./docimg/화면_관리자공지사항리스트.png)
![](./docimg/화면_관리자공지사항작성.png)
![](./docimg/화면_관리자QnA답변리스트.png)
![](./docimg/화면_관리자QnA답변등록페이지.png)
![](./docimg/화면_관리자여행지리스트.png)
![](./docimg/화면_관리자여행상세.png)

## 프로젝트 아키텍처
### 사용자 흐름도
![](./docimg/강릉여지도사용자흐름도.png)
### 서버 흐름도
![](./docimg/강릉여지도서버흐름도.png)

화살표 방향은 의존 관계를 의미합니다. 컨트롤러는 서비스에 의존하지만 서비스는 컨트롤러에 의존하지 않습니다. 서비스는 Mapper 에 의존하지만 Mapper 는 서비스에 의존하지 않습니다. 컨트롤러, 서비스, Mapper 는 모두 ExceptionHandler 에 의존하며 ExceptionHandler 는 컨트롤러, 서비스, Mapper 에서 발생하는 Exception 들을 처리합니다.

## 프로젝트 산출 문서

- [기획보고서](https://drive.google.com/file/d/1ltvFKnuD1gAR6US39YeLW7jEI-hMBCnL/view?usp=drive_link)
- [요구사항정의서](https://drive.google.com/file/d/1vFH9YCcl468mdgflVMh_qCXK8N68QdZp/view?usp=drive_link)
- [요구사항리스트](https://drive.google.com/file/d/1zDGUGrokr3Ntgolve290yi5lr2ccQJq3/view?usp=drive_link)
- [유스케이스](https://drive.google.com/file/d/1hiMstXuWGUq9g14KPNzWbRBlne-c9O6q/view?usp=drive_link)
- [와이어프레임](https://drive.google.com/file/d/18z6TiflEoz91TQPa4FWGR5vzI49Z9Ebz/view?usp=drive_link)
- [플로우차트](https://drive.google.com/file/d/1quhEmZmJgwPu98i8Gt9S0eODS2_QfCtl/view?usp=drive_link)
- [테이블기술서](https://drive.google.com/file/d/1Nnu-Li1BpEexkyX_a8wbCslvIOKFuJyq/view?usp=drive_link)
- [클래스다이어그램](https://drive.google.com/file/d/15p-RLd3rk5NjtUMeXWzwkmFfGB7Q47Om/view?usp=drive_link)
- [시퀀스다이어그램](https://drive.google.com/file/d/1j7qOpOli1FfBvnvB41z6eTDLKdOwwHZb/view?usp=drive_link)
- [최종보고서](https://drive.google.com/file/d/1jobr3X8Ah79irlrzBp222f8n_KkpdP0S/view?usp=drive_link)
- [프로젝트 소스 DB](https://drive.google.com/file/d/1ME8JtDfx5IYlz4VJehkPRpjciZLFvmYB/view?usp=drive_link)
- [시연영상](https://drive.google.com/file/d/1OGNE0T1OtswRPe7KI7tTiSmNbNgXAwn8/view?usp=drive_link)
