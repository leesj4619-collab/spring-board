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
    <form action="/user/profile/upload" method="post" enctype="multipart/form-data">
        <input type="file" name="imageFile" accept="image/*" onchange="미리보기기능(this)">
        <button class="btn btn-dark mt-2">저장하기</button>
    </form>

    <form action="/user/profile/edit" method="post">

        <!-- Todo 14: form 의 action/method 제거하고 버튼을 type="button" + onclick 으로 변경 -->
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
        <button type="button" class="btn btn-dark" onclick="정보수정기능()">저장하기</button>

        <button type="submit" class="btn btn-dark">저장하기</button>
    </form>

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
    function 미리보기기능(input) {
        const preview = document.getElementById("미리보기");
        const noImg = document.getElementById("noImg");

        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (event) {
                preview.src = event.target.result;
                preview.style.display = "block";
                if(noImg) {
                    noImg.style.display = "none";
                }
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
        function 정보수정기능() {
        const 이름 = document.getElementById(???).value;
        const 이메일 = document.getElementById(???).value;

        fetch("/user/profile/edit", {
        method: ???,  // 힌트: POST
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify({
        name: ???,   // 힌트: 이름 변수
        email: ???   // 힌트: 이메일 변수
    })
    })
        .then(res => res.json())
        .then(결과 => {
        if (결과.msg) {
        // Todo 15: 성공 메세지 alert 후 프로필 페이지로 이동
        alert(???);
        location.href = ???;  // 힌트: 프로필 페이지 주소
    } else {
        alert(결과.error);
    }
    })
        .catch(err => console.log("요청 실패:", err));
    }
</script>


<%@ include file="../common/footer.jsp" %>