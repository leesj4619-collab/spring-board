<%--
각 jsp 마다
page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" 를 작성해야
한글을 웹사이트로 전달할 때 깨지지않고, 보이게 설정할 수 있다.

applicattion.properties에서
server.servlet.encoding.charset=UTF-8
server.servlet.force=true
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="common/header.jsp" %>

<section class="hero text-center">
    <div class="container">
        <h1>Spring 게시판에 오신 것을 환영합니다.</h1>
        <p class="mt-3">봄같은 게시판 입니다.</p>
        <a href="/board/list" class="btn btn-dark mt-3 px-4">게시판 바로가기</a>
    </div>
</section>


<section class="py-5">
    <div class="container">
        <div class="row g-4 justify-content-center">
            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📝</div>
                    <h5 class="mt-3 fw-bold">게시물 작성</h5>
                    <p class="text-muted">새로운 게시물을 작성해보세요.</p>
                    <a href="/board/write" class="btn btn-outline-dark mt-auto">작성하기</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📜</div>
                    <h5 class="mt-3 fw-bold">게시물 목록</h5>
                    <p class="text-muted">등록된 게시물을 확인세요.</p>
                    <a href="/board/list" class="btn btn-outline-dark mt-auto">목록보기</a>
                </div>
            </div>

        </div>
    </div>
</section>

<%-- TODO 6. footer.jsp 를 include 하시오 --%>
<%@ include file="common/footer.jsp" %>

