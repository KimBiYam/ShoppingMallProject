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
<title>주문 관리</title>
</head>
<body>
	<jsp:include page="../../includes/header.jsp" />
	<div class="my-5 container" style="min-height: 1000px">
		<div class="row text-center justify-content-center">
			<h1 class="my-5 text-center">주문 관리</h1>
			<table class="table">
				<tr>
					<th>주문번호</th>
					<th>주문일</th>
					<th>배송 주소지</th>
					<th>전화번호</th>
					<th>주문승인결과</th>
				</tr>
				<c:forEach items="${orderlist }" var="orderlist">
					<tr>
						<td><a href="/myshop/product/order/admin/get?ordercode=${orderlist.ordercode }">${orderlist.rownum }</a></td>
						<td><fmt:formatDate value="${orderlist.orderdate }" /></td>
						<td>${orderlist.addr }</td>
						<td>${orderlist.tel }</td>
						<td>${orderlist.approval }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
	<jsp:include page="../../includes/footer.jsp"></jsp:include>

	<script type="text/javascript">
		
	</script>
</body>

</html>
