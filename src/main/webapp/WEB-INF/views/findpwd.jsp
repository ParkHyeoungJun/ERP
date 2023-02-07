<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="includes/clientheader.jsp"%>
<div class="container">
	<input type="hidden" id="userid" name="userid">
	<!-- Outer Row -->
	<div class="row justify-content-center">

		<div class="col-xl-10 col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="row">
						<div class="col-lg-6">
							<img width="500px" src="/resources/img/doc.jpg">
						</div>
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h1 class="h4 text-gray-900 mb-4">회원 정보 패스워드 찾기</h1>
								</div>
								<div class="form-group">

									<input type="email" class="form-control form-control-user"
										id="username" aria-describedby="emailHelp" placeholder="사용자명">
									<span id="spanun" style="color: red;"><small
										id="smallun"></small></span>
								</div>
								<div class="form-group">
									<input class="form-control form-control-user" id="email"
										placeholder="Email"> <span id="spanem"
										style="color: red;"><small id="smallem"></small></span>
								</div>
								
								<div class="form-group"></div>
								<a id="findpwd" style='color: white; height:40px; border:none; border-radius:5px; background-color: #FFC107;' class="btn btn-primary btn-user btn-block">
									비밀번호 찾기 </a>
								
								<hr>
									<a href="/membership" class="btn btn-google btn-user btn-block">
										<i class="fab fa-google fa-fw"></i> 회원가입
									</a> <a href="/finduserid" class="btn btn-facebook btn-user btn-block">
										<i class="fab fa-facebook-f fa-fw"></i> 아이디찾기
									</a>
								<hr>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="includes/clientfooter.jsp"%>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#findpwd")
								.on(
										"click",
										function() {
											var emailcheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
													.test($("#email").val());
											//alert(emailcheck)

											if ($("#username").val() == "") {
												$("#smallun").text(
														"사용자명을 입력하여 주세요.");
											} else {
												$("#smallun").empty();
											}
											if (!emailcheck) {
												$("#smallem").text(
														"email 형식을 확인하여 주세요.");
												//alert("email 형식을 확인하여 주세요")
												$("#email").focus();
												return;
											} else {
												$("#smallem").empty();
											}
											///
											var params = {
												username : $('#username').val(),
												email : $('#email').val()
											}
											//alert($("#username").val()+","+params.username)

											$
													.ajax({
														type : "POST", // HTTP method type(GET, POST) 형식이다.
														url : "/finduserid", // 컨트롤러에서 대기중인 URL 주소이다.
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
														},
														data : params, // Json 형식의 데이터이다.
														success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
															//alert(res);
															//return;
															sendEmail(res);

														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
															alert("통신 실패.")
														}
													});
											///
										});

						$("#email")
								.on(
										"change",
										function(e) {
											var emailcheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
													.test($(this).val());
											//alert(emailcheck)
											if (!emailcheck) {
												$("#smallem").text(
														"email 형식을 확인하여 주세요");
												//alert("email 형식을 확인하여 주세요")
												$(this).focus();
												return;
											} else {
												$("#smallem").empty();
											}
										});
					});
</script>
<script type="text/javascript">
	function sendEmail(userid) {
		//alert(userid)
		var params = {
			subject : '모두의 이알피 패스워드 찾기'	,
			content : userid				,
			from    : 'gakdhkd@naver.com'	,
			to      : $("#email").val()		,
			type    : 'findid'
		}
		//alert($("#username").val()+","+params.username)

		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/email/send", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : params, // Json 형식의 데이터이다.
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				alert("메일으로 발송 되었습니다.메일을 확인하여 주세요");
				window.location.href='/login';

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("회원정보와 일치하는 데이터가 존재하지 않습니다")
			}
		});
		///
	}
</script>
