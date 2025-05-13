
![main.jsp](https://github.com/user-attachments/assets/4bd7fb25-805f-404e-9522-f7532a6ba7db)

# Festival People(축제, 코스 추천 사이트)

## 팀 소개

![Image](https://github.com/user-attachments/assets/cdd0ba1e-1bc6-41ee-953b-326f17f1a7d9)

<details>
<summary>
## 팀원 소개
</summary>
<img src="https://github.com/user-attachments/assets/20bb75a3-1d0b-4969-b1ef-eef7a5df7496" alt="팀원소개">
</details>

## 기획의도

![Image](https://github.com/user-attachments/assets/34ddb25f-e0fa-4c22-804b-aa90e56a0fde)

## 차별성
![Image](https://github.com/user-attachments/assets/dd0ed4ff-217e-4b3b-948d-2287fc67d48d)
![Image](https://github.com/user-attachments/assets/bbcd78ec-5169-44d3-95ab-52efbd92694f)

<details>
<summary>
## 개발일정
</summary>
<img src="https://github.com/user-attachments/assets/fb1fe340-5ed2-4aee-bcfd-864b385fe30e" alt="개발일정">
</details>

## 프로젝트 개발환경

- DB는 오라클 11g XE 버전을 이용하였습니다.
- 프론트엔드 & 백엔드 개발은 주로 Spring Boot를 이용하여 개발하였습니다.

## 프로젝트 실행 방법

1. 오라클 11g를 설치한 후에 application.properties 에
```properties
# Oracle Connection Setting
spring.datasource.driver-class-name=oracle.jdbc.driver.OracleDriver
spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
spring.datasource.username
spring.datasource.password
```

를 참고하여 로컬에 db 계정 생성 계정 생성 후 권한 부여 및 테이블 생성 테이블, 시퀀스 생성 및 데이터 삽입 스크립트

[ADD] db 스크립트 추가
https://drive.google.com/file/d/1ME8JtDfx5IYlz4VJehkPRpjciZLFvmYB/view?usp=drive_link


## AWS 배포 환경 (url = http://festivalpeople.shop )
- 서버 : AWS t2.micro 인스턴스를 사용하였습니다.
- DB : AWS 인스턴스내에 Mysql(8.0.42.ver) RDS를 추가 연동하여 구현하였습니다.
- ip(15.164.94.92) : WAS 인스턴스와 DB 인스턴스(RDS)를 구별하여 단일 인스턴스내에 부하를 줄이고 원활한 제공이 가능하도록 구현하였습니다.
- [ADD] MySql 스크립트 추가
https://drive.google.com/file/d/1CdZMT916SETSZ0ZyUdgdh9xu_O2SiSyI/view?usp=drive_link
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
<img src="https://img.shields.io/badge/Amazon AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white"/>
<img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=MySQL&logoColor=white"/>




# 브랜치 전략
## Git Flow 방식
- 팀원 각자의 브랜치를 만들어 개발 진행
- 기능 구현이 완료되면 Main 브랜치에 병합
  ![git_flow](https://github.com/2405PublicJavaDev/sulgilddara/blob/main/img/github_flow.png?raw=true)


## 주요기능


### 회원가입 

|기능명|상세|
|--|--|
|소셜 회원가입, 로그인|카카오, 네이버, 구글 계정을 연동하여 기존 정보에 주소지 정보만 추가하여 사이트를 쉽게 사용할 수 있도록 구현 하였습니다.|
|홈페이지 회원가입, 로그인| 사용자가 직접 정보를 입력하여 사이트에 가입하며 최초 가입시 사용자 본인 소유의 이메일 계정을 입력하여 메일로 인증번호를 받아 입력하여야 합니다. |
|아이디 찾기, 비밀번호 찾기|회원가입시 입력했던 이메일과 이름으로 아이디와 비밀번호를 찾을 수 있습니다. 아이디와 비밀번호는 이메일로 전송되며 비밀번호는 무작위 문자, 숫자배열로 수정되어 전송됩니다.|
|보안 설정|Spring security를 통해 사용자의 정보를 암호화하여 회원정보에 대한 보안을 강화 하였습니다. 회원 비밀번호는 모두 암호화하여 저장하였고, 로그인 시 spring securty의 bean이 동작하도록 했습니다. 또한 post 요청시 헤더에 csrf 토큰을 삽입하도록 하였습니다.|


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
|길찾기|저장된 주소와 다른곳에서 출발할 경우 경로 탐색 API를 호출하는 버튼을 통하여 출발지를 입력하여 해당 축제까지의 경로를 탐색하는 기능을 제공합니다.|
|코스 저장 기능|선택한 축제와 카테고리를 확인하여 저장하기 버튼을 통해 추후에 마이페이지를 통해 해당 코스와 코스 상세를 동일하게 확인하는 기능을 제공합니다.|

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


### 여행후기 페이지

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
|후기게시판 댓글 삭제|로그인한 회원은 자신이 등록한 댓글에 대해서만 삭제 할수 있습니다. |



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
|개인정보 수정|회원가입시 저장된 주소, 이메일, 프로필 사진 등록 및 수정(gif 가능), 닉네임 등 자유롭게 정보를 수정할 수 있습니다. |
|나의 채팅방 확인하기|현재 사용자가 참여하고있는 채팅방 리스트가 노출되며 클릭시 해당 채팅방으로 이동하여 자유롭게 채팅에 참여할 수 있습니다.|
|나의 코스 확인하기|사용자가 저장해놓은 코스의 해당되는 축제 포스터와 함께 축제명, 사용자가 선택한 카테고리별 장소명과 마커가 노출되며 클릭시 해당 코스의 상세 페이지로 이동하며 하단의 삭제하기 버튼을 통해 저장 코스를 삭제 할 수 있습니다.|
|신고 누적 횟수 확인|사용자가 생성한 채팅방, 여행후기글, 후기 댓글 등 신고를 당한 게시물이 있을 경우 해당 게시물의 숫자가 나타나며 관리자가 부적절한 신고로 정상 참작될 경우 해당 숫자는 게시글 수 만큼 차감됩니다.|
|회원탈퇴|비밀번호를 확인한 후, 회원탈퇴를 진행할 수 있습니다.|

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


<details>
<summary>
1. 메인화면
</summary>
<img src="https://github.com/user-attachments/assets/4bd7fb25-805f-404e-9522-f7532a6ba7db" alt="메인 화면">
</details>

<details>
<summary>
2. 소개 페이지
</summary>
<img src="https://github.com/user-attachments/assets/988e28f4-fac5-4eb0-96d2-846e1127171b" alt="소개 페이지">
</details>

<details>
<summary>
3. 로그인(소셜 로그인 Oauth 구현)
</summary>
<img src="https://github.com/user-attachments/assets/6446804e-e49c-4bdc-b7d4-1876bb52585f" alt="메인 로그인">
<img src="https://github.com/user-attachments/assets/75625f63-cdef-49e0-bb2a-773a467fc24b" alt="카카오 로그인">
<img src="https://github.com/user-attachments/assets/d1b75f30-27f3-43d6-b47a-f7b4925df568" alt="구글 로그인">
<img src="https://github.com/user-attachments/assets/6806a0b2-06d6-4fc7-af54-6f27021b5ef5" alt="네이버 로그인">
</details>

<details>
<summary>
4. 아이디, 비밀번호 찾기
</summary>
<img src="https://github.com/user-attachments/assets/70c31fd2-2151-4da7-ad3b-f2f1945158df" alt="아이디 찾기">
<img src="https://github.com/user-attachments/assets/9372a7a5-7ab3-4d39-a4ac-8749c7252aeb" alt="비밀번호 찾기">
</details>

<details>
<summary>
5. 회원 가입
</summary>
<img src="https://github.com/user-attachments/assets/07a75703-7bf6-429b-8bbe-d64d83f88bed" alt="회원가입 페이지">
</details>


<details>
<summary>
6. 축제 리스트
</summary>
<img src="https://github.com/user-attachments/assets/7d263dd8-3158-4b15-b3f1-d8e26f98de0b" alt="축제리스트 비회원">
<img src="https://github.com/user-attachments/assets/5a9368fa-c1bf-40c6-80b6-c182aacbceb1" alt="축제리스트 회원">
</details>

<details>
<summary>
7. 축제 디테일 
</summary>
<img src="https://github.com/user-attachments/assets/bdf77206-e9bf-4a78-ab24-5da20d091441" alt="축제 상세 화면 첫번째">
<img src="https://github.com/user-attachments/assets/6e527bcc-63e2-4a20-b975-736ae8bce6bb" alt="축제 상세 화면 두번째">
</details>

<details>
<summary>
8. 코스 리스트
</summary>
<img src="https://github.com/user-attachments/assets/31c74b4b-122a-484b-8af1-f6918af7b783" alt="코스 전체리스트">
</details>

<details>
<summary>
9. 코스 디테일
</summary>
<img src="https://github.com/user-attachments/assets/baaec055-f22c-416c-aef0-3c8f7e466927" alt="코스 상세 이미지 첫번째">
<img src="https://github.com/user-attachments/assets/229796df-1b85-4f3f-80f6-d4a74ea13d05" alt="코스 상세 이미지 두번째">
</details>

<details>
<summary>
10. 같이갈래?
</summary>
<img src="https://github.com/user-attachments/assets/9b6c2bce-9dd5-4139-9cd9-ad2a9fb3a5a4" alt="같이갈래 메인페이지">
</details>

<details>
<summary>
11. 같이갈래 디테일
</summary>
<img src="7https://github.com/user-attachments/assets/23c7222e-f6de-4cf5-b253-a6e518860aba" alt="같이갈래 상세페이지">
</details>

<details>
<summary>
12. 여행 후기
</summary> 
<img src="https://github.com/user-attachments/assets/766b2984-556f-43b3-8909-bc9bdd8d2d8b" alt="여행 후기 메인페이지">
</details>

<details>
<summary>
13. 여행 후기 디테일
</summary>
<img src="https://github.com/user-attachments/assets/c2f2d122-62a4-411e-b6a0-de2dd77d6ab7" alt="여행후기 상세페이지">
</details>

<details>
<summary>
14. 공지사항
</summary>
<img src="https://github.com/user-attachments/assets/3202a62d-57d4-4920-a77e-49a7221c6a3e" alt="공지사항 메인페이지">
</details>

<details>
<summary>
15. 공지사항 디테일
</summary>
<img src="https://github.com/user-attachments/assets/bc14e810-e865-4885-b9b6-227628d6cc2d" alt="공지사항 상세페이지">
<img src="https://github.com/user-attachments/assets/bbc4d442-9b9d-4e3f-99ab-d56ec117fa86" alt="공지사항 상세페이지 두번째">
</details>

<details>
<summary>
16. 마이페이지
</summary>
<img src="https://github.com/user-attachments/assets/600b144b-bb1d-44b3-9c11-5c83b3c1a423" alt="마이페이지 첫번째">
<img src="https://github.com/user-attachments/assets/d43cb760-8754-4da7-bc16-dff341d0f325" alt="마이페이지 두번째">
</details>

<details>
<summary>
17. 관리자 페이지
</summary>
<img src="https://github.com/user-attachments/assets/c78712f3-7669-4bd6-8929-c430085f1713" alt="관리자 페이지 첫번째">
<img src="https://github.com/user-attachments/assets/8d0a60e9-9c21-4404-bade-7cbc95a06ea2" alt="관리자 페이지 두번째">
</details>

## 프로젝트 아키텍쳐-3계층 구조(Three-Tier Architecture) 
## MVC패턴(Model-View-Controller)

## 해당 구조 선택 이유
각 계층의 상호 의존성은 줄여 확장성에 대한 자유도에 기여하며 대용량 데이터의 경우 Controller내에서 즉각적인 처리를 통해 DB 용량 과부하를 줄이기 위해 해당 패턴을 선택하였습니다.

## 계층별 특징
컨트롤러는 서비스에 의존하지만 서비스는 컨트롤러에 의존하지 않습니다. 서비스는 Mapper 에 의존하지만 Mapper 는 서비스에 의존하지 않습니다. 컨트롤러, 서비스, Mapper 는 모두 ExceptionHandler 에 의존하며 ExceptionHandler 는 컨트롤러, 서비스, Mapper 에서 발생하는 Exception 들을 처리합니다.

## 프로젝트와 해당 계층의 장점
1. 개인별 담당 파트가 상이하기에 각 계층의 독립적 존재로 인해 확장성이 용이합니다.
2. 실시간 정보(날씨API, 지도API)를 DB에 매번 저장하여 관리하지 않고 Controller단계에서 직접 실시간 데이터 전달을 통해 DB의 부하를 줄일 수 있습니다.

## 프로젝트와 해당 계층의 단점
1. 실시간 API 호출의 경우 간혹 API 호출 데이터에 오류가 발생할 가능성을 염두해두어야 합니다.
    - 해결 방안으로는 DB내에 일정기간을 두어 오류가 발생하였을때 서브데이터를 DB에 저장후 출력하여 정상적인 작동이 확인될 경우 DB내용을 삭제하여 데이터 공간을 확보함과 동시에 이용에 문제가 없도록 할 수 있습니다.

2. 복잡성 : 사전에 협의되지 않은 무분별한 확장의 경우 상호간 혼란을 야기할수 있음으로 주의하여야 합니다.
    - 해결 방안으로는 코드내에 주석 혹은 사전 협의를 통해 혼란을 최소한으로 방지할 수 있습니다.

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
