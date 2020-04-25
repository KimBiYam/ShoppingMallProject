<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
<div id="layoutSidenav_content">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-9 my-5">
                                        <form id="boardRegister" action="/myshop/board/register" method="post">
                                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                            <div class="form-group">
                                            	<label class="small mb-1" for="title">제목</label>
                                            	<input class="form-control py-4" name="title" id="title" type="text" placeholder="제목을 입력하세요" />
                                           	</div>
	                                        <div class="form-group">
	                                        	<label class="small mb-1" for="writer">작성자</label>
	                                        	<input class="form-control py-4" name="writer" id="writer" type="text" value='<sec:authentication property="principal.username"/>' readonly="readonly" />
                                        	</div>
                     						<div class="form-group">
												<label class="small mb-1" for="content">내용</label>
												<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력하세요"></textarea>
											</div>
                                            <div class="form-group mt-4 mb-0">
                           	                  <div class="form-row justify-content-center">
                                                <div class="col-md-2">
                                   	    	     	<button class="btn btn-outline-primary btn-block" id="btnWrite">작성</button>
                                            	</div>
                                   	            <div class="col-md-2">
                                          		  	<a class="btn btn-outline-secondary btn-block" href="/myshop">리스트</a>
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
