<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="includes/clientheader.jsp"%>

<div class="container">
         <h2>${logout}</h2>
          <h2>${error}</h2>
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
							<form id="frm" method="post" action="/login">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">로그인</h1>
									</div>
									<div class="form-group">

										<input type="text" name="username" placeholder="userid"
											class="form-control" id="userid"> <span id="spanuserid"
											style="color: red;"><small id="smalluserid"></small></span>
									</div>
									<div class="form-group">
										<input type="password" id="password" name="password" placeholder="password"
											class="form-control"> <span id="spanpassword"
											style="color: red;"><small id="smallpassword"></small></span>
									</div>
									<div class="form-group" style='float: right; padding-top: 5px;'>
										<input type="checkbox" class="checkbox" name="remember-me">&nbsp;자동 로그인
									</div>

									<div class="form-group">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token}" />
									</div>
									<div class="form-group">
										<input type="submit" class="btn btn-primary btn-user btn-block" style='color: white; height:40px; border:none; border-radius:5px; background-color: #FFC107;' id="login" value="로그인">
									</div>
									
									<hr>
									<a href="/membership" class="btn btn-google btn-user btn-block">
										<i class="fab fa-google fa-fw"></i> 회원가입	
									</a>
									<a href="/finduserid" class="btn btn-facebook btn-user btn-block">
										<i class="fab fa-facebook-f fa-fw"></i> 아이디찾기
									</a>
									<a href="/findpwd" class="btn btn-facebook btn-user btn-block">
										<i class="fab fa-facebook-f fa-fw"></i> 패스워드찾기
									</a>
								<hr>
								</div>
								
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	var error = window.location.href;
	if(error =="http://localhost/login?error")
		{
		alert("아이디 혹은 패스워드를 확인해 주세요.")
		}
	$(document).on("click","#login",function(e){
		e.preventDefault();
		
		if($("#userid").val()=="")
		{	
			$("#smalluserid").text("아이디를 확인하여 주세요");
			$("#userid").focus();
			return
		}
		else
		{
			$("#smalluserid").empty();
		}
		if($("#password").val()=="")
		{
			$("#smallpassword").text("패스워드를 확인하여 주세요");
			$("#password").focus();
			return
		}
		else
		{
			$("#smallpassword").empty();
		}
		
		$("#frm").submit();
	});
});

</script>

<%@ include file="includes/clientfooter.jsp"%>