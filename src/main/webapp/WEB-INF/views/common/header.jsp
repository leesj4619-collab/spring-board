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

            <%-- TODO 5. 제품 목록 링크를 추가하시오 --%>
            <%-- 조건 : href = /product/list / 텍스트 = 제품목록 --%>
            <a href="/product/product_list">제품목록</a>


            <%-- 로그인 전 --%>
            <c:if test="${empty sessionScope.loginUser}">
                <li class="nav-item">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>
            </c:if>

            <%-- 로그인 후 --%>
            <c:if test="${not empty sessionScope.loginUser}">
                <li class="nav-item">
                    <a class="nav-link">${sessionScope.loginUser.name}님 환영해요!</a>
                    <!-- <span class="nav-link">${sessionScope.loginUser.name}님 환영해요!</span> -->
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/logout">로그아웃</a>
                </li>
            </c:if>

        </ul>
    </div>
</div>
</nav>