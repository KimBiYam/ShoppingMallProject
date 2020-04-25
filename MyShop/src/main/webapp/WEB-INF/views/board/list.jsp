<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
	<div class="container my-5" style="min-height: 1000px">
		<div class="card my-5">
			<div class="card-header">
				<i class="fas fa-align-justify"></i>
				<c:if test="${btype eq 1 }"> 공지사항</c:if>
				<c:if test="${btype eq 2 }"> 질문과 답변</c:if>
				<c:if test="${btype eq 3 }"> 자유게시판</c:if>
				<div class="d-flex justify-content-center">
					<a href="/myshop/board/list?btype=1"
						class="btn btn-outline-secondary mx-2">공지사항</a> <a
						href="/myshop/board/list?btype=2"
						class="btn btn-outline-secondary mx-2">질문과 답변</a> <a
						href="/myshop/board/list?btype=3"
						class="btn btn-outline-secondary mx-2">자유게시판</a>
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
									<td><a href="/myshop/board/get?bnum=${list.bnum }">${list.title }</a>
										<b>[ <c:out value="${list.commentcnt }" /> ]
									</b></td>
									<td>${list.userid }</td>
									<td><fmt:formatDate value="${list.regdate }"
											pattern="yyyy-MM-dd" /></td>
									<td>${list.viewcnt }</td>
								</tr>
							</c:forEach>
						</thead>
					</table>

					<div class="float-right">
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.startPage -1 }">이전</a></li>
							</c:if>
							<c:forEach var="num" begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }">
								<li
									class='page-item ${pageMaker.cri.pageNum == num ? "active" : "" } '><a
									class="page-link" href="${num }">${num }</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next}">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.endPage +1 }">다음</a></li>
							</c:if>
						</ul>
					</div>
					<!-- end Pagination  -->
					<form id="searchForm" action="/myapp/board/list" method="get">
						<select name="type">
							<option value=""
								<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
							<option value="T"
								<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
							<option value="C"
								<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
							<option value="W"
								<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
							<option value="TC"
								<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목
								or 내용</option>
							<option value="TW"
								<c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목
								or 작성자</option>
							<option value="TWC"
								<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목
								or 내용 or 작성자</option>
						</select> <input type="text" name="keyword" /> <input type="hidden"
							name="pageNum" value="${pageMaker.cri.pageNum }"> <input
							type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<button class="btn btn-outline-primary">검색</button>
					</form>
					<form id="actionForm" action="/myapp/board/list" method="get">
						<input type="hidden" name="pageNum"
							value="${pageMaker.cri.pageNum }"> <input type="hidden"
							name="amount" value="${pageMaker.cri.amount }"> <input
							type="hidden" name="type"
							value='<c:out value="${pageMaker.cri.type }"/>'> <input
							type="hidden" name="keyword"
							value='<c:out value="${pageMaker.cri.keyword }"/>'>
					</form>
				</div>
				<c:if test="${btype eq 1 }">
					<sec:authorize access='hasRole("ROLE_ADMIN")'>
						<div class="float-right">
							<a href="/myshop/board/admin/insert?btype=1"
								class="btn btn-outline-primary">글쓰기</a>
						</div>
					</sec:authorize>
				</c:if>
				<c:if test="${btype eq 2}">
					<sec:authorize access='hasRole("ROLE_USER")'>
						<div class="float-right">
							<a href="/myshop/board/insert?btype=2"
								class="btn btn-outline-primary">글쓰기</a>
						</div>
					</sec:authorize>
				</c:if>
				<c:if test="${btype eq 3}">
					<sec:authorize access="isAuthenticated()">
						<div class="float-right">
							<a href="/myshop/board/insert?btype=3"
								class="btn btn-outline-primary">글쓰기</a>
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
