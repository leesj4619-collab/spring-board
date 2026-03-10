<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 100%">
    <div class="fw-bold mb-4">게시물 수정</div>
    <form action="/board/edit" method="post">
     <input type="hidden" name="board_no" value="${board.board_no}">

     <div class="mb-3">
        <label for="title" class="form-label fw-semibold">제목</label>
        <input type="text" id="title" name="title" class="form=control" rows="10" value="${board.title}"
         required>
     </div>

     <div class="mb-3">
             <label for="content" class="form-label fw-semibold">제목</label>
             <input type="text" id="content" name="content" class="form=control" rows="10" value="${board.content}"
                required>
          </div>
     <div class="text-end">
        <a href="/board/detail?no=${board.board_no}" class="btn btn-outline-secondary">취소</a>
        <button class="btn btn-warning">수정완료</button>
     </div>
    </form>
</body>
</html>