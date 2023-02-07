<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>

<style>
.checkbox {
	width: 20px; /*Desired width*/
	height: 20px; /*Desired height*/
	cursor: pointer;
}
.col-1 {
  flex: 0 0 10.33333%;
  max-width: 10.33333%;
}

.col-11 {
  flex: 0 0 89.66667%;
  max-width: 89.66667%;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">회원 정보</h1>
	</div>
</div>
<hr><br>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<!-- 			<div class="panel-heading">글쓰기</div> -->
			<div class="panel-body container">

				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
				<div class="form-group row">
					<label class="control-label col-1" for="userid">아이디</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.userid}' /></label>
						<input class="form-control" id="userid" name="userid"
							value="${member.userid}" type="hidden">
					</div>
					
				</div>

				<!-- 				<div class="form-group row"> -->
				<!-- 					<label class="control-label col-1" for="userpw">패스워드</label> -->
				<!-- 					<div class="col-11"> -->
				<!-- 						<input class="form-control" id="userpw" name="userpw" -->
				<!-- 							type="password" placeholder="패스워드"> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="form-group row"> -->
				<!-- 					<label class="control-label col-1" for="userpwe">패스워드확인</label> -->
				<!-- 					<div class="col-11"> -->
				<!-- 						<input class="form-control" id="userpwe" type="password" -->
				<!-- 							name='userpwe'> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<div class="form-group row">
					<label class="control-label col-1" for="username">이름</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.username}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="sex">성별</label>
					<div class="col-11">
					<label class="control-label">
							<c:if test="${member.sex eq 'M'}"><c:out value='남자' /></c:if>
							<c:if test="${member.sex eq 'G'}"><c:out value='여자' /></c:if>						
					</label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="hp">HP</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.hp}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="phone">phone</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.phone}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="brith">birth</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.birth}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="dept">부서</label>
					<div class="col-11">
					<label class="control-label">
					
					<c:if test="${member.dept eq '10'}"><c:out value='인사부' /></c:if>
					<c:if test="${member.dept eq '20'}"><c:out value='총무부' /></c:if>					
					<c:if test="${member.dept eq '30'}"><c:out value='회계부' /></c:if>
					<c:if test="${member.dept eq '40'}"><c:out value='기획부' /></c:if>	
					<c:if test="${member.dept eq '50'}"><c:out value='영업부' /></c:if>
					
					</label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="job">직책</label>
					<div class="col-11">
					<label class="control-label">
					
					<c:if test="${member.job eq '01'}"><c:out value='사원' /></c:if>
					<c:if test="${member.job eq '02'}"><c:out value='주임' /></c:if>					
					<c:if test="${member.job eq '03'}"><c:out value='전임' /></c:if>
					<c:if test="${member.job eq '04'}"><c:out value='선임' /></c:if>	
					<c:if test="${member.job eq '05'}"><c:out value='대리' /></c:if>
					<c:if test="${member.job eq '06'}"><c:out value='과장' /></c:if>
					<c:if test="${member.job eq '07'}"><c:out value='차장' /></c:if>					
					<c:if test="${member.job eq '08'}"><c:out value='부장' /></c:if>
					<c:if test="${member.job eq '09'}"><c:out value='이사' /></c:if>	
					<c:if test="${member.job eq '10'}"><c:out value='상무' /></c:if>
					<c:if test="${member.job eq '11'}"><c:out value='전무' /></c:if>
					<c:if test="${member.job eq '12'}"><c:out value='부사장' /></c:if>					
					<c:if test="${member.job eq '13'}"><c:out value='사장' /></c:if>
					<c:if test="${member.job eq '14'}"><c:out value='부회장' /></c:if>	
					<c:if test="${member.job eq '15'}"><c:out value='회장' /></c:if>
					
					</label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="email">Email</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.email}' /></label>
					</div>
				</div>
				<div class="form-group row ">
					<label class="control-label col-1" for="zip">우편번호</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.zip}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="addr1">주소</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.addr1}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="addr2">주소상세</label>
					<div class="col-11">
					<label class="control-label"><c:out value='${member.addr2}' /></label>
					</div>
				</div>
				<div class="form-group row">
					<label class="control-label col-1" for="username">권한</label>
					<div class="col-11">

						관리자 :&nbsp;<input class="checkbox" type="checkbox" id="ROLE_ADMIN">
						<br> 사용자 :&nbsp;<input class="checkbox" type="checkbox"
							id="ROLE_MEMBER">
					</div>
				</div><br>
				<div class="form-group" align="right">
					<button id="list" class="btn btn-warning"
						onclick="javascript:window.location.href='/admin/member/list'">목록으로 이동</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var role_admin = '<c:out value="${member.authList[1].auth}"></c:out>'
	var role_member = '<c:out value="${member.authList[0].auth}"></c:out>'
	//	alert(String(ROLE_ADMIN))
	if (String(role_admin) == "ROLE_ADMIN") {
		
		$("#ROLE_ADMIN").attr("checked", true)
	}
	if (String(role_member) == "ROLE_MEMBER") {
		$("#ROLE_MEMBER").attr("checked", true)
	}
	$(document).ready(function() {

		$("#list").on("click", function() {
			window.location.href = "/admin/member/list";
		});
		$(".checkbox").on("change", function() {
			var auth = $(this).attr("id");

			var params = {
				userid : $("#userid").val(),
				auth : auth,
				checkyn : $(this).is(":checked") ? "y" : "n"
			}
			//
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/admin/member/memberauth", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					alert("수정되었습니다.")
					//
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
			////
		});

	});
</script>
<%@ include file="../../includes/adminfooter.jsp"%>