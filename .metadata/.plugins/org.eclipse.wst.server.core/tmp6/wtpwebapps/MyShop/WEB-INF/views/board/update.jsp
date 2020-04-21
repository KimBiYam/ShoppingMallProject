<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-lg-9 my-5">			
			<c:if test="${board.type eq 1 }">
				<form id="boardUpdate" action="/myshop/board/admin/update" method="post">
			</c:if>
			<c:if test="${board.type eq 2 || board.type eq 3 }">
				<form id="boardUpdate" action="/myshop/board/update" method="post">
			</c:if>
					<input type="hidden" name="bnum" value="${board.bnum }">
					<input type="hidden" name="type" value="${board.type }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<div class="form-group">
						<label class="small mb-1" for="title">제목</label> <input class="form-control py-4" name="title" id="title" type="text" value="${board.title }" placeholder="제목을 입력하세요" />
					</div>
					<div class="form-group">
						<label class="small mb-1" for="userid">작성자</label> <input
							class="form-control py-4" name="userid" id="userid" type="text" value='${board.userid }' readonly="readonly" />
					</div>
					<div class="form-group">
						<label class="small mb-1" for="regdate">작성일</label> <input
							class="form-control py-4" type="text" value='<fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd"/>' readonly="readonly" />
					</div>
					<div class="form-group">
						<label class="small mb-1" for="content">내용</label>
						<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력하세요">${board.content }</textarea>
					</div>
					<div class="form-group mt-4 mb-0">
						<div class="form-row justify-content-center">
							<div class="col-md-2">
								<button class="btn btn-outline-primary btn-block" id="btnUpdate">수정하기</button>
							</div>
							<c:if test="${board.type eq 1 }">
							<div class="col-md-2">
								<button type="button" class="btn btn-outline-danger btn-block" id="btnAdminDelete">삭제하기</button>
							</div>
							</c:if>
							<c:if test="${board.type eq 2 || board.type eq 3 }">
							<div class="col-md-2">
								<button type="button" class="btn btn-outline-danger btn-block" id="btnDelete">삭제하기</button>
							</div>
							</c:if>
							<div class="col-md-2">
								<a class="btn btn-outline-secondary btn-block" href="/myshop/board/list?type=${board.type }">리스트</a>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.container -->
		<script type="text/javascript">
		$(function() {
			$("#btnAdminDelete").on("click",function(){
				if(confirm("정말 삭제하시겠습니까?")){
					location.href="/myshop/board/admin/delete?bnum=${board.bnum }&type=${board.type}";
					}								
				});
			$("#btnDelete").on("click",function(){
				if(confirm("정말 삭제하시겠습니까?")){
					location.href="/myshop/board/delete?bnum=${board.bnum }&type=${board.type}";
					}								
				});
			$("#btnUpdate").on("click", function() {
				if ($("#title").val() == "") {
					alert("제목을 입력하세요");
					$("#title").focus();
					return false;
				}
				if ($("#content").val() == "") {
					alert("내용을 입력하세요");
					$("#content").focus();
					return false;
				}
				$("#boardUpdate").submit();
			});
		});
	</script>
  <jsp:include page="../includes/footer.jsp"></jsp:include>
</body>
</html>
