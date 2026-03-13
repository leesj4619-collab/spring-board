<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유저 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4 text-center fw-bold">이메일로 유저 찾기</h2>

        <form action="/user/find" method="post">
            <div class="mb-3">
                <label class="form-label">이메일</label>
                <input type="email" name="email" class="form-control" placeholder="이메일을 입력하세요">
            </div>
            <div class="d-grid">
                <button type="button" onclick="이메일찾기기능()" id="searchBtn" class="btn btn-dark">검색</button>
            </div>
        </form>

        <c:if test="${user != null}">
            <hr class="mt-4">
            <h5 class="mt-3 fw-bold">조회 결과</h5>
            <table class="table mt-3">
                <tr>
                    <th>이름</th>
                    <td>${user.name}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                        <%-- TODO 10. 유저 이메일을 출력하시오 --%>
                    <td>${user.email}</td>
                </tr>
                <tr>
                    <th>가입일</th>
                        <%-- TODO 11. 유저 가입일을 출력하시오 --%>
                    <td>${user.created_at}</td>
                </tr>
            </table>
        </c:if>

        <%-- TODO 12. 이메일이 존재하지 않을 때 에러 메시지를 출력하시오 --%>
        <%-- 조건 : param.error == 'notfound' 일 때 --%>
        <c:if test="${param.error == 'notfound'}">
            <div class="alert alert-danger mt-4">존재하지 않는 이메일입니다.</div>
        </c:if>

    </div>
</div>

<script>
    async function 이미일찾기기능() {
        // .변수이름 .메서드이름()
        const 이름 = document.getElementById("name").value;
        const 결과창 = document.getElementById("결과창");         // const 결과창 = html문서에서 .id값이 "결과창"인태그에 대한 모든 정보 보관
        const 검색버튼 = document.getElementById("searchBtn");   // const 검색버튼 = html문서에서 .id값이 "searchBtn"인태그에 대한 모든 정보 보관
        // == : 타입은 크게 중요하지 않은 상태에서 데이터 비교하여 동일한지 확인 결과 : true / false
        // === : 타입은 중요하게 생각하는 상태에서 데이터 비교하여 동일한지 확인 결과 : true / false
        if(이름.trim() === "") {
            alert("이름을 입력해주세요.");
            return; // 회사나 개발자가 원하는 요구 조건에 일치하지 않기 때문에 아래 기능을 실행하지 못하게 하기 위하여 돌려보내기
        }
        검색버튼.disabled= true;
        검색버튼.textContent = "검색중입니다.";
        결과창.innerHTML = '<div class="text-center text-muted">검색중입니다..</div>';

        try {
            const 결과 = await fetch("/user/find-email", {
                method : "POST",
                headers :{"Content-Type": "application/json"},
                body : JSON.stringify({name: 이름})
            });

            const json_변환_결과 = await res.json();

            if(json_변환_결과.email) {
                결과창.innerHTML = '<div class = "alert alert-success">이메일 : ${json_변환_결과.email}</div>';
            } else {
                결과창.innerHTML = '<div class = "alert alert-warning">해당 이름의 유저를 찾을 수 없습니다.</div>';
            }
        } catch (error) {
            console.log(error);
            결과창.innerHTML = '<div class = "alert alert-warning">오류가 발생했습니다. : 고객센터에 문의하세요.</div>';
        } finally {
            검색버튼.disabled = false;
            검색버튼.textContent = "검색";
        }


        // Btn BuTtoN에서 가져온 명칭
    }




      /*
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
    function 이메일찾기기능() {
        const 이름 = document.getElementById(email).value;  // 힌트: input id 값

        if (이름.trim() === "") {
            alert("이름을 입력해주세요.");
            return;
        }

        fetch("/user/find-email", {
                method: POST,  // 힌트: POST
            headers: {"Content-Type": "application/json"},
        body: JSON.stringify({ name: 이름 })  // 힌트: 이름 변수 넣기

    .then(res => res.json())
            .then(결과 => {
                const 결과창 = document.getElementById("결과창");
                if (결과.email) {
                    // Todo 12: 이메일이 있을 때 결과창에 표시하는 HTML 작성
                    결과창.innerHTML = <div className="alert alert-success"> 이메일: ${결과.email} </div>;
                    // 힌트: <div class="alert alert-success"> 이메일: ${결과.email} </div>
                } else {
                    // Todo 13: 에러일 때 결과창에 표시하는 HTML 작성
                    결과창.innerHTML = <div className="alert alert-danger"> 에러 메세지 표시 </div>;
                    // 힌트: <div class="alert alert-danger"> 에러 메세지 표시 </div>
                }
            })
            .catch(err => console.log("요청 실패:", err));

    })
    }
 */
</script>
</body>
</html>