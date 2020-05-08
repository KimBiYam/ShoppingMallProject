<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@include file="../includes/header.jsp"%>
<div class="container" style="min-height: 1000px;">
	<div class="row justify-content-center">
		<div class="col-lg-9 my-5">
			<input type="hidden" name="writer" id="writer"
				value="${board.writer }">
			<div class="form-group">
				<label class="small mb-1" for="title">제목</label> <input
					class="form-control py-4" name="title" id="title" type="text"
					value="${board.title }" disabled="disabled" />
			</div>
			<div class="form-group">
				<label class="small mb-1" for="name">작성자</label> <input
					class="form-control py-4" name="name" id="name" type="text"
					value="${board.name }" disabled="disabled" />
			</div>
			<div class="form-group">
				<label class="small mb-1" for="writer">작성일</label> <input
					class="form-control py-4" type="text"
					value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />'
					disabled="disabled" />
			</div>
			<div class="form-group">
				<label class="small mb-1" for="content">내용</label>
				<textarea class="form-control" rows="5" name="content" id="content"
					disabled="disabled">${board.content }</textarea>
			</div>
			<div class="form-group mt-4 mb-0">
				<div class="row justify-content-center">
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<div class="col-md-2">
								<button class="btn btn-outline-primary btn-block"
									data-oper='modify'>수정</button>
							</div>
						</c:if>
					</sec:authorize>
					<div class="col-md-2">
						<button class="btn btn-outline-secondary btn-block"
							data-oper='list'>리스트</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-center">
		<div class="col-lg-9 my-5">
			<!-- /.panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<sec:authorize access="isAuthenticated()">
						<button id='addReplyBtn'
							class='btn btn-primary btn-xs float-right'>댓글 쓰기</button>
						<br>
						<br>
						<br>
						<div class="dropdown-divider"></div>
					</sec:authorize>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
					</ul>
					<!-- ./ end ul -->
				</div>
				<!-- /.panel .chat-panel -->
				<div class="panel-footer"></div>
			</div>
		</div>
		<!-- ./ end row -->
	</div>
</div>
<form id="operForm" action="/myshop/board/modify" method="get">
	<input type="hidden" id="bno" name="bno"
		value='<c:out value="${board.bno }"/>'> <input type="hidden"
		name="pageNum" value='<c:out value="${cri.pageNum }"/>'> <input
		type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
	<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
	<input type="hidden" name="keyword"
		value='<c:out value="${cri.keyword }"/>'>
</form>
<!-- Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" name="replyer" id="replyer" value="replyer">
				<div class="form-group">
					<label>내용</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='name'
						id="replyName" value=${name } disabled="disabled">
				</div>
				<div class="form-group">
					<label>작성일</label> <input class="form-control" name='replyDate'
						value='2018-01-01 13:13'>
				</div>
			</div>
			<div class="modal-footer">
				<sec:authorize access="isAuthenticated()">
					<button id='modalModBtn' type="button" class="btn btn-warning">수정하기</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제하기</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">글쓰기</button>
				</sec:authorize>
				<button id='modalCloseBtn' type="button"
					class="btn btn-outline-secondary">닫기</button>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->




<script type="text/javascript" src="/myshop/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
						var bnoValue = '<c:out value="${board.bno}"/>';
						var replyUL = $(".chat");
						showList(1);

						function showList(page) {
							console.log("show list " + page);
							replyService.getList(
											{
												bno : bnoValue,
												page : page || 1
											},
											function(replyCnt, list)
											 {
												console.log("replyCnt: " + replyCnt);
												console.log("list: " + list);
												console.log(list);
												if (page == -1) {
													pageNum = Math.ceil(replyCnt / 10.0);
													showList(pageNum);
													return;
												}

												var str = "";

												if (list == null || list.length == 0) {
													replyUL.html("");
												}

												
												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
													str += "<div><div class='header'><strong class='primary-font'>["+eval(1+i)+"]"
															+list[i].name+"</strong>";
													str += "<small class='float-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
													str += "<p>"+list[i].reply+"</p></div></li>";
													str += "<div class='dropdown-divider'></div>";
												}

												replyUL.html(str);

												showReplyPage(replyCnt);

											});//end function

						}//end showList

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");

						function showReplyPage(replyCnt) {
							//	alert("replyCnt :"+ replyCnt)

							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum - 9;

							var prev = startNum != 1;
							var next = false;

							if (endNum * 10 >= replyCnt) {
								endNum = Math.ceil(replyCnt / 10.0);
							}

							if (endNum * 10 < replyCnt) {
								next = true;
							}
							// alert("endNum :"+ endNum)

							var str = "<ul class='pagination pull-right'>";

							if (prev) {
								str += "<li class='page-item'><a class='page-link' href='"
										+ (startNum - 1)
										+ "'>Previous</a></li>";
							}

							for (var i = startNum; i <= endNum; i++) {

								var active = pageNum == i ? "active" : "";

								str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"
										+ i + "</a></li>";
							}

							if (next) {
								str += "<li class='page-item'><a class='page-link' href='"
										+ (endNum + 1) + "'>Next</a></li>";
							}

							str += "</ul></div>";

							console.log(str);

							replyPageFooter.html(str);
						}

						replyPageFooter.on("click", "li a", function(e) {
							e.preventDefault();
							console.log("page click");

							var targetPageNum = $(this).attr("href");

							console.log("targetPageNum: " + targetPageNum);

							pageNum = targetPageNum;

							showList(pageNum);
						});

						var modal = $("#replyModal");
						var modalInputReply = modal.find("input[name='reply']");
						var modalInputReplyer = modal.find("input[name='replyer']");
						var modalInputReplyName = $("#replyName");
						var modalInputReplyDate = modal.find("input[name='replyDate']");

						var modalModBtn = $("#modalModBtn");													
						var modalRemoveBtn = $("#modalRemoveBtn");
						var modalRegisterBtn = $("#modalRegisterBtn");
						//var bnoValue = $("#bno").val();
						//alert(bnoValue)
						
						var replyer = null;
						var replyName = null;

 						<sec:authorize access="isAuthenticated()">

						replyer = '<sec:authentication property="principal.username"/>';
						replyName = "${name }";
						
						</sec:authorize>

						var csrfHeaderName = "${_csrf.headerName}";
						var csrfTokenValue = "${_csrf.token}";

						//Ajax spring security header...
						  $(document).ajaxSend(function(e, xhr, options){
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							})
						
						
						$("#modalCloseBtn").on("click", function(e) {
							modal.modal('hide');
						});
						$("#addReplyBtn").on("click", function(e) {
							modal.find("input").val("");
							modal.find("input[name='replyer']").val(replyer);
							modal.find("#replyName").val(replyName);
							modalInputReplyDate.closest("div").hide();
							modal.find("button[id !='modalCloseBtn']").hide();		
												
							modalRegisterBtn.show();
														
							$("#replyModal").modal("show");
						});
						modalRegisterBtn.on("click", function(e) {
							if(modalInputReply.val()==""){
								alert("댓글 내용을 입력하세요!");
								return false;
								}
							var reply = {
								reply : modalInputReply.val(),								
								replyer : replyer,
								name : replyName,								
								bno : bnoValue
							};
							replyService.add(reply, function(result) {
								alert(result);
								modal.find("input").val("");
								modal.modal("hide");
								showList(1);
							});
						});
						
						$(".chat").on("click","li",function(e){
							var rno = $(this).data("rno");

							replyService.get(rno, function(reply){
								modalInputReplyDate.closest("div").show();
								modalInputReply.val(reply.reply);
								modalInputReplyer.val(reply.replyer);
								modalInputReplyName.val(reply.name);
								modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
								modal.data("rno",reply.rno);

								modal.find("button[id != 'modalCloseBtn']").hide();
								
								modalInputReply.attr("disabled", "disabled");
								modalInputReplyName.attr("disabled", "disabled");

								modalModBtn.show();
								modalRemoveBtn.show();
								modalInputReply.removeAttr("disabled");
								
								$("#replyModal").modal("show");
								
								})
							
							})
						
						modalModBtn.on("click",function(e){

							var originalReplyer = modalInputReplyer.val();

							var reply = {
								rno : modal.data("rno"),
								reply: modalInputReply.val(),
								name: modalInputReplyName.val(),
								replyer : originalReplyer};						
							if(!replyer){
								alert("로그인후 수정이 가능합니다.");
								modal.modal("hide");
								return;
								}

							console.log("Original Replyer : " + originalReplyer);

							if(replyer != originalReplyer){
								alert("자신이 작성한 댓글만 수정이 가능합니다.");
								modal.modal("hide");
								return;
								}
							
							if(modalInputReply.val()==""){
								alert("댓글 내용을 입력하세요!");
								return;
								}

							replyService.update(reply,function(result){

								alert(result);
								modal.modal("hide");
								showList(1);								
								})
							
							})	

						modalRemoveBtn.on("click",function(e){
							var rno = modal.data("rno");

							console.log("RNO : " + rno);
							console.log("REPLYER : " + replyer);

							if(!replyer){
								alert("로그인후 삭제가 가능합니다.");
								modal.modal("hide");
								return;
								}

							var originalReplyer = modalInputReplyer.val();

							console.log("Original Replyer : " + originalReplyer);

							if(replyer != originalReplyer){
								alert("자신이 작성한 댓글만 삭제가 가능합니다.");
								modal.modal("hide");
								return;
								}
	
							replyService.remove(rno, replyer, function(result){								
								
								alert(result);
								modal.modal("hide");
								showList(pageNum);
								
								})
							
							})

							
					});
</script>
<script type="text/javascript">
	$(function(){
	var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/myshop/board/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/myshop/board/list").submit();
		});
			
		})

</script>

<%@include file="../includes/footer.jsp"%>
</body>
