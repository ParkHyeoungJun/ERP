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

.modal-body {
	max-height: calc(400px);
	overflow-y: scroll;
}

label {
	width: 200px;
}
</style>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type='hidden' id='writer' value='<sec:authentication property="principal.username"/>'>
<input type="hidden" id="code" name="code" value="0">

<div class="card shadow mb-4">
<div class="card-body">
	<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">
			게시판 관리
		</h1>
	</div>
</div>
	<hr>
	<div align="right">
		<button id="btnwriter" class="btn btn-info" style="width:70px;">작성</button>
		<a onclick="ExportToExcel()" id="Excel"><button
				class="btn btn-warning" style="width:120px;">엑셀저장</button></a>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered " id="dataTable" width="100%">
				<thead>
					<tr>
						<th>제목</th>
						<th>답변여부</th>
						<th>댓글여부</th>
						<th>에지터</th>
						<th>첨부파일여부</th>
						<th>신고</th>
						<th>익명작성여부</th>
					</tr>
				</thead>

			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">게시판권한</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<div class="form-group">
						<label>게시판 제목</label> <input class="form-control" id="title"
							name='title'>
					</div>
					<div class="form-group">
						 <label>전체 선택</label> <input class="checkbox" type="checkbox" id="cbAll" name='cbAll'>
					</div>
					<div class="form-group">

						<label>답변 여부</label> <input class="checkbox" type="checkbox"
							id="reply" name='reply'>
					</div>
					<div class="form-group">
						<label>덧글여부 여부</label> <input class="checkbox" type="checkbox"
							id="answer" name='answer'>
					</div>
					<div class="form-group">
						<label>에지터사용 여부</label> <input class="checkbox" type="checkbox"
							id="editor" name='editor'>
					</div>
					<div class="form-group">
						<label>첨부파일 여부</label> <input class="checkbox" type="checkbox"
							id="attach" name='attach'>
					</div>
					<div class="form-group">
						<label>신고기능</label> <input class="checkbox" type="checkbox"
							id="declar" name='declar'>
					</div>
					<div class="form-group">
						<label>익명사용자 작성가능여부</label> <input class="checkbox"
							type="checkbox" id="auth" name='auth'>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="add" type="button" class="btn btn-warning">등록</button>
				<button id="modfiy" type="button" class="btn btn-warning">수정</button>
				<button id="delete" type="button" class="btn btn-danger">삭제</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

			</div>
		</div>
	</div>
</div>
<div id="hiddenDivLoading" style="visibility: hidden">
	<div id='load'>
		<img src='/resources/img/loading.gif' />
	</div>
</div>
</div>


<script>
	function List() {
		$
				.ajax({
					type : "POST", // HTTP method type(GET, POST) 형식이다.
					url : "/admin/boardadmin/listajax", // 컨트롤러에서 대기중인 URL 주소이다.
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

						$('#load').show();
						// 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
						$("#hiddenDivLoading").show()
								.css(
										{
											top : $(document).scrollTop()
													+ ($(window).height())
													/ 2.6 + 'px',
											left : ($(window).width()) / 2.6
													+ 'px'
										});
						$("#hiddenDivLoading").show();
					},
					//data : params, // Json 형식의 데이터이다.
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						// 응답코드 > 0000
						//alert(res);

						$('#dataTable').empty();
						$('#dataTable')
								.append(
										"<thead><tr><th>제목</th><th>답변여부</th><th>댓글여부</th><th>에지터사용부</th><th>첨부파일여부</th><th>신고기능</th><th>익명작성여부</th></tr></thead>")
						var str = "";

						$
								.each(
										res,
										function(i, v) { //i 인덱스 , v 값
											str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
											str += "<td style='cursor:pointer' onclick=getRowData('"
													+ v.code + "'";
											str += ",'" + v.reply + "'"
											str += ",'" + v.answer + "'"
											str += ",'" + v.editor + "'"
											str += ",'" + v.attach + "'"
											str += ",'" + v.declar + "'"
											str += ",'" + v.auth + "'"
											str += ",'" + v.title.replace(/ /g,"__") + "'"
											str += ")>" + v.title + "</td>"
											str += '<td>' + v.reply + '</td>';
											str += '<td>' + v.answer + '</td>';
											str += '<td>' + v.editor + '</td>';
											str += '<td>' + v.attach + '</td>';
											str += '<td>' + v.declar + '</td>';
											str += '<td>' + v.auth + '</td>';

											str += '</tr>'
										})

						$('#dataTable').append(str);

						if (Object.keys(res).length == 0) { //데이터가 없을 경우
							str += "<tr><td colspan=7 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
							$('#dataTable').append(str);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						alert("통신 실패.")
					}
				});
	}

	function getRowData(code, reply, answer, editor, attach, declar, auth,
			title) {
		$("#code").val(code); // 수정 모드 
		//alert(replaceNewLineChars(title));

		//alert(answer)
		 		if (reply === "true")
					$("#reply").attr("checked", true); //javascript에서  0,'flase' 형변환 안됨 문자열 형식으로 비교 
				if (answer === "true")
					$("#answer").attr("checked", true);
				if (editor === "true")
					$("#editor").attr("checked", true);
				if (attach === "true")
					$("#attach").attr("checked", true);
				if (declar === "true")
					$("#declar").attr("checked", true);
				if (auth === "true")
					$("#auth").attr("checked", true);
		 		$("#title").val(title.replace("__"," "));
				$("#add").hide(); // 저장 버튼 숨기기
				$("#modfiy").show(); // 수정 버튼 활성화
				$("#delete").show(); // 삭제 버튼 활성화
				$("#modal").modal("show"); // 모달 창 띄우기
	}
	function replaceNewLineChars(value) {
		if (value != null && value != "") {
			return value.replace(/\n/g, "\\n");
		} else {
			return value
		}
	}
</script>
<!-- excel 저장  -->

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	
	function del(code){
		if (confirm("정말로 삭제하시겠습니까?")) {
			var params = {
				code : code
			}
			
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/admin/boardadmin/deletedajax", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					// 응답코드 > 0000
					// 
					alert("삭제되었습니다");
					$("#code").val("0");
					$("#modal").modal("hide"); // 닫기
					//
					List();

					//     
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
		}
	}
	$(document).ready(function() {
		List();
		$("#modfiy").hide();
		$("#delete").hide();
		$("#btnwriter").on("click", function() {
			$("#modal").modal();
			$("#cbAll").attr("checked", false);
			$("#reply").attr("checked", false);
			$("#answer").attr("checked", false);
			$("#editor").attr("checked", false);
			$("#attach").attr("checked", false);
			$("#declar").attr("checked", false);
			$("#auth").attr("checked", false);
			$("#title").val("");
			$("#add").show(); // 저장 버튼 숨기기
			$("#modfiy").hide(); // 수정 버튼 활성화
			$("#delete").hide(); // 삭제 버튼 활성화

		});

		$("#cbAll").on("change", function() {
			var flag = $(this).is(":checked");
			$(".checkbox").attr("checked", flag);
		});//체크하든 안 하든 발생

		//저장 
		$("#add").on("click", function(e) {
			e.preventDefault();

			if ($("#title").val() == "") {
				alert("제목을 입력하여 주세요");
				$("#title").focus();
				return false;
			}

			var params = {
				code : $("#code").val(),
				reply : $("#reply").is(":checked"),
				answer : $("#answer").is(":checked"),
				editor : $("#editor").is(":checked"),
				attach : $("#attach").is(":checked"),
				declar : $("#declar").is(":checked"),
				auth : $("#auth").is(":checked"),
				title : $("#title").val(), //제목에 띄어쓰기 들어가면 오류남. https://whitekeyboard.tistory.com/100 참조해서 나중에 보완하기
				writer : $("#writer").val()
			}
			//
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/admin/boardadmin/addajax", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					// 응답코드 > 0000
					// 
					alert("저장 되었습니다");
					$("#code").val("0"); // 입력 모드
					$("#modal").modal("hide"); // 닫기

					List();

					//     
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
			//
		});
		////저장
		// ajaxstop 은 ajax가 실행완료이든 에러이든 발생 
		$(document).ajaxStop(function() {
		});
		//ajaxComplete 은 실행 완료 시에만 실행 
		$(document).ajaxComplete(function() {

			$('#load').hide();
			$("#hiddenDivLoading").hide();
		});
		$("#modfiy").on("click", function(e) {
			e.preventDefault();

			if ($("#title").val() == "") {
				alert("제목을 입력하여 주세요");
				$("#title").focus();
				return false;
			}

			var params = {
				code : $("#code").val(),
				reply : $("#reply").is(":checked"),
				answer : $("#answer").is(":checked"),
				editor : $("#editor").is(":checked"),
				attach : $("#attach").is(":checked"),
				declar : $("#declar").is(":checked"),
				auth : $("#auth").is(":checked"),
				title : $("#title").val(),
				writer : $("#writer").val()
			}
			//
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/admin/boardadmin/addajax", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					// 응답코드 > 0000
					// 
					alert("수정 되었습니다");
					$("#code").val("0");//0이면 입력, 0이 아니면 수정하게끔.
					$("#modal").modal("hide"); // 닫기
					//
					List();

					//     
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
		});

		$("#delete").on("click", function(e) {
			e.preventDefault();

			      var params = {            
			            pageNum : '1',
			            amount  : '5',
			            type : 'T',
			            keyword : '',
			            code : $("#code").val()
			         }
			      var code = $("#code").val();

			      $.ajax({
			         type : "POST", // HTTP method type(GET, POST) 형식이다.
			         url : "/board/select", // 컨트롤러에서 대기중인 URL 주소이다.
			         beforeSend : function(xhr) {
			            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			           
			         },
			         data : params, // Json 형식의 데이터이다.
			         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					
			         if (Object.keys(res).length == 0) { //데이터가 없을 경우
			        	 del(code);
				     }
			         
			         if (Object.keys(res).length != 0) { //데이터가 있을 경우
			        	 alert("삭제는 게시판의 게시글을 모두 지운 후에 삭제가능합니다.");
			        	 $("#code").val("0");
						 $("#modal").modal("hide"); // 닫기
							//
							List();
				     }
			         
			         },
			         error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			           // alert("통신 실패.")
			         }
			      });
			     
		});
	});
</script>
<script>
	function ExportToExcel() {
		var htmltable = document.getElementById("dataTable");

		var html = htmltable.outerHTML; //innerHTML: 태그 안쪽 값만 가져옴. outer: 해당 태그까지 모두 가져옴.
		//alert(html)
		window
				.open('data:application/vnd.ms-excel,'
						+ encodeURIComponent(html));
		//window.open : 팝업창 띄우는 함수
		//data:application/vnd.ms-excel : 파일의 헤더 정보를 강제로 엑셀로 지정함.
		//encodeURIComponent: URI의 특정한 문자를 UTF-8로 인코딩
	}
</script>

<%@ include file="../../includes/adminfooter.jsp"%>