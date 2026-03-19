<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">

        <h2 class="mb-4 text-center fw-bold">로그인</h2>

        <div id="알림창" class="d-none mb-3"></div>

        <div class="mb-3">
            <label class="form-label">이메일</label>
            <input type="email"
                   id="email"
                   name="email"
                   class="form-control"
                   placeholder="이메일을 입력하세요">
        </div>

        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password"
                   id="password"
                   name="password"
                   class="form-control"
                   placeholder="비밀번호를 입력하세요">
        </div>
        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-dark" onclick="로그인()">로그인</button>
        </div>
        <div class="text-center mt-3">
            <a href="/user/register" class="text-muted">계정이 없으신가요? 회원가입</a>
        </div>
        <div class="text-center mt-2">
            <a href="/user/find-email" class="text-muted"> 이메일 찾기!</a>
        </div>
    </div>
</div>


<script>
    // == type 이 같은지는 확인하지 않고, 내부 데이터가 같은가?   === type 까지 확인해서 데이터 같은가?
    const params = new URLSearchParams(window.location.search);
    if(params.get('success') === "join") {
        const el = document.getElementById("알림창");
        el.className = "alert alert-success";
        el.textContent = "회원가입이 완료되었습니다. 로그인해주세요.";
        // 나중에는 회원가입 완료되었다는 알림 표기를 자바스크립트를 이용해서 몇초간 보여주고 사라지게 할 것
    }

    async function 로그인() {
        // document.getElementById("email") = html에서 id로 email로 작성한 것에 대한 태그에 들어 있는 모든 정보를 가져온 다음에
        // .value.trim(); = 그 중에서 value로 들어있는 클라이언트가 작성한 이메일 데이터를 양쪽 공백 제거하고 const email 공간에 담아두겠다.
        // .value = 클라이언트가 작성한 데이터가 저장되어 있는 키이름
        // .trim() = 양쪽공백 제거하기 기능
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();
        if (!email || !password) {
            alert("이메일과 비밀번호를 입력하세요.");
            return; // 로그인을 할 권한이 없기 때문에 돌려보내기 아래 코드 실행 못하게 하기
            // return을 안쓰면 이메일과 비밀번호를 입력하세요.을 보여주고 로그인 시켜줌
        }

        const res = await fetch("/user/login", {
            method : "POST",
            headers : {"Content-Type": "application/json"},
            body: JSON.stringify({email, password}), // json 되어있는 자바스크립트를 문자열로 변환해서 전선으로 한 줄 전달
        });

        const data = await res.json(); // 만약 백엔드에서 응답이 오면 문자열로 온 응답을 다시 json 형태로 변환해서 data 공간 임심 보관
        if (res.ok) window.location.href="/";
        else {
            const el = document.getElementById("알림창");
            el.className = "alert alert-danger";
            el.textContent = data.message; // 백엔드에서 온 응답을 그대로 보여주겠다.
        }

    }

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>
    </body>
</html>