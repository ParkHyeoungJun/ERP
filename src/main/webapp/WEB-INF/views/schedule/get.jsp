<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>
<style>
.col-1 {
  flex: 0 0 10.33333%;
  max-width: 10.33333%;
}

.col-11 {
  flex: 0 0 89.66667%;
  max-width: 89.66667%;
}
</style>
<input type='hidden' id="num" name="num" value="${num}" />
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">스케쥴 확인</h1>
	</div>
</div>

<div>
<hr><br>
	<div class=col-lg-12>
		<div class="panel-heading"></div>
		<div class="panel-body">
			<input type="hidden" id="num" name="num" value="0" />

			<div class="form-group row">
				<label class="control-label col-1" for="title">일정명</label>
				<div class="col-11">
					<label class="control-label"><c:out value='${vo.title}' /></label>
				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="period">기간</label>
				<div class="col-11">
					<label class="control-label"><c:out value='${vo.startday}' /></label>
					<span>&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
					<label class="control-label"><c:out value='${vo.endday}' /></label>
					
				</div>
			</div>

			<div class="form-group row">
				<label class="control-label col-1" for="con">내용</label>
				<div class="col-11">
				<label class="control-label"><c:out value='${vo.content}' /></label>
				</div>
			</div>
						           
			<div class="form-group row">
				<label class="control-label col-1" for="personal">분류</label>
				<div class="col-11">
				<label class="control-label"><c:out value='${vo.personal}' /></label>
                </div>
			</div>
			
			<div class="form-group row">
				<label class="control-label col-1" for="day">작성일</label>
				<div class="col-11">
					<label class="control-label"><fmt:formatDate
                        pattern="yyyy-MM-dd" value="${vo.day}" /></label>
					
				</div>
			</div>
				<br />
				<div align="right">
					<button class="btn btn-warning" style="color:white;" id="boardModBtn">수정</button>
					<button class="btn btn-info" id="boardListBtn">목록</button>
				</div>
		</div>
	</div>
</div>
</div>


<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function() {				
	$('#boardModBtn').on("click", function(e) {
		e.preventDefault();
		window.location.href = "/schedule/update?num=" + $("#num").val();
	});
	$('#boardListBtn').on("click", function(e) {
		e.preventDefault();
		window.location.href = "/schedule/select";
	});
});
</script>

<%@ include file="../includes/clientfooter.jsp"%>
