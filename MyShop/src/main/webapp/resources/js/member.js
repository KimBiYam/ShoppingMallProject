//회원가입 폼
function register() {
	$(".joinInput").val("");
	$("#joinModal").modal("show");
	$("#registerid").removeAttr("readonly");
	$("#idcheck").val("0");
}
//로그인 폼
function login() {
	$("#loginid").val("");
	$("#loginpw").val("");
	$("#loginModal").modal("show");
}

$(function() {
	// 회원가입
	$("#registerBtn").on("click", function() {
		if ($("#registerid").val() == "") {
			alert("아이디를 입력하세요");
			$("#registerid").focus();
			return false;
		}
		if ($("#registerpw").val() == "") {
			alert("패스워드를 입력하세요");
			$("#registerpw").focus();
			return false;
		}
		if ($("#pwdcheck").val() == "") {
			alert("패스워드 확인을 입력하세요");
			$("#pwdcheck").focus();
			return false;
		}
		if ($("#registername").val() == "") {
			alert("이름을 입력하세요");
			$("#registername").focus();
			return false;
		}
		if ($("#tel").val() == "") {
			alert("전화번호를 입력하세요");
			$("#tel").focus();
			return false;
		}
		if ($("#email").val() == "") {
			alert("이메일을 입력하세요");
			$("#email").focus();
			return false;
		}
		if ($("#addrView").val() == "") {
			alert("주소를 검색하세요");
			return false;
		}
		if ($("#addrDetail").val() == "") {
			alert("상세주소를 입력하세요");
			$("#addrDetail").focus();
			return false;
		}
		if ($("#idcheck").val() == "0") {
			alert("아이디 중복체크를 하세요");
			return false;
		}
		if ($("#registerpw").val() != $("#pwdcheck").val()) {
			alert("패스워드가 틀렸습니다");
			$("#registerpw").val("");
			$("#pwdcheck").val("");
			$("#registerpw").focus();
			return false;
		}
		var addr = $("#addrView").val() + " " + $("#addrDetail").val();
		$("#addr").val(addr);

		$("#registerForm").submit();
		alert("회원가입이 완료 되었습니다!");
	});

	$("#idcheckBtn").click(function() {
		if ($("#registerid").val() == "") {
			alert("ID를 입력해주세요");
			$("#registerid").focus();
			return false;
		}
		if ($("#idcheck").val() == "1") {
			$("#registerid").removeAttr("readonly");
			$("#registerid").val("");
			$("#idcheck").val("0");
			return false;
		}
		$.get("/myshop/user/idcheck", {
			"userid" : $("#registerid").val()
		}, function(data) {
			if (data == "no"){
				alert("이미 가입된 아이디 입니다");
				$("#registerid").val("");
				$("#registerid").focus();
			}
			if (data == "yes") {
				alert("사용 가능한 아이디 입니다");
				$("#registerid").attr("readonly", "readonly");
				$("#idcheck").val("1");				
			}
			

		})
	});

	// 카카오 주소 API 팝업
	$("#addrBtn").on(
			"click",
			function() {
				new daum.Postcode(
						{
							oncomplete : function(data) {
								// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

								// 각 주소의 노출 규칙에 따라 주소를 조합한다.
								// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기
								// 한다.
								var addr = ''; // 주소 변수
								var extraAddr = ''; // 참고항목 변수

								// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								if (data.userSelectedType === 'R') { // 사용자가
																		// 도로명
																		// 주소를
																		// 선택했을
																		// 경우
									addr = data.roadAddress;
								} else { // 사용자가 지번 주소를 선택했을 경우(J)
									addr = data.jibunAddress;
								}

								// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
								if (data.userSelectedType === 'R') {
									// 법정동명이 있을 경우 추가한다. (법정리는 제외)
									// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									if (data.bname !== ''
											&& /[동|로|가]$/g.test(data.bname)) {
										extraAddr += data.bname;
									}
									// 건물명이 있고, 공동주택일 경우 추가한다.
									if (data.buildingName !== ''
											&& data.apartment === 'Y') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}
									// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									if (extraAddr !== '') {
										extraAddr = ' (' + extraAddr + ')';
									}
									// 조합된 참고항목을 해당 필드에 넣는다.
									// document.getElementById("sample6_extraAddress").value
									// = extraAddr;

								} else {
									// document.getElementById("sample6_extraAddress").value
									// = '';
								}

								// 우편번호와 주소 정보를 해당 필드에 넣는다.
								$("#zipcode").val(data.zonecode);
								$("#addrView").val(addr);
								// 커서를 상세주소 필드로 이동한다.
								$("#addrDetail").focus();
							}
						}).open();
			});

	// 로그인
	$("#loginBtn").on("click", function() {
		if ($("#loginid").val() == "") {
			alert("아이디를 입력하세요");
			$("#loginid").focus();
			return false;
		}
		if ($("#loginpw").val() == "") {
			alert("패스워드를 입력하세요");
			$("#loginpw").focus();
			return false;
		}
		$("#loginForm").submit();
	});

})