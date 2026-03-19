<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spring Board</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">

    </script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .hero {
            background-color: #ffffff;
            border-bottom: 1px solid #e9ecef;
            padding: 80px 0;
        }

        .card {
            border: none;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            transition: transform;
        }

        .card:hover {
            transform: translateY(-4px);
        }
    </style>
</head>
<body>

<nav  class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container">

    <%-- 브랜드명 --%>
    <a class="navbar-brand" href="/">SpringBoard</a>

    <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <%-- TODO 3. 기존 <ul> 을 collapse 구조로 감싸시오 --%>
    <%-- 조건 : id="navbarNav" class="collapse navbar-collapse" --%>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">

            <%-- TODO 4. 게시판 링크는 그대로 유지 --%>
            <li class="nav-item">
                <a class="nav-link" href="/board/list">게시판</a>
            </li>

            <%-- 조건 : href = /product/list / 텍스트 = 제품목록 --%>
                <li class="nav-item">
                    <a class="nav-link" href="/product/product_list">제품목록</a>
                </li>
            <%-- 세션 방식 삭제
            JWT 방식은 서버가 세션을 안 만들기 때문에 session.
            <c:if test="${empty sessionScope.loginUser}">
                <li class="nav-item">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>
            </c:if>

            <c:if test="${not empty sessionScope.loginUser}">
                <li class="nav-item">
                    <a class="nav-link" href="/user/profile">${sessionScope.loginUser.name}님 환영해요!</a>
                    <!-- <span class="nav-link">${sessionScope.loginUser.name}님 환영해요!</span> -->
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/logout">로그아웃</a>
                </li>
            </c:if>
                --%>
                <li class="nav-item" id="메뉴_회원가입">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item" id="메뉴_로그인">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>

                <li class="nav-item d-none" id="메뉴_프로필">
                    <a class="nav-link" href="/user/profile">
                        <span id="유저이름"></span>님 환영해요!</a>
                </li>
                <li class="nav-item d-none" id="메뉴_로그아웃">
                    <a class="nav-link" href="#" onclick="로그아웃()">로그아웃</a>
                </li>
        </ul>
    </div>
</div>
</nav>

<script>
    //async 비동기 = 이 코드 안에 잠시 멈추고 백엔드 결과를 기다려야하는 코드가 들어있다. 표기
    async function 로그인상태확인() {
     try {
        const res = await fetch("/user/profile-iofo", {method: "GET"})
         if(res.ok) {
             const data = await res.json()
             document.getElementById("메뉴_회원가입").classList.add("d-none");
             document.getElementById("메뉴_로그인").classList.add("d-none");
             document.getElementById("메뉴_프로필").classList.remove("d-none");
             document.getElementById("메뉴_로그아웃").classList.remove("d-none");
             document.getElementById("유저이름").textContent = data.name; // innerText innerHTML textContent
             //                                  css까지 읽음(디자인가능 대신 화면에 늦게 나옴)             css 못읽음 (그래서 화면에 더 빨리 나옴)
             // querySelector
         }
     } catch (e) {
         console.log(e)
     }

    }

    async function 로그아웃() {
        await fetch("/user/logout", {method: "POST"});
        window.location.href = "/";
    }
    로그인상태확인(); // 로그인 상태에 따라 header 보이는 네비게이션 글자가 달라진다.

</script>