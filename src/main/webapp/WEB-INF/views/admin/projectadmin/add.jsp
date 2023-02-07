<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
<input type="hidden" name="${_csrf.parameterName}"
	value="${_csrf.token}" />
<div style="visibility: hidden;" id="useridsp"></div>
<div style="visibility: hidden;" id="usernamesp"></div>
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">프로젝트 생성</h1>
	</div>
</div>
<br>
<div>
	<div class=col-lg-12>
		<div class="panel-heading"></div>
		<div class="panel-body">
			<input type="hidden" id="num" name="num" value="0" />

			<div class="form-group row">
				<label class="control-label col-1" for="title">제목</label>
				<div class="col-11">
					<input class="form-control" type="text" id="title" name="title"
						maxlength="100">
				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="period">기간</label>
				<div class="col-11">
					<input class="form-control"
						style="display: inline-block; width: 48%;" maxlength="10"
						id="startday" name='startday' type="date"> <span>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
					<input class="form-control" maxlength="10"
						style="display: inline-block; width: 47%;" id="endday"
						name='endday' type="date">
				</div>
			</div>

			<div class="form-group row">
				<label class="control-label col-1" for="con">내용</label>
				<div class="col-11">
					<textarea rows="10" cols="50" class="form-control" id="con"
						name="con"></textarea>

				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="memberselect">담당자</label>
				<div class="col-11">

					<button class="form-control"
						style="display: inline-block; width: 200px; border: none; color: white; background-color: #F6C23E;"
						id="ok" class="form-control">담당자 선택</button>
					<button class="form-control"
						style="display: inline-block; float: right; width: 200px; border: none; color: white; background-color: #4E73DF;"
						id="reset" class="form-control">선택 초기화</button>
				</div>
				<br>
				<br> <label class="control-label col-1" for="member"></label>
				<div class="col-11">
					<textarea rows="5" cols="50" class="form-control" id="member"
						name="member" maxlength="1000"><c:out value=""></c:out></textarea>
				</div>
			</div>

			<div class="form-group row">
				<label class="control-label col-1" for="writer">작성자</label>
				<div class="col-11">
					<input class="form-control" type="text" id="writer" name="writer"
						maxlength="20"
						value='<sec:authentication property="principal.username"/>'
						readonly="readonly">
				</div>
			</div>
			<div class="form-group row" width=0 height=0
				style="visibility: hidden">
				<label class="control-label col-1" for="progress">완료</label>
				<div class="col-11">
					<input class="checkbox" type="checkbox" id="progress"
						name="progress">
				</div>
			</div>
			<div align="right">
			<button id="btnSave" type="button" class="btn btn-warning">등록</button>
			<button class="btn btn-info" id="boardListBtn">목록</button>
			</div>
		</div>
	</div>
</div>
</div>

<script src="//cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	var ckeditor_config = {
		resize_enaleb : false,
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		width : '100%',
		height : '400px',
		filebrowserUploadUrl : "/common/ckUpload?${_csrf.parameterName}=${_csrf.token}"
	};
</script>
<script>
	CKEDITOR.replace('con', ckeditor_config); //웹에디터

	$(document).ready(function(e) {

		$('#boardListBtn').on("click", function(e) {
			e.preventDefault();

			window.location.href = "/admin/projectadmin/select";
		});

		$("#endday").on("change", function(e) {
			e.preventDefault();

			if ($("#startday").val() > $("#endday").val()) {
				alert("시작 날짜보다 이전 날짜로 지정할 수 없습니다.");
				$("#endday").focus();
				return false;
			}
		});

		$("#btnSave").on("click", function(e) {
			e.preventDefault();

			if ($("#title").val() === "") {
				alert("제목을 입력하여 주세요");
				$("#title").focus();
				return false;
			}
			if ($("#startday").val() === "") {
				alert("기간을 지정하여 주세요");
				$("#startday").focus();
				return false;
			}
			if ($("#endday").val() === "") {
				alert("기간을 지정하여 주세요");
				$("#endday").focus();
				return false;
			}
			if ($("#startday").val() > $("#endday").val()) {
				alert("시작 날짜보다 이전 날짜로 지정할 수 없습니다.");
				$("#endday").focus();
				return false;
			}
			if ($("#writer").val() === "") {
				alert("작성자를 입력하여 주세요");
				$("#writer").focus();
				return false;
			}

			var params = {
				num : $("#num").val(),
				title : $("#title").val(),
				content : CKEDITOR.instances['con'].getData(),
				writer : $("#writer").val(),
				startday : $("#startday").val(),
				endday : $("#endday").val(),
				member : $("#member").val(),
				useridsp : $("#useridsp").text(),
				usernamesp : $("#usernamesp").text(),
				progress : $("#progress").is(":checked")

			}

			$.ajax({
				type : "POST",
				url : "/admin/projectadmin/add",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params,
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					alert("저장 되었습니다");

					window.location.href = "/admin/projectadmin/select";
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});

		});
	});
</script>
<script>
	function GetData(all, id, name) {
		$("#member").append(all);
		$("#useridsp").append(id);
		$("#usernamesp").append(name);
	}
	$(document).ready(
			function() {
				$("#ok").click(
						function() {//담당자 선택
							window.open("/admin/projectadmin/memberselect?num="
									+ $("#num").val(), "DescriptiveWindowName",
									"left=100,top=100,width=640,height=520");
						})
				//window.open("/test2");

				$("#reset").click(function() {
					$("#member").empty();
					$("#useridsp").empty();
					$("#usernamesp").empty();
				});

			});
</script>

<%@ include file="../../includes/adminfooter.jsp"%>