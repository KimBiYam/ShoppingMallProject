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
                                        <form id="boardRegister" action="/myshop/board/register" method="post">
                                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                        <input type="hidden" name="writer" value='<sec:authentication property="principal.username"/>'>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="title">제목</label>
                                            	<input class="form-control py-4" name="title" id="title" type="text" placeholder="제목을 입력하세요" />
                                           	</div>
	                                        <div class="form-group">
	                                        	<label class="small mb-1" for="name">작성자</label>
	                                        	<input class="form-control py-4" name="name" id="name" type="text" value="${name }" readonly="readonly" />
                                        	</div>
                     						<div class="form-group">
												<label class="small mb-1" for="content">내용</label>
												<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력하세요"></textarea>
											</div>
                                            <div class="form-group mt-4 mb-0">
                           	                  <div class="form-row justify-content-center">
                                                <div class="col-md-2">
                                   	    	     	<button type="button" id="btnWrite" class="btn btn-outline-primary btn-block" data-oper='register'>작성</button>
                                            	</div>
                                   	            <div class="col-md-2">
                    		  						<a href="/myshop/board/list" class="btn btn-outline-secondary btn-block" data-oper='list'>리스트</a>
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
	$("#btnWrite").click(function(){
		if($("#title").val()==""){
			alert("제목을 입력하세요");
			return false;
			}
		if($("#content").val()==""){
			alert("내용을 입력하세요");
			return false;
			}		
		$("#boardRegister").submit();
		})
})
</script>
<%@include file="../includes/footer.jsp"%>
</body>
