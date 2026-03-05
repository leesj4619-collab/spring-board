<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            transition:transfrom;
        }
        .card:hover {
            transform: translateY(-4px);
        }
    </style>
</head>
<body>

<!-- 조건 : 왼쪽에 브랜드명(SpringBoard), 오른쪽에 게시판 링크(/board/list) -->
<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/">SpringBoard</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/board/list">게시판</a>
                </li>
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
                        <span class="nav-link">${user.email}님 환영해요!</span>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/user/logout">로그아웃</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- 조건 : 제목, 설명, 게시판 바로가기 버튼 포함 -->
<section class="hero text-center">
    <div class="container">
        <h1>Spring 게시판에 오신 것을 환영합니다.</h1>
        <p class="mt-3">봄같은 게시판 입니다.</p>
        <a href="/board/list" class="btn btn-dark mt-3 px-4">게시판 바로가기</a>
    </div>
</section>

<!-- 카드1 : 게시물 작성 → /board/write -->
<!-- 카드2 : 게시물 목록 → /board/list -->
<section class="py-5">
    <div class="container">
        <div class="row g-4 justify-content-center">

            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📝</div>
                    <h5 class="mt-3 fw-bold">게시물 작성</h5>
                    <p class="text-muted">새로운 게시물을 작성해보세요</p>
                    <a href="/board/write" class="btn btn-outline-dark mt-auto">작성하기</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📜</div>
                    <h5 class="mt-3 fw-bold">게시물 목록</h5>
                    <p class="text-muted">등록된 게시물을 확인하세요</p>
                    <a href="/board/list" class="btn btn-outline-dark mt-auto">목록보기</a>
                </div>
            </div>

        </div>
    </div>
</section>

<footer class="text-center py-4 mt-5">
    <div class="container">
        <small>&copy; 2026 SpringBoard. All rights reserved.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">

</script>
</body>
</html>