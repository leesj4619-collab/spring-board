<!-- JSP 확장자는 스프링부트에서 지양하는 확장자이기 때문에 한글 인코딩 설정을 넣어줘야함
    우리나라는 JSP 형태로 웹 파일을 만들어왔기 때문에 아래와 같은 형식을 사용하는 습관 들여야한다.
-->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TODO 5-2: header include --%>
<%@ include file="../common/header.jsp" %>

<div class="container mt-5">
    <h2>내 프로필</h2>

    <%-- TODO 5-3: 프로필 사진 분기
         조건: profile_img 가 비어있지 않으면 이미지 출력
               비어있으면 "이미지 없습니다" 텍스트 출력  --%>
    <c:choose>
        <c:when test="${not empty profile_img}">
            <img src="${user.profile_img}" alt="프로필 사진" width="120">
        </c:when>
        <c:otherwise>
            <p>이미지가 없습니다.</p>
        </c:otherwise>
    </c:choose>

    <%-- TODO 5-4: 유저 정보 출력 --%>
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

<%-- TODO 5-5: footer include --%>
<%@ include file="../common/footer.jsp" %>