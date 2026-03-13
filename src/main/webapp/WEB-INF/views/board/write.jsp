<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .미리보기이미지 {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 0.375rem;
            border: 1px solid #dee2e6;
        }
        .이미지개수-오류 {
            color: red;
        }
        .이미지개수-정상{
            color: #888;
        }
    </style>
</head>
<body class="bg-light"> <!-- 문서 몸통을 전반적으로 배경색 밝은 효과 -->

<div class="container mt-5" style="max-width: 600px;"> <!-- 여기서부터 페이지 전체 꾸미기 시작 아래와 여백을 5정도 주겠다. -->
    <div class="card p-4 shadow-sm"> <!-- 게시물 작성을 하나의 카드로 보겠다 padding 내부 여백은 4단계 카드틀의 그림자효과는 sm-->
        <h2 class="mb-4">새 게시물 작성</h2>
        <!-- 새 게시물 작성이라는 개발자가 지정한 제목과 클라이언트가 작성해야하는 공간과 4단계 정도 간격을 줄 것이다. -->

        <form action="/board/write" method="post" enctype="multipart/form-data">
            <div class="mb-3"> <!-- 제목 틀과 작성자 틀의 간격을 3단계 정도 두겠다. -->
                <label class="form-label">제목</label> <!-- input에 어떤 데이터를 작성해야하는지 설문-라벨 디자인 설정 -->
                <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요" required>
                <!-- input 태그내 클라이언트가 조작하는 공간의 디자인을 설정
                    폼 설문 안에서 사용자가 조작하는 태그 요소 디자인이다. input select textarea에서 사용
                -->
            </div>

            <div class="mb-3"> <!-- 작성자 틀과 내용 틀 간격을 3단계 정도 두겠다.-->
                <label class="form-label">작성자</label>
                <input type="text" name="writer" class="form-control" required>
            </div>

            <div class="mb-3"> <!-- 내용 틀과 이미지 첨부 틀 간격을 3단계 정도 두겠다.-->
                <label class="form-label">내용</label>
                <textarea name="content" class="form-control" rows="10" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">
                    이미지 첨부 <span class="text-muted">(최대 5장)</span><!-- text-muted 음소거 죽이다. 글씨를 죽여서 설명처럼 희미하게 -->
                </label>
                <input type="file" name="imageFiles" accept="image/*" multiple
                       class="form-control" onchange="미리보기기능(this)">
                <div id="이미지개수" class="small mt-1"></div><!-- 크기를 작게 글씨색상을 죽여서 미리보기 기능과 1단계 정도 간격을 주겠다.-->
            </div>
            <!--<img id="미리보기" src="" style="display:none;">-->
            <div id="미리보기" class="d-flex flex-wrap gap-2 mt-2 "></div>
            <!--
            display:flex div 내에 존재하는 태그들을 가로로 나란히 배치
            flex-wrap 태그가 너무 많아져서 한 줄에 들어오기 어려울 경우 자동으로 다음줄에 배치하겠다.
                      삐져나가거나 찌그러짐 없이 자연스럽게 줄바꿈 처리를 하겠다.
            gap : 태그별 간격
            1 = 4px
            2 = 8px
            5 = 32px
            -->
            <div class="text-center mt-4">
                <button type="button" onclick="저장하기기능()" class="btn btn-dark px-4">저장하기</button>
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
<script>
    function 미리보기기능(input) {
        // 이미지 개수 / 5장 초과시 경고 후 선택 초기화 하거나
        // 선택된 파일마다 미리보기 생성
        const 미리보기영역 = document.getElementById("미리보기");
        const 이미지개수 = document.getElementById("이미지개수");

        // 이미지 개수가 줄어들거나 이미지가 변경되면 이전 미리보기 없애기
        미리보기영역.innerHTML = ""; // 미리보기영역 내에 존재하는 태그들 모두 지우기

        const 파일들 = Array.from(input.files);

        // 5장 초과시 경고 후 선택 초기화
        if (파일들.length > 5) {
            이미지개수.textContent = "최대 5장 까지만 업로드 가능합니다.";
            이미지개수.className = "이미지개수-오류"
            // javaScript 에서 직접적으로 style 사용을 지양하여 style 권고하지는 않지만
            // <>태그.style. 이후 부터는 적용할 수 있는 스타일에 대하여 제안을 제공해준다.
            input.value = ""; // input 내에서  5개 이상 선택된 파일들을 모두 제거한다.
            return; // 5개 이상이 될경우 추가할 필요도없이 돌려보내기
        }

        이미지개수.textContent = "선택된 이미지 : " + 파일들.length + "장";
        이미지개수.className = "이미지개수-정상"

        //       if (input.files && input.files[0]) {
        파일들.forEach(function (파일하나) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const 이미지 = document.createElement("img");
                이미지.src = e.target.result;
                이미지.className = "rounded border object-fit-cover";
                이미지.className = "미리보기이미지"
                미리보기영역.appendChild(이미지);
            };
            reader.readAsDataURL(파일하나);
        });
    }
    /*
    function 저장하기기능() {
        const 제목 = document.querySelector("input[name='title']");
        const 작성자 = document.querySelector("input[name='writer']");
        const 내용 = document.querySelector("textarea[name='content']");

        if (!제목.value) {
            alert("제목을 입력하세요.");
            제목.focus();
            return;
        }
        if (제목.trim() === "") {
            alert("제목을 작성하시오.");
            제목.focus();
            return;
        }

        if (작성자.value.trim() === "") {
            alert("작성자를 입력하세요.");
            작성자.focus();
            return;
        }

        if (내용.value.trim() === "") {
            alert("내용을 입력하세요.");
            내용.focus();
            return;
        }

        // ④ 검증 통과 시 form 제출
        //  document.querySelector("form").submit();
        // querySelect 안에는 태그이름, 이름속성, 아이디속성, 클래스속성
        // 모든 것을 작성할 수 있다.             .아이디이름  #클래스이름

        // ai 가 추천하는 긴 로직을 작성하지 않아도
        // form 내부에 작성된 데이터들을 백엔드로 전송할 수 있다.
        // append 쓸 때는 추가적인 세부 커스텀이 필요할 때
        const formData = new FormData(document.querySelector("form"));

        fetch("/board/write", {
            method: "post",
            body: formData,
        })
            .then((res) => res.json())
            .then(결과 => {
                location.href = "/board/list";
            })
            .catch(err => console.log(err));


        /*
            AI 로 습득할 로직 = 레거시 방식
            const formData = new FormData();   // 파일 전송을 도와주는 javaScript 객체
            formData.append("title", 제목.value);
            formData.append("writer", 작성자.value);
            formData.append("content", 내용.value);

            const 파일들 = document.querySelector("input[name='imageFiles']").files;
            for (let i = 0; i < 파일들.length; i++) {
                formData.append("imageFiles", 파일들[i]);
            }

            fetch("/board/write", {
                method: "post",
                body: formData,
            })
                .then(res => res.json())
                .then(결과 => {
                    location.href = "/board/list";
                })
                .catch(err => console.log(err));


        * /
    }
     */
</script>
</body>
</html>