<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${board.title} - 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 800px;">
    <div class="card shadow-sm p-4">
        <h2 class="fw-bold">${board.title}</h2>

        <div class="text-muted mb-4">
            작성자: ${board.writer} | 작성일: ${board.created_at} | 조회수: ${board.view_count}
        </div>

        <hr>

        <div class="py-3" style="min-height: 200px; white-space: pre-wrap;">
            ${board.content}
        </div>

        <hr>

        <div class="text-end">
            <a href="/board/list" class="btn btn-outline-secondary">목록으로</a>

            <a href="/board/edit?no=${board.board_no}" class="btn btn-warning">수정</a>
            <%--
            <button type="button" class="btn btn-danger"
                    onclick="location.href='/board/delete?no=${board.delete}'">삭제</button>

                    주석에 차이!
                    <!-- -->은   자바에서 가져오는 변수를 작성한 공간까지 모두 전체 주석${ }
                    < % -- -- % >은  자바에서 가져오는 변수는 주석처리가 안됨 jsp 확장자 안에서는 되도록이
            --%>

            <button type="button" class="btn btn-danger"
                    onclick="게시물삭제기능${board.board_no}">삭제</button>
        </div>
    </div>
</div>
<script>
    function 게시물삭제기능(board_no) {
        if(confirm("정말 삭제하시겠습니까?")){
            location.href = "/board/delete?no=" + board_no;
        }
    }
</script>

</body>
</html>