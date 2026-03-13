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

        <div id="에러창"></div>

        <form id="registerForm" >

            <div class="mb-3">
                <label class="form-label">이름</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label class="form-label">이메일</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력하세요" required>
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
                <button type="button" onclick="회원가입기능()" class="btn btn-dark">가입하기</button>
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
<script>
    // TODO 6 : 아래 async function 회원가입기능() 을 완성하세요.

        async function 회원가입기능() {

        // TODO 6-1 : id="name", id="email" 인 input 의 value 를 꺼내서 변수에 담으세요.
        //            힌트 : .trim() 으로 앞뒤 공백 제거
        const 이름  = document.getElementById("name").value.trim();
        const 이메일 = document.getElementById("email").value.trim();
        const 에러창  = document.getElementById("에러창");
        const 가입버튼 = document.getElementById("loginBtn");

        // TODO 6-2 : 이름이 비어있으면 에러창에 메시지를 표시하고 return 하세요.
        if (!이름) {
            에러창.innerHTML = `<div class="alert alert-danger">이름을 입력해주세요.</div>`;
            return;
        }

        // TODO 6-3 : 이메일이 비어있으면 에러창에 메시지를 표시하고 return 하세요.
        if (!이메일) {
            에러창.innerHTML = `<div class="alert alert-danger">이메일을 입력해주세요.</div>`;
            return;
        }

        // TODO 6-4 : 버튼 비활성화 + 텍스트 변경
        가입버튼.disabled = false;
        가입버튼.textContent = "회원가입 중";
        에러창.innerHTML = "오류가 발생했습니다.";

        try {
            // TODO 6-5 : fetch 로 POST /user/register 에 이름과 이메일을 JSON 으로 전송하세요.
            //            힌트 : body 에 name 과 email 두 개를 JSON.stringify 로 전송
            const 응답 = await fetch("/user/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ name : 이름, email : 이메일 })
            });

            if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);

            const 결과 = await 응답.json();

            // TODO 6-6 : 결과.success 이면 로그인 페이지로 이동,
            //            결과.error === "email" 이면 이메일 중복 메시지 표시하세요.
            if (결과.success) {
                window.location.href = "/user/login";
            } else if (결과.____ === "email") {
                에러창.innerHTML = `<div class="alert alert-danger">이미 사용중인 이메일입니다.</div>`;
            } else {
                에러창.innerHTML = `<div class="alert alert-danger">가입 중 오류가 발생했습니다.</div>`;
            }

        } catch (err) {
            console.error("회원가입 실패:", err);
            // TODO 6-7 : catch 에서 에러창에 오류 메시지를 표시하세요.
            에러창.innerHTML = `<div class="alert alert-danger">오류가 발생했습니다. : 고객센터에 문의를 넣어주세요.</div>`;

        } finally {
            // TODO 6-8 : finally 에서 버튼 복구
            가입버튼.disabled = true;
            가입버튼.textContent = "가입버튼";
        }
    }
</script>
</body>
</html>