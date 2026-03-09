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

        <table class="table mt-3">
            <tr>
                <td>이름</td>
                <td>
                    <input type="text" name="name" value="${user.name}" class="form-control">
                </td>
            </tr>
            <tr>
                <td>이메일</td>
                <td>
                    <input type="text" name="email" value="${user.email}" class="form-control">
                </td>
            </tr>
            <tr>
                <td>가입일</td>
                <td>${user.created_at}</td>
            </tr>
        </table>

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
</script>


<%@ include file="../common/footer.jsp" %>