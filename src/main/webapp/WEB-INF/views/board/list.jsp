<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
uri http://java.sun.com/jsp/jstl/core을(를) 가진 taglib를 해결할 수 없습니다
☆이러한 문제가 발생했을 경우 해결하는 방법!☆
1.  반드시 pom.xml이나 build.gradle설정 파일로 가서
    JSTL의 관련 설정이 존재하는지 확인하기 !!!
    maven.com에서 나와있는 gradel 모듈 주소 설정
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
    implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api'
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl'

    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
    -> jsp 확장자 사용할 수 있는 모듈 세팅

    아래 두가지는 한 세트
    implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api'
    ->c:if c:forEach 문법들을 사용해야하는 문법 규칙 정의서
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl'
    -> 문법 저의서에 작성되어 있는 기능 명칭들의 실질적인 기능 코드들이 담겨 있다.

    위와 같은 문법들 다 외워야하는가? noop
    www.maven.com 곳에서 pom.xml 형식이나 gradle 형식을 복사 붙여넣기 할 수 있다.
    AI에게 도움을 요청해서 필요한 모듈에 대하여 전달받을 수 있다.
--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">게시물 목록</h2>

    <table class="table table-hover shadow-sm bg-white">
        <thead class="table-dark">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="board" items="${boardLists}">
            <tr>
                <td>${board.board_no}</td>
                <td>
                    <a href="/board/detail?no=${board.board_no}" class="text-decoration-none">
                        ${board.title}
                    </a>
                </td>
                <td>${board.writer}</td>
                <td>${board.created_at}</td>
                <td>${board.view_count}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="text-end mt-3">
        <a href="/board/write" class="btn btn-dark">글쓰기</a>
        <a href="/" class="btn btn-outline-secondary">홈으로</a>
    </div>
</div>

</body>
</html>