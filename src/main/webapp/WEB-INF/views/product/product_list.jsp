<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="../common/header.jsp" %>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold">제품 목록</h2>
        <a href="/product/add" class="btn btn-dark">+ 제품 추가</a>
    </div>

    <c:if test="${not empty msg}">
        <div class="alert alert-success">${msg}</div>
    </c:if>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th><th>제품명</th><th>가격</th><th>재고</th><th>등록일</th><th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td><fmt:formatNumber value="${p.price}" pattern="#,###"/>원</td>
                <td>${p.stock}</td>
                <td>${p.created_at}</td>
                <td>
                    <a href="/product/edit?id=${p.id}" class="btn btn-sm btn-warning">수정</a>
                    <a href="/product/delete?id=${p.id}" class="btn btn-sm btn-danger"
                       onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>