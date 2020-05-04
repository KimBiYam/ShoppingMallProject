<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
<div id="layoutSidenav_content">
                    <div class="container" style="min-height: 1000px;">
                        <div class="row justify-content-center">
                            <div class="col-lg-9 my-5">
                                        <form action="/myshop/board/modify" method="post">
                                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                        <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
                                        <input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
                                    	<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
										<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                                        <input type="hidden" value="${board. bno}" name="bno" id="bno">
                                            <div class="form-group">
                                            	<label class="small mb-1" for="title">제목</label>
                                            	<input class="form-control py-4" name="title" id="title" type="text" value="${board.title }" placeholder="제목을 입력하세요" />
                                           	</div>
	                                        <div class="form-group">
	                                        	<label class="small mb-1" for="writer">작성자</label>
	                                        	<input class="form-control py-4" name="writer" id="writer" type="text" value="${board.name }" readonly="readonly" />
                                        	</div>
                     						<div class="form-group">
												<label class="small mb-1" for="content">내용</label>
												<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력하세요">${board.content }</textarea>
											</div>
                                            <div class="form-group mt-4 mb-0">
                          	                	<div class="form-row justify-content-center">
                          	                <sec:authentication property="principal" var="pinfo"/>
                                            <sec:authorize access="isAuthenticated()">
                                            <c:if test="${pinfo.username eq board.writer }">
                                                <div class="col-md-2">
                                   	    	     	<button type="submit" class="btn btn-outline-primary btn-block" data-oper='modify'>수정</button>
                                            	</div>
                                            	<div class="col-md-2">
                                   	    	     	<button type="submit" class="btn btn-outline-danger btn-block" data-oper='delete'>삭제</button>
                                            	</div>
                                           	</c:if>
                                           	</sec:authorize>
                                   	            <div class="col-md-2">
                                          		  	<button type="submit" class="btn btn-outline-secondary btn-block" data-oper='list'>리스트</button>
                                       		  	</div>
                                              </div>
                                           	</div>
                                        </form>
                                    </div>
                            </div>
                        </div>
                    </div>
<script type="text/javascript">
$(function(){
	var formObj = $("form");

	$('button').on("click",function(e){
		e.preventDefault();

		var operation = $(this).data("oper");	

		if(operation == 'delete'){
			if(confirm("정말 삭제하시겠습니까?")){
				
			formObj.attr("action", "/myshop/board/delete");
			}else if(operation == 'list'){
				formObj.attr("action","/myshop/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();

				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				}
		}
		if($("#title").val()==""){
			alert("제목을 입력하세요");
			return false;
			}
		if($("#content").val()==""){
			alert("내용을 입력하세요");
			return false;
			}
		formObj.submit();
		})
		
})
</script>
<%@include file="../includes/footer.jsp"%>
</body>
