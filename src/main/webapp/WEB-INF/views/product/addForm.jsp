<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="../common/header.jsp"%>
<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4 text-center fw-bold">제품추가</h2>
        <form action="/product/add" method="post">
            <div class="mb-3">
                <label class="form-label">제품명</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">가격</label>
                <input type="number" name="price" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">재고</label>
                <input type="number" name="stock" class="form-control" required>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-dark">등록</button>
                <a href="/product/list" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>