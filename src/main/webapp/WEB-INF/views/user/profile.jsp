<!-- JSP 확장자는 스프링부트에서 지양하는 확장자이기 때문에 한글 인코딩 설정을 넣어줘야함
    우리나라는 JSP 형태로 웹 파일을 만들어왔기 때문에 아래와 같은 형식을 사용하는 습관 들여야한다.
-->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="container mt-5">
    <h2>내 프로필</h2>
    <!-- 프로필 사진 미리보기 -->
    <c:choose>
        <c:when test="${not empty user.profile_img}">
            <img src="${user.profile_img}" alt="프로필 사진" width="120">
        </c:when>
        <c:otherwise>
            <img id="미리보기" src="" style="display: none; width: 120px;">
            <p id="noImg">이미지가 없습니다.</p>
        </c:otherwise>
    </c:choose>

    <!-- 프로필 사진 수정하기 위한 업로드 폼 -->
    <form id="uploadForm" enctype="multipart/form-data">
        <input type="file" name="imageFile"  accept="image/*" onchange="미리보기기능(this)">
        <button type="button" onclick="프로필사진업로드()" class="btn btn-dark mt-2">저장하기</button>
    </form>

    <form id="editForm">

        <table class="table mt-3">
            <tr>
                <td>이름</td>
                <td><input type="text" id="name" value="${user.name}" class="form-control"></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="text" id="email" value="${user.email}" class="form-control"></td>
            </tr>
        </table>
        <button type="button" class="btn btn-dark" onclick="프로필정보수정()">저장하기</button>
    </form>
    <div id="메시지창" class="mt-3"></div>


    <table class="table mt-3">
        <tr>
            <td>이름</td>
            <td>${user.name}</td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>${user.email}</td>
        </tr>
        <tr>
            <td>가입일</td>
            <td>${user.created_at}</td>
        </tr>
    </table>

    <a href="/" class="btn btn-outline-dark">메인으로</a>
</div>

<script>
    function 파일을Base64로읽기(file) {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload  = (e) => ____;
            reader.onerror = () => ____;
            reader.readAsDataURL(____);
        });
    }

    async function 미리보기기능(input) {
        const preview = document.getElementById("미리보기");
        const noImg = document.getElementById("noImg");

        if (!____ || !____[0]) return;

        try {
            const dataUrl = await 파일을Base64로읽기(____);
            preview.src = ____;
            preview.style.display = "____";
            if (noImg) noImg.style.display = "____";

        } catch (err) {
            console.error("미리보기 실패:", err);
            alert("____");
        }
    }
    async function 프로필사진업로드() {
        const 메시지창 = document.getElementById("____");

        try {
            const formData = new FormData(document.getElementById("____"));

            const 응답 = await fetch("____", {
                method: "____",
                body: ____
            });

            if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);

            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            메시지창.innerHTML = "";
            메시지창.appendChild(____);

        } catch (err) {
            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            메시지창.innerHTML = "";
            메시지창.appendChild(____);
        }
    }

    async function 프로필정보수정() {
        const 메시지창 = document.getElementById("____");
        const data = Object.fromEntries(new FormData(document.getElementById("____")).entries());

        try {
            const 응답 = await fetch("____", {
                method: "____",
                headers: { "Content-Type": "____" },
                body: JSON.stringify(____)
            });

            if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);

            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            메시지창.innerHTML = "";
            메시지창.appendChild(____);

        } catch (err) {
            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            메시지창.innerHTML = "";
            메시지창.appendChild(____);
        }
    }
</script>


<%@ include file="../common/footer.jsp" %>