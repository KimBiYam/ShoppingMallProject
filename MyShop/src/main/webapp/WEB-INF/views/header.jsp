<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<!-- Bootstrap core CSS -->
	<link href="/myshop/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/myshop/resources/css/shop-homepage.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript -->
	<script src="/myshop/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/myshop/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="/myshop">Myshop</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">로그인</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
<!-- registerModal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header justify-content-center font-weight-light my-4">
				<h3 class="modal-title" id="myModalLabel">회원가입</h3>
			</div>
			<div class="modal-body">
	            <form id="registerForm" action="/myapp/member/register" method="post">
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	            <input type="hidden" name="idcheck" id="idcheck" value="0">
	                <div class="form-group">
	              	  <label class="small mb-1" for="userid">ID</label>
					  <div class="input-group">
	              	  	<input class="form-control input-group-prepend regsiterInput" name="userid" id="userid" type="text" placeholder="아이디를 입력하세요" />
	               	 	<button type="button" id="idcheckBtn" class="btn btn-outline-info input-group-append">중복체크</button>
		              </div>
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="userpw">Password</label>
		                <input class="form-control regsiterInput" name="userpw" id="userpw" type="password" placeholder="패스워드를 입력하세요" />
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="userpw">Password 확인</label>
		                <input class="form-control regsiterInput" id="pwdcheck" type="password" placeholder="패스워드를 입력하세요" />
	                </div>
   	                <div class="form-group">
		                <label class="small mb-1" for="username">이름</label>
		                <input class="form-control regsiterInput" name="username" id="username" type="text" placeholder="이름을 입력하세요" />
	                </div>
					<div class="form-group">
						<label class="small mb-1">우편번호</label>
						<input class="form-control regsiterInput" type="text" name="zipNo" id="zipNo" readonly="readonly">
					</div>						
					<div class="form-group">
						<label class="small mb-1">주소</label>
						<div class="input-group">
							<input class="form-control input-group-prepend regsiterInput" type="text" name="addr" id="addr" readonly="readonly">
							<button type="button" id="addrBtn" onclick="javascript:goPopup()"
							class="btn btn-outline-primary input-group-apeend">주소 검색</button>
						</div>
					</div>
	                <div class="form-group">
	                    <div class="custom-control custom-radio">
	                    <input class="custom-control-input" checked="checked" type="radio" value="ROLE_ADMIN" name="auth" id="radio"/>
	                    <label class="custom-control-label" for="radio">관리자</label>
	                    </div>
	                    <div class="custom-control custom-radio">
	                    <input class="custom-control-input" type="radio" name="auth" value="ROLE_USER" id="radio2"/>
	                    <label class="custom-control-label" for="radio2">유저</label>
	                    </div>
	                </div>
	                <div class="form-group mt-4 mb-0">
	                	<button class="btn btn-primary float-right" id="registerBtn">회원가입</button>
	                </div>
	            </form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal --> 