<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">
<%@include file="../includes/header.jsp"%>
<div class="container">
<div class="card mb-4" style="min-height: 1000px;">
	<div class="card-header">
		<i class="fas fa-table mr-1"></i>게시판</div>
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
				</thead>
				<c:forEach items="${list }" var="list" varStatus="st">
					<tr>
						<td><c:out value="${rowNo - st.index }"/></td>
						<td><a class="move" href="${list.bno }">${list.title }</a><b>[ <c:out value="${list.replycnt }"/> ]</b></td>
						<td>${list.writer }</td>
						<td><fmt:formatDate value="${list.regDate }" pattern="yyyy-MM-dd"/></td>
						<td>${list.viewcnt }</td>
					</tr>
				</c:forEach>
			</table>
			
			<div class="float-right">
				<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="page-item"><a class="page-link" href="${pageMaker.startPage -1 }">이전</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : "" } '><a class="page-link" href="${num }">${num }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item"><a class="page-link" href="${pageMaker.endPage +1 }">다음</a></li>
						</c:if>
				</ul>
			</div>
			<!-- end Pagination  -->
			<form id="searchForm" action="/myshop/board/list" method="get">
				<select name="type">
					<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
					<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
					<option value="TW"  <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
					<option value="TWC"  <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
				</select>
				<input type="text" name="keyword" />
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<button class="btn btn-outline-primary">검색</button>
			</form>
			<form id="actionForm" action="/myshop/board/list" method="get" >
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>'>
				<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>'>
			</form>		
			<sec:authorize access="isAuthenticated()">
			<div class="">
				<a class="btn btn-outline-primary" href="/myshop/board/register">글쓰기</a>
			</div>	
			</sec:authorize>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
	$(function() {

		var actionForm = $("#actionForm");

		$(".page-item a").on("click", function(e) {
			e.preventDefault();

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on("click", function(e){

			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/myshop/board/get");
			actionForm.submit();
			
			});

		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click",function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요")	;
				return false;	
				}

			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;	
				}

			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();

			searchForm.submit();
			
			});
			
	});
</script>
<%@include file="../includes/footer.jsp"%>
</body>
</html>

