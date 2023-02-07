<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="includes/clientheader.jsp"%>
<div class="container">
	<input type="hidden" id="userid" name="userid" value="${userid}">
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
									<h1 class="h4 text-gray-900 mb-4">회원 패스워드 변경</h1>
								</div>
								<div class="form-group">

									<input  class="form-control"
									 type="password"	id="userpw" name="userpw" placeholder="패스워드">
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-user"
									type="password"	id="userpwe" name="userpwe" placeholder="패스워드 확인">
								</div>
								<div class="form-group"></div>
								<a id="btnpassreset" class="btn btn-primary btn-user btn-block" style='color: white; height:40px; border:none; border-radius:5px; background-color: #FFC107;'>
									패스워드 변경 </a>							
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
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	//주소
	$(document).ready(function() {
		$("#btnpassreset").on("click", function(e) {
			e.preventDefault();
			if ($("#userpw").val() != $("#userpwe").val()) {
				alert("비밀번호가 다릅니다 확인하여 주세요");
				$("#userpw").focus();
				return;
			}
			var c1 = check_passwd($("#userpw").val());

	if ($("#userpw").val() != $("#userpwe").val()) {
				alert("비밀번호가 다릅니다 확인하여 주세요");
				$("#userpwe").focus();
				return;
			}
			if (c1 != "") {
				alert(c1);
				$("#userpw").focus()
				return;
			}
			// 패스워드 변경 
			var params = {
				userid : $('#userid').val(),
				userpw : $('#userpw').val()
			}
			$.ajax({
				type : 'POST',
				url : '/pwdreset',
				data : params,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res) {
					alert("패스워드 변경되었습니다")
					window.location.href = "/login" //로그인창으로
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("패스워드 변경 실패하였습니다")
				}
			});
		});
		$("#userpwe").on("change", function(e) {
			//e.preventDefault();
			// 			var c1 = check_passwd($("#userpw").val());
			// 			if ($("#userpw").val() != $("#userpwe").val()) {
			// 				alert("비밀번호가 다릅니다 확인하여 주세요");
			// 				$("#userpwe").focus();
			// 				return;
			// 			}
			// 			if (c1 != "") {
			// 				alert(c1);
			// 				$("#userpw").focus()
			// 				return;
			// 			}

			//
		});

		$("#userpw").on("change", function(e) {
			e.preventDefault();
			var c1 = check_passwd($("#userpw").val());
			if (c1 != "") {
				alert(c1);
				$("#userpw").focus()
				return;
			}
		})

	});
</script>