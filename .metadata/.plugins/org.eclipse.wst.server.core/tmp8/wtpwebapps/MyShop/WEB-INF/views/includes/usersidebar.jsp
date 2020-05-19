<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
  <!-- Page Content -->
  <div class="container my-5" style="min-height: 1000px">
    <div class="row">
      <div class="col-lg-3">
        <h1 class="my-4">마이페이지</h1>
        <div class="list-group">
          <a href="/myshop/user/update" class="list-group-item"><i class="fas fa-address-card"></i>&nbsp;&nbsp;회원 정보 수정</a>
          <a href="/myshop/product/cart?userid=<sec:authentication property="principal.username"/>" class="list-group-item"><i class="fas fa-shopping-cart"></i>&nbsp;&nbsp;장바구니</a>
          <a href="/myshop/product/order/list?userid=<sec:authentication property="principal.username"/>" class="list-group-item"><i class="fas fa-clipboard-list"></i>&nbsp;&nbsp;&nbsp;주문내역</a>
        </div>
      </div>
      <!-- /.col-lg-3 -->
