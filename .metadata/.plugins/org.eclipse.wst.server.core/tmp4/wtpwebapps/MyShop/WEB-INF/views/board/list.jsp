<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판</title>
</head>
<body>
	<jsp:include page="../includes/header.jsp" />
	<!-- Page Content -->
	<div class="container">
		<div class="card my-5">
			<div class="card-header">
			<i class="fas fa-table mr-1"></i>
				<c:if test="${type eq 1 }"> 공지사항</c:if>
				<c:if test="${type eq 2 }"> 질문과 답변</c:if>
				<c:if test="${type eq 3 }"> 자유게시판</c:if>	
				<div class="d-flex justify-content-center">
				<a href="/myshop/board/list?type=1" class="btn btn-outline-secondary mx-2">공지사항</a>
				<a href="/myshop/board/list?type=2" class="btn btn-outline-secondary mx-2">질문과 답변</a>
				<a href="/myshop/board/list?type=3" class="btn btn-outline-secondary mx-2">자유게시판</a>
				</div>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable">
						<thead>
							<tr>
								<th style="width: 10%">글 번호</th>
								<th style="width: 30%">제목</th>
								<th style="width: 20%">작성자</th>
								<th style="width: 30%">작성일</th>
								<th style="width: 20%">조회수</th>
							</tr>
							<c:forEach items="${list }" var="list">	
							<tr>
								<td>${list.bnum }</td>
								<td><a href="/myshop/board/get?bnum=${list.bnum }">${list.title }</a></td>
								<td>${list.userid }</td>
								<td><fmt:formatDate value="${list.regdate }" pattern="yyyy-MM-dd"/></td>
								<td>${list.viewcnt }</td>
							</tr>
							</c:forEach>
						</thead>
					</table>
				</div>			
				<c:if test="${type eq 1 }">
				<sec:authorize access='hasRole("ROLE_ADMIN")'>
					<div class="float-right">
						<a href="/myshop/board/admin/insert?type=1" class="btn btn-outline-primary">글쓰기</a>
					</div>		
				</sec:authorize>
				</c:if>
				<c:if test="${type eq 2}">								
				<sec:authorize access='hasRole("ROLE_USER")'>
					<div class="float-right">
						<a href="/myshop/board/insert?type=2" class="btn btn-outline-primary">글쓰기</a>
					</div>
				</sec:authorize>
				</c:if>
				<c:if test="${type eq 3}">								
				<sec:authorize access="isAuthenticated()">
					<div class="float-right">
						<a href="/myshop/board/insert?type=3" class="btn btn-outline-primary">글쓰기</a>
					</div>
				</sec:authorize>
				</c:if>
			</div>
		</div>
	</div>
	<!-- /.container -->
	<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>

</html>
