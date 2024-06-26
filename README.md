# 🎵 음원 스트리밍 웹 서비스 YogiAudio
<p align="center">
  <img src="https://github.com/songkidong/YogiAudio/assets/141198018/ee34ce45-dfd1-4fb5-9ece-6f9217d3132f">
</p>

<br>

## 프로젝트 소개
-
-
-
-
- 시연 영상 (유튜브) : https://youtu.be/VBZ-mLgSxFk

<br>

## 팀원 구성
![Screenshot_43](https://github.com/songkidong/YogiAudio/assets/141198018/61249a6d-482b-48ff-9ed2-080df50bb6fd)

<br>

## 개발 환경
- 개발 툴 : Spring Tools 4 (4.21.1)
- Backend : JAVA 17, SpringBoot 3.1.8, MyBatis, JSP, MySQL 8.0.26, lombok, BCrypt HASH, Apache Tomcat : 9.0
- Frontend : bootstrap : 4.6.2, HTML5, CSS3, JavaScript : 1.16.1, JQuery : 3.6.4
- 버전/이슈관리 : GitHub, GitBash
- 협업 툴 : Discord, Notion
- 외부 API : 토스 결제 API, 카카오/구글/네이버 소셜로그인 API, 이메일 전송(네이버 SMTP 프로토콜) API
- 게시판 : Summernote editor

<br>

## 브랜치 전략
Git-flow 전략을 기반으로 main, develop 브랜치와 feature 보조 브랜치를 운용했습니다.
- main, develop, Feat 브랜치로 나누어 개발을 하였습니다.
- main 브랜치는 배포 단계에서만 사용하는 브랜치입니다.
- develop 브랜치는 개발 단계에서 git-flow의 master 역할을 하는 브랜치입니다.
- Feat 브랜치는 기능 단위로 독립적인 개발 환경을 위하여 사용하고 merge 후 각 브랜치를 삭제해주었습니다.

<br>

## ⚙ 의존성
```java
implementation 'com.google.code.gson:gson:2.8.8'
implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
implementation group: 'org.glassfish.web', name: 'jakarta.servlet.jsp.jstl', version: '2.0.0'
implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:3.0.3'
runtimeOnly 'com.mysql:mysql-connector-j'
implementation 'org.springframework.boot:spring-boot-starter-web'
compileOnly 'org.projectlombok:lombok'
developmentOnly 'org.springframework.boot:spring-boot-devtools'
runtimeOnly 'com.h2database:h2'
annotationProcessor 'org.projectlombok:lombok'
testImplementation 'org.springframework.boot:spring-boot-starter-test'
implementation 'org.springframework.security:spring-security-crypto'
implementation 'org.springframework.boot:spring-boot-starter-mail'
```	

<br>

## 개발기간 / 일정관리
개발기간 (총 12일)</p>
- 2024.03.11 ~ 2024.03.27
작업관리
- 노션을 이용하여 그날 작업했던 내용을 기록하였습니다.
- 노션 주소 : "https://phase-ground-168.notion.site/14c5a9ac94484ad29fdf3f0db3c4c613?v=d9e697a019a945f0a10048e72c89218e&amp;pvs=4
- 
![일정관리1](https://github.com/songkidong/YogiAudio/assets/141198018/acf3ef69-3f4c-4379-8353-40e6b3def14d)
![일정관리2](https://github.com/songkidong/YogiAudio/assets/141198018/83b0141b-42c8-46ae-9568-11b130cd9470)

## 1️⃣ 프로젝트 구조

<details>
    <summary>⚡️ 구조 자세히 살펴보기</summary>

    📦src
     ┗ 📂main
       ┣ 📂java
       ┃ ┗ 📂com
       ┃   ┗ 📂project3
       ┃     ┗ 📂yogiaudio
       ┃       ┣ 📂config
       ┃       ┣ 📂controller
       ┃       ┣ 📂dto
       ┃       ┣ 📂filedb
       ┃       ┣ 📂handler
       ┃       ┃ ┗ 📂exception
       ┃       ┣ 📂repository
       ┃       ┃ ┗ 📂entity
       ┃       ┃ ┗ 📂interfaces       
       ┃       ┣ 📂service
       ┃       ┗ 📂util
       ┃       
       ┣ 📂resources
       ┃ ┣ 📂db
       ┃ ┣ 📂mapper
       ┃ ┗ 📂static
       ┃   ┣ 📂album
       ┃   ┣ 📂assets
       ┃   ┣ 📂banner
       ┃   ┣ 📂css
       ┃   ┣ 📂favicon
       ┃   ┣ 📂img
       ┃   ┣ 📂js
       ┃   ┣ 📂logo       
       ┃   ┣ 📂main
       ┃   ┗ 📂music
       ┃       
       ┗ 📂webapp
         ┗ 📂WEB-INF
           ┗ 📂view
             ┣ 📂admin
             ┣ 📂board
             ┣ 📂layout
             ┣ 📂product             
             ┗ 📂user          


</details>

<br>

## 2️⃣ 프로젝트 개요
* 핵심 기능이 많으며 실무에서 활용할 수 있는 기능이 포함됐다고 생각했고, 실시간 스트리밍/다운로드를 구현해보고 싶어서 음원 스트리밍 사이트로 주제 선정
* 현행 시스템 벤치마킹 (지니 뮤직)

<br>

## 3️⃣ ERD
![erd](https://github.com/songkidong/YogiAudio/assets/141198018/9bae477b-bbfa-4ff0-9e1d-614473974c61)

<br>

## 4️⃣ SiteMap
![sitemap](https://github.com/songkidong/YogiAudio/assets/141198018/433c4c3d-d4e5-40d2-97c6-93952974931f)

<br>

## 5️⃣ 기능 - 회원
<table>
    <tr>
        <td>로그인, 회원가입</td>
        <td>소셜 로그인</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/695146ca-b48f-417d-b90b-7974a1f2f3ce"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/4d1fdfc3-275e-4ee6-a85b-8de8c415ecb4"></td>
    </tr>
    <tr>
        <td>아이디 찾기</td>
        <td>비밀번호 찾기</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/4fa8172c-5b82-45d6-b4d4-2d42aaa60304"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/bd9fd107-57aa-4265-b771-474ae387ad60"></td>
    </tr>
    <tr>
        <td>회원정보 수정</td>
        <td>회원 탈퇴</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/39af311b-2eab-450f-af0f-1c43c19b9887"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/258ecf33-38db-46c0-b596-0011ab4c5f39"></td>
    </tr>
    <tr>
        <td>환불 내역, 환불 요청</td>
        <td>플레이리스트 내역</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/1c60e883-5cfc-4a60-aba0-4c87aab85045"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/1f6c124b-d3a9-4ecd-a390-3a51294e24f5"></td>
    </tr>
    <tr>
        <td>좋아요 내역, 취소</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/141198018/27477160-5223-4cff-8ff8-b7e87cc09c15"></td>
    </tr>
</table>

### 뮤직 플레이어
- 반복재생/1곡재생
- 셔플
- 가사 싱크 및 해당 구간 이동
- 재생 목록 추가
- 플레이리스트 추가
- 좋아요
### 게시판
-

<br>

## 6️⃣ 기능 - 관리자

<table>
    <tr>
        <td>관리자 메인 / 유저 탈퇴</td>
        <td>공지사항 등록, 수정, 삭제 / 파일 다운로드</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/30697896-2a44-4828-ab47-267db8bf236b"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/f81384fd-75aa-4e1a-b172-54633da9d611"></td>
    </tr>
    <tr>
        <td>QnA 답변 등록, 수정, 삭제 / 글 삭제</td>
        <td>자유게시판 댓글 삭제 / 글 삭제</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/638ddee3-3666-4452-b03e-52fd41f7dd34"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/2b2238d4-aafe-47d6-bba2-8565b8d5c36c"></td>
    </tr>
    <tr>
        <td>음원 등록, 삭제</td>
        <td>뮤직비디오 등록, 삭제</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/90dac9df-4616-44fe-9cdd-7f6adc820820"></td>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/ff99e2bc-74a3-422c-beb8-413ec1c527f9"></td>
    </tr>
    <tr>
        <td>결제 내역 / 환불 승인</td>
    </tr>
    <tr>
        <td><img src="https://github.com/songkidong/YogiAudio/assets/136421972/0472904b-7e09-40b3-b14a-4c0a52570241"></td>
    </tr>
</table>

