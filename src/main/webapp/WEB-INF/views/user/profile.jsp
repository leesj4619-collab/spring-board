<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>

<%@ include file="../common/header.jsp" %>

<div class="container mt-5">
    <h2>내 프로필</h2>

    <div id="알림창" class="d-none mb-3"></div>

    <c:choose>
        <c:when test="${not empty user.profile_img}">
            <img id="미리보기" src="${user.profile_img}" alt="프로필 사진" width="120">
        </c:when>
        <c:otherwise>
            <img id="미리보기" src="" style="display: none; width: 120px;">
            <p id="noImg">이미지 없습니다.</p>
        </c:otherwise>
    </c:choose>

    <%--
         세션 방식 - 삭제
        <form action="/user/profile/upload" method="post" enctype="multipart/form-data">
            <input type="file" name="imageFile">
            <button>저장하기</button>
        </form>
         JWT 방식 - fetch FormData 로 전송
        파일은 JSON 으로 못 보내기 때문에 FormData 사용
    --%>
    <div class="mt-3">
        <input type="file" id="imageFile" accept="image/*" onchange="미리보기기능(this)">
        <button class="btn btn-dark mt-2" onclick="프로필사진업로드()">저장하기</button>
    </div>

    <%--
         세션 방식 - 삭제
        <form action="/user/profile/edit" method="post">
            <input name="name" value="${user.name}">
            <button type="submit">저장하기</button>
        </form>
         JWT 방식 - fetch JSON 으로 전송
    --%>
    <table class="table mt-3">
        <tr>
            <td>이름</td>
            <td><input type="text" id="name" value="${user.name}" class="form-control"></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td><input type="text" id="email" value="${user.email}" class="form-control"></td>
        </tr>
        <tr>
            <td>가입일</td>
            <td>${user.create_at}</td>
        </tr>
    </table>

    <button class="btn btn-dark" onclick="정보수정()">저장하기</button>
    <a href="/" class="btn btn-outline-dark">메인으로</a>
</div>

<script>
    function 미리보기기능(input) {
        const preview = document.getElementById("미리보기");
        const noImg   = document.getElementById("noImg");
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (event) {
                preview.src = event.target.result;
                preview.style.display = "block";
                if (noImg) noImg.style.display = "none";
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // TODO 1 : 프로필 사진 업로드
    // 힌트 : 파일은 JSON 으로 못 보냄 → FormData 사용
    // POST /user/profile/upload
    async function 프로필사진업로드() {
        const file = document.getElementById("imageFile").files[0];
        if (!file) { alert("파일을 선택하세요."); return; }

        const formData = new FormData();
        formData.append(???, file); // TODO 2 : append 키 이름 작성 (힌트: 컨트롤러 @RequestParam 이름과 맞춰야 함)

        const res = await fetch(???, {  // TODO 3 : 요청 주소 작성
            method: ???,                // TODO 4 : 전송 방식 작성
            body: formData              // Content-Type 헤더 직접 쓰면 안 됨 → 자동 설정됨
    });

        const data = await res.json();
        showAlert(res.ok ? "success" : "danger", data.message);
    }

    // TODO 5 : 유저 정보 수정
    // POST /user/profile/edit
    // Body : { name, email } JSON 으로 전송
    async function 정보수정() {
        const name  = document.getElementById(???).value.trim();  // TODO 6 : id 값 작성
        const email = document.getElementById(???).value.trim();  // TODO 7 : id 값 작성
        if (!name || !email) { alert("이름과 이메일을 입력하세요."); return; }

        const res = await fetch("/user/profile/edit", {
            method: "POST",
            headers: { ???: ??? },                        // TODO 8 : 헤더 작성 (힌트: JSON 전송 시 필요한 헤더)
        body: JSON.stringify({ ??? , ??? })            // TODO 9 : 전송할 데이터 작성
    });

        const data = await res.json();
        showAlert(res.ok ? ??? : ???, data.message);      // TODO 10 : 성공/실패 타입 작성
    }

    function showAlert(type, msg) {
        const el = document.getElementById("알림창");
        el.className = "alert alert-" + type;
        el.textContent = msg;
    }
</script>

<%@ include file="../common/footer.jsp" %>