<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>
<style>
.checkbox {
	width: 20px; /*Desired width*/
	height: 20px; /*Desired height*/
	cursor: pointer;
}
.col-1 {
  flex: 0 0 12.33333%;
  max-width: 12.33333%;
}

.col-11 {
  flex: 0 0 87.66667%;
  max-width: 87.66667%;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">나의 정보 수정</h1>
	</div>
</div>
<hr><br>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-body container">
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" /> <input type="hidden"
					name="${_csrf.parameterName }" value="${_csrf.token}" />
				<div class="form-group row">
					<label class="control-label col-1" for="userid">아이디</label>
					<div class="col-11">
						<input class="form-control" disabled="disabled" id="userid"
							name="userid" maxlength="20"
							value="<c:out value="${user.userid}"></c:out>" placeholder="아이디">
					</div>
				</div>

				<div class="form-group row">
					<label class="control-label col-1" for="userpw">패스워드</label>
					<div class="col-11">
						<input class="form-control" id="userpw" name="userpw"
							type="password" maxlength="100" placeholder="패스워드"><span
							id="spanpw" style="color: red;"><small>영문/숫자/특수문자(!@$%^&*
								만 허용)를 조합하여 5~20자</small></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="userpwe">패스워드확인</label>
					<div class="col-11">
						<input class="form-control" maxlength="100" id="userpwe"
							type="password" name='userpwe'><span id="spanpwe"
							style="color: red;"><small id="smallpwe"></small></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="username">이름</label>
					<div class="col-11">
						<input class="form-control" id="username" maxlength="10"
							value="<c:out value="${user.username}"></c:out>" name="username"
							placeholder="성명">
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="sex">성별</label>
					<div class="btn-group" role="group"
						aria-label="Basic radio toggle button group">
						<label style="width: 25px"></label>
						<div>
							<label class="form-check-label"> <select
								class="form-control" id="sex" name="sex">
									<option value="M"
										<c:if test="${user.sex eq 'M'}">selected="selected"</c:if>>남성</option>
									<option value="G"
										<c:if test="${user.sex eq 'G'}">selected="selected"</c:if>>여성</option>
							</select>
							</label>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="hp">HP</label>
					<div class="col-11">
						<input value="<c:out value="${user.hp}"></c:out>"
							class="form-control" maxlength="13" id="hp" name='hp'>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="phone">Phone</label>
					<div class="col-11">
						<input value="<c:out value="${user.phone}"></c:out>"
							class="form-control" maxlength="13" id="phone" name='phone'>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="brith">Birth</label>
					<div class="col-11">
						<input value="<c:out value="${user.birth}"></c:out>"
							class="form-control" maxlength="10" id="birth" name='birth'
							type="date">
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="dept">부서</label>
					<div class="col-11">
						<select class="form-control" id="dept" name="dept"><option
								value="">-----</option></select>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="job">직책</label>
					<div class="col-11">
						<select class="form-control" id="job" name="job"><option
								value="">-----</option></select>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="email">Email</label>
					<div class="col-11">
						<input class="form-control"
							value="<c:out value="${user.email}"></c:out>" maxlength="250"
							id="email" name='email'><span id="spanem"
							style="color: red;"><small id="smallem"></small></span>
					</div>
				</div>
				<div class="form-group row ">
					<label class="control-label col-1">우편번호</label>
					<div class="col-2">
						<input class="form-control"
							value="<c:out value="${user.zip}"></c:out>" maxlength="8"
							id="zip" name='zip'>
					</div>

					<div class="col-2">
						<button id="findzip" class="form-control">주소찾기</button>
					</div>
				</div>
				<div class="form-group">
					<!-- <label class="control-label col-1">주소</label> -->
					<input class="form-control"
						value="<c:out value="${user.addr1}"></c:out>" id="addr1"
						name='addr1' placeholder="주소">
				</div>
				<div class="form-group">
					<!-- <label class="control-label col-1">주소상세</label> -->
					<input class="form-control"
						value="<c:out value="${user.addr2}"></c:out>" maxlength="250"
						id="addr2" name='addr2' placeholder="상세 주소">
				</div>
				<br>
				<div class="form-group" align="right">
					<button id="save" type="submit" style='color:white;' class="btn btn-warning">수정</button>
					<button id="list" class="btn btn-info"
						onclick="javascript:window.location.href='/'">메인화면으로 이동</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var userid = '<c:out value="${userid}"></c:out>';//
	if (userid == "") {
		window.location.href = "/login";
	}
	//주소
	$(document)
			.ready(
					function() {

						$("#findzip")
								.on(
										"click",
										function() {
											new daum.Postcode(
													{
														oncomplete : function(
																data) {
															var addr = ''; // 주소 변수
															var extraAddr = ''; // 참고항목 변수

															if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
																addr = data.roadAddress;
															} else { // 사용자가 지번 주소를 선택했을 경우(J)
																addr = data.jibunAddress;
															}

															document
																	.getElementById('zip').value = data.zonecode;
															document
																	.getElementById("addr1").value = addr;
															document
																	.getElementById(
																			"addr2")
																	.focus();
														}
													}).open();
										});//end_click

						$
								.ajax({
									type : "POST", // HTTP method type(GET, POST) 형식이다.
									url : "/member/dept", // 컨트롤러에서 대기중인 URL 주소이다.
									beforeSend : function(xhr) {
										xhr.setRequestHeader(csrfHeaderName,
												csrfTokenValue);
									},
									//data : "list", // Json 형식의 데이터이다.
									success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
										$.each(res, function(i, item) {
											$('#dept').append($('<option>', {
												value : item.code,
												text : item.name
											}));
										});
										var dept = '<c:out value="${user.dept}"></c:out>';
										$("#dept").val(dept); //추가후 
									},
									error : function(XMLHttpRequest,
											textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
										alert("통신 실패.")
									}
								});

						$
								.ajax({
									type : "POST", // HTTP method type(GET, POST) 형식이다.
									url : "/member/job", // 컨트롤러에서 대기중인 URL 주소이다.
									beforeSend : function(xhr) {
										xhr.setRequestHeader(csrfHeaderName,
												csrfTokenValue);
									},
									//data : "list", // Json 형식의 데이터이다.
									success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
										$.each(res, function(i, item) {
											$('#job').append($('<option>', {
												value : item.code,
												text : item.name
											}));
										});
										var job = '<c:out value="${user.job}"></c:out>';
										$("#job").val(job);
									},
									error : function(XMLHttpRequest,
											textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
										alert("통신 실패.")
									}
								// 

								});

						$("#userpwe").on("change", function(e) {
							e.preventDefault();

							if ($("#userpw").val() != $("#userpwe").val()) {
								$("#smallpwe").text("비밀번호가 일치하지 않습니다");
								//alert("비밀번호가 일치하지 않습니다");
								$("#userpwe").focus();
								return;
							}
							if ($("#userpw").val() == $("#userpwe").val()) {
								$("#spanpwe").empty();
								return;
							}
						});

						$("#userpw").on("change", function(e) {
							e.preventDefault();
							var c1 = check_passwd($("#userpw").val());
							if (c1 != "") {
								alert(c1);
								$("#userpw").focus()
								return;
							} else {
								$("#spanpw").empty();
							}
						})

						$("#email")
								.on(
										"change",
										function(e) {
											e.preventDefault();
											var emailcheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
													.test($("#email").val());

											if (!emailcheck) {
												$("#smallem").text(
														"email 형식을 확인하여 주세요");
												//alert("email 형식을 확인하여 주세요")
												$("#email").focus();
												return;
											} else {
												$("#smallem").empty();
												//alert("email 형식을 확인하여 주세요")
												$("#email").focus();
												return;
											}
										})

						$("#useridcheck").on(
								"click",
								function(e) {
									e.preventDefault();

									var params = {
										userid : $("#userid").val()
									};

									$.ajax({
										type : "POST", // HTTP method type(GET, POST) 형식이다.
										url : "/member/existid", // 컨트롤러에서 대기중인 URL 주소이다.
										beforeSend : function(xhr) {
											xhr.setRequestHeader(
													csrfHeaderName,
													csrfTokenValue);
										},
										data : params, // Json 형식의 데이터이다.
										success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
											if (res !== "no") { //yes 면 o
												alert("사용 가능한 아이디입니다");
												$("#hidduseridcheck").attr(
														"value", "yes");
											} else {
												alert("사용 불가능한 아이디입니다");
											}
											$("#hidduseridcheck").val(res);
										},
										error : function(XMLHttpRequest,
												textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
											alert("통신 실패.")
										}
									});
								});

						$("#save")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											var c1 = check_passwd($("#userpw")
													.val());
											var emailcheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
													.test($("#email").val());

											var params = {
												userid : $('#userid').val(),
												userpw : $('#userpw').val(),
												username : $('#username').val(),
												sex : $('#sex').val(),
												birth : $('#birth').val(),
												email : $('#email').val(),
												zip : $('#zip').val(),
												addr1 : $('#addr1').val(),
												addr2 : $('#addr2').val(),
												phone : $('#phone').val(),
												hp : $('#hp').val(),
												job : $('#job').val(),
												dept : $('#dept').val(),
												day : $('#day').val()
											}

											if ($("#userid").val() == "") {
												alert("아이디를 입력하여 주세요");
												$("#userid").focus();
												return;
											}
// 											if ($("#hidduseridcheck").val() == "no") {
// 												alert("아이디 중복확인을 해주세요");
// 												$("#userid").focus();
// 												return;
// 											}
											if ($("#userpw").val() == "") {
												alert("비밀번호를 입력하여 주세요");
												$("#userpw").focus();
												return;
											}
											if (c1 != "") {
												alert(c1);
												$("#userpw").focus()
												return;
											}
											if ($("#userpw").val() != $(
													"#userpwe").val()) {
												alert("비밀번호가 일치하지 않습니다");
												$("#userpwe").focus();
												return;
											}
											if ($("#username").val() == "") {
												alert("이름를 입력하여 주세요");
												$("#username").focus();
												return;
											}
											if ($("#hp").val() == "") {
												alert("HP 번호를 입력하여 주세요");
												$("#hp").focus();
												return;
											}
											if ($("#phone").val() == "") {
												alert("phone 번호를 입력하여 주세요");
												$("#phone").focus();
												return;
											}
											if ($("#birth").val() == "") {
												alert("생년월일을 입력하여 주세요");
												$("#birth").focus();
												return;
											}
											if ($("#dept").val() == "") {
												alert("부서를 입력하여 주세요");
												$("#dept").focus();
												return;
											}
											if ($("#job").val() == "") {
												alert("직책을 입력하여 주세요");
												$("#job").focus();
												return;
											}
											if ($("#email").val() == "") {
												alert("이메일을 입력하여 주세요");
												$("#email").focus();
												return;
											}
											if (!emailcheck) {
												alert("email 형식을 확인하여 주세요")
												$("#email").focus();
												return;
											}
											if ($("#zip").val() == "") {
												alert("우편번호를 입력하여 주세요");
												$("#zip").focus();
												return;
											}
											if ($("#addr2").val() == "") {
												alert("상세주소를 입력하여 주세요");
												$("#addr2").focus();
												return;
											}

											$
													.ajax({
														type : 'POST',
														url : '/member/detils',
														data : params,
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
														},
														success : function(res) {
															alert("수정되었습니다")
															window.location.href = "/" //로그인창으로
														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) {
															alert("회원가입에 실패하였습니다")
														}
													});

										});//end_save

					});//end_document
</script>

<script>
	function check_passwd(mbrPwd) {
		var check1 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$/
				.test(mbrPwd);
		if (!check1) {
			return "비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를\n조합하여 5~20자로 구성하세요.";
		}

		if (/(\w)\1\1/.test(mbrPwd)) {
			return '같은 문자를 3번 이상 사용하실 수 없습니다.';
		}

		var cnt = 0;
		var cnt2 = 0;
		var tmp = "";
		var tmp2 = "";
		var tmp3 = "";
		for (var i = 0; i < mbrPwd.length; i++) {
			tmp = mbrPwd.charAt(i);
			tmp2 = mbrPwd.charAt(i + 1);
			tmp3 = mbrPwd.charAt(i + 2);

			if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == 1
					&& tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == 1) {
				cnt = cnt + 1;
			}
			if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == -1
					&& tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == -1) {
				cnt2 = cnt2 + 1;
			}
		}
		if (cnt > 0 || cnt2 > 0) {
			return '연속된 문자를 3번 이상 사용하실 수 없습니다.';
		}

		return '';
	}

	// selct box binding Event
	function GetUserData() {
		//alert($("#dept option").length)
		//	$("#dept").test('50');
		// 	$("#job").val(job).prop("selected",true);
	}
	/*
	최소 8 자, 최소 하나의 문자 및 하나의 숫자 :
	"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
	
	최소 8 자, 최소 하나의 문자, 하나의 숫자 및 하나의 특수 문자 :
	"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"

	최소 8 자, 대문자 하나 이상, 소문자 하나 및 숫자 하나 :
	"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"

	최소 8 자, 대문자 하나 이상, 소문자 하나, 숫자 하나 및 특수 문자 하나 이상 :
	"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}"
	최소 8 자 및 최대 10 자, 대문자 하나 이상, 소문자 하나, 숫자 하나 및 특수 문자 하나 이상 :
	"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,10}"
	이메일 형식 :
	/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/

	 */
</script>

<%@ include file="../includes/clientfooter.jsp"%>