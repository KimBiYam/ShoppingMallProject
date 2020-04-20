<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>글쓰기</title>
</head>

<body>
<jsp:include page="../includes/header.jsp"/>
  <!-- Page Content -->
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-9 my-5">			
			<c:if test="${type == 1 }">
				<form id="boardInsert" action="/myshop/board/admin/insert" method="post">
			</c:if>
			<c:if test="${type == 2 || type == 3 }">
				<form id="boardInsert" action="/myshop/board/insert" method="post">
			</c:if>
					<input type="hidden" name="board_type" value="${type }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<div class="form-group">
						<label class="small mb-1" for="board_title">제목</label> <input class="form-control py-4" name="board_title" id="board_title" type="text"
							placeholder="제목을 입력하세요" />
					</div>
					<div class="form-group">
						<label class="small mb-1" for="user_id">작성자</label> <input
							class="form-control py-4" name="user_id" id="user_id" type="text" value='<sec:authentication property="principal.username"/>' readonly="readonly" />
					</div>
					<div class="form-group">
						<label class="small mb-1" for="board_content">내용</label>
						<textarea class="form-control" rows="5" name="board_content" id=board_content placeholder="내용을 입력하세요"></textarea>
					</div>
					<div class="form-group mt-4 mb-0">
						<div class="form-row justify-content-center">
							<div class="col-md-2">
								<button class="btn btn-outline-primary btn-block" id="btnWrite">작성</button>
							</div>
							<div class="col-md-2">
								<a class="btn btn-outline-secondary btn-block" href="/myshop/board/list?type=${type }">리스트</a>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
	<!-- /.container -->
  <jsp:include page="../includes/footer.jsp"></jsp:include>

</body>

</html>