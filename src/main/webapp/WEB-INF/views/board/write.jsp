<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 600px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4">새 게시물 작성</h2>

        <form action="/board/write" method="post">
            <div class="mb-3">
                <label class="form-label">제목</label>
                <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label class="form-label">작성자</label>
                <input type="text" name="writer" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">내용</label>
                <textarea name="content" class="form-control" rows="1" required></textarea>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-dark px-4">저장하기</button>
                <!--
                    <button> 태그 type = submit, button, reset
                    버튼 태그에서 type을 작성하지 않은 버튼의 기본값
                    <button>저정하기</button> ====> submit

                    <button type="submit">저장하기</button> = <button>저정하기</button>
                    type = submit
                        form에 작성된 데이터를 action 주소로 전송
                        별도의 자바스크립트가 없어도 페이지가 새로고침되며 데이터를 서버로 보냄
                        의도치 않게 페이지가 넘어갈 수 있으므로, 단순 클릭 이벤트만 주고 싶을 때 피해야함

                    ⭐⭐⭐<button type="button">저장하기</button>⭐⭐⭐
                    type = button
                        단순 버튼 이 버튼은 클릭해도 아무런 변화가 일어나지 않는 버튼
                        자체적으로 전송도, 초기화도 하지 않는 깡통 버튼
                        javaScript와 연결할 때 사용
                        id나 onClick을 이용해서 개발자나 기획자가 원하는 흐름대로 클라이언트의 작성을
                        유도할 수 있도록 설정하기 위해 사용
                        데이터를 SQL이나 특정 사이트로 전송하기 전 입력값 검증(빈칸 체크 등)을 하고 싶을 때 사용
                        가장 많이 사용
                        form 내부에 button이 존재하는지에 대하여 크게 개연을 받지 않음 form 외부에 있어도
                        자바스크립트로 기능 연결만 태그에 잘 해준다면 form 외부에 존재해도 되는 버튼

                    <button type="reset">초기화</button>
                    type = "reset"
                        form 내부에 버튼이 존재하고, form 안에 입력된 모~든 값을 처음 상태로 되돌림
                        사용자가 입력한 input, textarea 등의 내용을 싹 지워줌(서버로 전송하지 않음)
                        회원가입 폼 등에서 다시쓰기 버튼을 만들 때 사용

                    type = "submit" "reset" form 태그 내부에 button 존재한다는 전제함
                    type = "button" 아무런 기본 속성이 없으며, 개발자가 원하는 방향대로
                            버튼 태그 내부 모든 속성을 커스텀 할 때 사용
                 -->
                <a href="/board/list" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>