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

        <div id="알림창" class="d-none mb-3"></div>


            <div class="mb-3">
                <label class="form-label">이름</label>
                <input type="text"
                       id="name"
                       name="name"
                       class="form-control"
                       placeholder="이름을 입력하세요">
            </div>

            <div class="mb-3">
                <label class="form-label">이메일</label>
                <div class="input-group">
                <input type="email"
                       id="email"
                       name="email"
                       class="form-control"
                       placeholder="이메일을 입력하세요">
                <button class="btn btn-outline-dark" type="button" onclick="인증번호발송()">
                    인증번호 발송
                </button>
                </div>
            </div>

            <div class="mb-3" id="인증번호영역" style="display: none;">
                <label class="form-label">인증번호</label>
                <div class="input-group">
                    <input type="text" id="code" class="form-control" placeholder="6자리 숫자를 입력해주세요.">
                    <button class="btn btn-outline-success"
                            ype="button"
                            onclick="인증번호확인()">
                        확인
                    </button>
                </div>
                <div id="인증결과" class="mt-1 small"></div>
            </div>
            <div class="mb-3">
                <label class="form-label">비밀번호</label>
                <input type="password"
                       id="password"
                       class="form-control"
                       placeholder="비밀번호를 입력하세요.">
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
                <button onclick="가입하기()"
                        class="btn btn-dark">가입하기
                </button>
            </div>
            <!-- type="submit 지워도 똑같이 기능 역할을 함" -->
        <div class="text-center mt-3">
            <a href="/user/login"
               class="text-muted">
                이미 계정이 있으신가요? 로그인
            </a>
        </div>

</div>
</div>
<script>
    async function 인증번호확인() {
        const email = document.getElementById("email").value.trim();   // TODO 1 : id 값 작성
        const code  = document.getElementById("code").value.trim();   // TODO 2 : id 값 작성
        const 결과  = document.getElementById("인증결과");

        const res = await fetch("/user/verify-code", {                             // TODO 3 : 요청 주소 작성
            method: "POST",                                           // TODO 4 : 전송 방식 작성
            headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, code })                     // TODO 5 : 전송할 데이터 작성 (힌트: 이메일과 코드)
    });

        if (res.ok) {
            이메일인증완료 = true;                                   // TODO 6 : 인증 완료 값 작성
            결과.innerHTML = '<span class="text-success fw-bold">인증 완료</span>';
            document.getElementById("code").disabled = false;        // TODO 7 : 재입력 방지 값 작성
        } else {
            결과.innerHTML = '<span class="text-danger">인증번호가 올바르지 않습니다.</span>';
        }
    }

    async function 가입하기() {
        if (이메일인증완료) {                                                 // TODO 8 : 인증 미완료 조건 작성
            alert("이메일 인증을 먼저 완료해주세요.");
            return;
        }

        const name     = document.getElementById("name").value.trim();  // TODO 9  : id 값 작성
        const email    = document.getElementById("email").value.trim();  // TODO 10 : id 값 작성
        const password = document.getElementById("password").value.trim();  // TODO 11 : id 값 작성

        if (!name || !email || !password) {
            alert("모든 항목을 입력하세요.");
            return;
        }

        const res = await fetch("/user/register", {                     // TODO 12 : 요청 주소 작성
            method: "POST",                                             // TODO 13 : 전송 방식 작성
            headers: { "Content-Type": "application-json" },                                   // TODO 14 : 헤더 작성
        body: JSON.stringify({ name, email, password })                  // TODO 15 : 전송할 데이터 작성 (힌트: 이름, 이메일, 비밀번호)
    });

        const data = await res.json();
        if (res.ok) {
            window.location.href = "/user/login?join=ture";              // TODO 16 : 성공 시 이동할 주소 작성
            // 힌트 : 로그인 페이지 + 성공 파라미터
        } else {
            showAlert("danger", data.message);                            // TODO 17 : 실패 타입 작성
        }
    }

    function showAlert(type, msg) {
        const el = document.getElementById("알림창");                     // TODO 18 : id 값 작성
        el.className = "alert alert-" + type;
        el.textContent = msg;
    }
    // const = 내부 데이터 변동 불가 let = 내부 데이터 변동 가능 변수
    let 이메일인증완료 = false; // true
    // const 이메일인증완료로 작성하면 이메일인증완료 공간은 데이터 변경 불가능한 공간으로 처리되어 true 변경할 수 없다.
    // var -> 심하게 레거시한 코드 추천 xxx

    function showAlert(type, message) {
        const 알림창 = document.getElementById("알림창");
        알림창.className = `alert alert-${type}`;
        알림창.innerText = message;
        알림창.classList.remove("d-none");
    }

    async function 인증번호발송(){
        const email = document.getElementById("email").value.trim();
        if(!email) {
            alert("이메일을 입력하세요.");
            return;
        }

        const res = await fetch("/user/send-code", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({email}), //
        })
        if (res.ok) {
            document.getElementById("인증번호영역").style.display = "block";
            showAlert("info", "인증번호가 발송되었습니다.(5분 유효)");
        } else {
            showAlert("danger", "발송에 실패했습니다.");
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>

</body>
</html>