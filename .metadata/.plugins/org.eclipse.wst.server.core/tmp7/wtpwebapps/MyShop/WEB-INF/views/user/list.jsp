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
	<div class="container">
		<div class="card my-5">
			<div class="card-header">
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable">
							<thead>
								<tr>
									<th style="width: 10%">ID</th>
									<th style="width: 10%">이름</th>
									<th style="width: 10%">휴대전화</th>
									<th style="width: 10%">이메일</th>
									<th style="width: 10%">우편번호</th>
									<th style="width: 25%">주소</th>
									<th style="width: 15%">가입일</th>
									<th style="width: 10%">삭제</th>
								</tr>
								<c:forEach items="${user }" var="user">
									<tr>
										<td>${user.userid }</td>
										<td>${user.username }</td>
										<td>${user.tel }</td>
										<td>${user.email }</td>
										<td>${user.zipcode }</td>
										<td>${user.addr }</td>
										<td><fmt:formatDate value="${user.joined }" pattern="yyyy-MM-dd"/></td>
										<td><a href="javascript:userDelete('${user.userid }')">삭제</a></td>
									</tr>
								</c:forEach>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.container -->
	<script type="text/javascript">
		function userDelete(userid){
			if(confirm("정말 삭제 하시겠습니까?")){
				location.href="/myshop/admin/delete?userid="+userid;
				}
			}
	</script>
	<jsp:include page="../includes/footer.jsp"></jsp:include>
</body>

</html>
