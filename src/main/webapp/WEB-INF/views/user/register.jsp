<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4 text-center fw-bold">회원가입</h2>

        <c:if test="${param.error == 'email'}">
            <div class="alert alert-danger">이미 사용중인 이메일입니다.</div>
        </c:if>

        <form action="/user/register" method="post">

            <div class="mb-3">
                <label class="form-label">이름</label>
                <input type="text" name="name" class="form-control" placeholder="이름을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label class="form-label">이메일</label>
                <input type="email" name="email" class="form-control" placeholder="이메일을 입력하세요" required>
            </div>
            <!--
            type="email" @ . 이 존재하게끔 클라이언트는 작성했는지 체크
            name="email" jsp -> java -> sql로 전달할 때 데이터가 들어있는 운반상자 명칭

            type="email" = 클라이언트가 이메일을 작성할 때 @ . 를 작성했는지 확인하는 타입
            name="email" = model.dto.User.java 파일에서 private String email로
                           데이터를 SQL에 운반할 동안 잠시 담아두는 명칭으로 사용되고 있다.
                           그리고 그명칭을 프론트엔드에서도 똑같이 맞춰서 email로 사용할 것이다.
             -->
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-dark">가입하기</button>
            </div>
            <!-- type="submit 지워도 똑같이 기능 역할을 함" -->
        <div class="text-center mt-3">
            <a href="/user/login" class="text-muted">이미 계정이 있으신가요? 로그인</a>
        </div>

    </form>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>
</body>
</html>