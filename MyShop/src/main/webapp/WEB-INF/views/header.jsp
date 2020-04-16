<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<!-- Bootstrap core CSS -->
	<link href="/myshop/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="/myshop/resources/css/shop-homepage.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript -->
	<script src="/myshop/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/myshop/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/myshop/resources/js/member.js"></script>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="/myshop">Myshop</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="/myshop">홈
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">게시판</a>
          </li>
          <sec:authorize access="isAnonymous()">
          <li class="nav-item">
            <a class="nav-link" href="javascript:join()">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="javascript:login()">로그인</a>
          </li>
          </sec:authorize>
          <sec:authorize access="isAuthenticated()">
          <li class="nav-item">
            <a class="nav-link" href="#">마이페이지</a>
          </li>          
          <li class="nav-item">          
          <form id="logoutForm" action="/myshop/logout" method="post">
          <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </form>
            <a class="nav-link" href="javascript:logout()">로그아웃</a>
          </li>
          </sec:authorize>
        </ul>
      </div>
    </div>
  </nav>
<!-- #joinModal -->
<div class="modal fade" id="joinModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header justify-content-center font-weight-light my-4">
				<h3 class="modal-title" id="myModalLabel">회원가입</h3>
			</div>
			<div class="modal-body">
	            <form id="joinForm" action="/myshop/user/join" method="post">
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	            <input type="hidden" name="addr" id="addr">
	            <input type="hidden" name="idcheck" id="idcheck" value="0">
	                <div class="form-group">
	              	  <label class="small mb-1" for="joinid">ID</label>
					  <div class="input-group">
	              	  	<input class="form-control input-group-prepend joinInput" name="userid" id="joinid" type="text" placeholder="아이디를 입력하세요" />
	               	 	<button type="button" id="idcheckBtn" class="btn btn-outline-info input-group-append">중복체크</button>
		              </div>
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="joinpw">Password</label>
		                <input class="form-control joinInput" name="userpw" id="joinpw" type="password" placeholder="패스워드를 입력하세요" />
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="userpw">Password 확인</label>
		                <input class="form-control joinInput" id="pwdcheck" type="password" placeholder="패스워드를 입력하세요" />
	                </div>
   	                <div class="form-group">
		                <label class="small mb-1" for="username">이름</label>
		                <input class="form-control joinInput" name="username" id="username" type="text" placeholder="이름을 입력하세요" />
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="tel">전화번호</label>
		                <input class="form-control joinInput" name="tel" id="tel" type="tel" maxlength="13" placeholder="전화번호를 입력하세요" />
	                </div>
  	                <div class="form-group">
		                <label class="small mb-1" for="email">이메일</label>
		                <input class="form-control joinInput" name="email" id="email" type="email" placeholder="이메일을 입력하세요" />
	                </div>
					<div class="form-group">
						<label class="small mb-1">우편번호</label>
						<input class="form-control joinInput" style="width: 30%" type="text" name="zipcode" id="zipcode" readonly="readonly">
					</div>						
					<div class="form-group">
						<label class="small mb-1">주소</label>
						<div class="input-group">
							<input class="form-control input-group-prepend joinInput" type="text" id="addrView" readonly="readonly">
							<button type="button" id="addrBtn" class="btn btn-outline-primary input-group-apeend">주소 검색</button>
						</div>
					</div>
  	                <div class="form-group">
		                <label class="small mb-1" for="addrDetail">상세주소</label>
		                <input class="form-control joinInput" name="addrDetail" id="addrDetail" type="text" placeholder="상세주소를 입력하세요" />
	                </div>
   	                <div class="form-group">
		                <label class="small mb-1" for="role">관리자 코드</label>
		                <input class="form-control joinInput" name="admincode" id="admincode" type="text" placeholder="관리자가 되려면 코드를 입력하세요" />
	                </div>
	                <div class="form-group mt-4 mb-0">
	                	<button type="button" class="btn btn-primary float-right" id="joinBtn">회원가입</button>
	                </div>
	            </form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /#joinModal --> 
<!-- #loginModal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header justify-content-center font-weight-light my-4">
				<h3 class="modal-title" id="myModalLabel">로그인</h3>
			</div>
			<div class="modal-body">
	            <form id="loginForm" action="/myshop/login" method="post">
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	            <input type="hidden" name="idcheck" id="idcheck" value="0">
	                <div class="form-group">
	              	  <label class="small mb-1" for="userid">ID</label>
					  <div class="input-group">
	              	  	<input class="form-control input-group-prepend" name="username" id="loginid" type="text" placeholder="아이디를 입력하세요" />
		              </div>
	                </div>
	                <div class="form-group">
		                <label class="small mb-1" for="userpw">Password</label>
		                <input class="form-control" name="password" id="loginpw" type="password" placeholder="패스워드를 입력하세요" />
	                </div>
                	<div class="form-group">
                       <div class="custom-control custom-checkbox">
                       	<input class="custom-control-input" name="remember-me" id="remember-me" type="checkbox" />
                        <label class="custom-control-label" for="remember-me">자동 로그인</label>
                       </div>
              		</div>
	                <div class="form-group mt-4 mb-0">
	                	<button type="button" class="btn btn-primary float-right" id="loginBtn">로그인</button>
	                </div>
	                <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
					    <font color="red">
					        ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
					        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
					    </font>
					</c:if>				
	            </form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /#loginModal --> 