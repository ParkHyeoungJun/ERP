<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 보고서 결재 승인</title>
<!-- Bootstrap core JavaScript -->
<script src="/resources/client/vendor/jquery/jquery.min.js"></script>
<script
	src="/resources/client/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="/resources/css/util.css">
<link rel="stylesheet" type="text/css" href="/resources/css/report.css">
<style>
.radius {
	border-color: black;
	border-radius: 30px;
}

.table {
	border: 1px solid #bcbcbc;
}

.jb-th-1 {
	height: 20px
}
</style>
<!--===============================================================================================-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
</head>
<body>
<div style="padding:10px;">

	<div style="padding:10px;color:#4272D7; font-size:19px; font-weight: bold; ">결 재 목 록</div>
	
	
	<hr>
	<div class="table100 ver5 m-b-110">

		<div class="table100-head" style="margin-left:10px; font-weight: bold; font-size: 100px;">

			<table>
				<thead>
					<tr class="row100 head">
						<th class="cell100 column3">일자</th>
						<th class="cell100 column1">내용</th>
						<th class="cell100 column4">금액</th>
						<!-- 						<th class="cell100 column5">Spots</th> -->
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="table100-body js-pscroll">
			<table>
				<tbody class="table" id="tab">
				<c:forEach items="${data}" var="data" >
					<tr>
						<td><c:out value="${data.daytostring}" /></td>
						<td><c:out value="${data.sel}" /></td>
						<td><c:out value="${data.txt}" /></td>
					</tr>

				</c:forEach>
				</tbody>

			</table>
		</div>
	</div>
	<%-- <table>
		<tr>
			<td><button  style="background-color: #6c7ae0"
					class="btn">전자 서명 이미지</button></td>
		</tr>
		<tr>
		 <td><img alt="" src="/resources/sign/${uuid}"></td>
		</tr>
	</table> 제출자 서명은 굳이 안 보여줘도 될 것 같아서 일단 주석--%>
	</div>
	<!--  전자 서명 -->
	<div style="padding:10px;">
	
	<div class="table100 ver4 m-b-110">
		<div class="table100-head">

			<table>
				<thead>
					<tr class="row100 head">
					<th align="center" colspan="4" class="cell100 column1"><strong>결
							&nbsp;재 &nbsp;자 &nbsp;사 &nbsp;인</strong></th>
						<th align="center" colspan="1" class="cell100 column1">
						<button id='clear' style="width:70px; float:right; color:white; background-color: #17A2B8"
					class="btn">Clear</button>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="table100-body">
			<div class="form-group row">
				<div class="col-12">
					<canvas class="radius" id="signature" width="700px" height="250px"></canvas>
				</div>
			</div><hr>
		</div>
		</div>
		<div align="right">
				<button id='Save' style="color:white; width:70px; background-color: #f6c23e" class="btn">저장</button>
				<button id='close' style="color:white; width:70px; background-color: #858796" class="btn">Close</button>

			</div>
		
	</div>
	
	<!--  전자 서명 -->
	<input type="hidden" id="uuid" name="uuid">
	<input type="hidden" id="userid" name="userid" value="${userid}">
	
	<input type="hidden" id="dept" name="dept" value="${dept}">
	<input type="hidden" id="job" name="job" value="${job}">
	
	<input type="hidden" id="writerdept" name="writerdept" value="${writerdept}">
	<input type="hidden" id="writerjob" name="writerjob" value="${writerjob}">
	
	<form id="myForm"></form>
	<script type="text/javascript">
		var error = '<c:out value="${error}"></c:out>';
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		//alert(error)

		var canvas = $("#signature")[0];
		var signature = new SignaturePad(canvas, {
			minWidth : 2,
			maxWidth : 2,
			penColor : "rgb(0, 0, 0)"
		});
		function Save()
		{
			var $form = $("#myForm");
			if ($form.length < 1) {
				$form = $("<form/>").attr({
					id : "myForm",
					method : 'POST'
				});
				$(document.body).append($form);
			}
			$form.empty();
			
			$("<input></input>").attr({
				type : "hidden",
				name : "filename",
				value :"signResult.png"
			}).appendTo($form);
			
		
			
			$("<input></input>").attr({
				type : "hidden",
				name : "num",
				value :'<c:out value="${num}"></c:out>'
			}).appendTo($form);
			
			$("<input></input>").attr({
				type : "hidden",
				name : "uuid",
				value :$("#uuid").val()
			}).appendTo($form);
			
			$("<input></input>").attr({
				type : "hidden",
				name : "dept",
				value :$("#dept").val()
			}).appendTo($form);
			$("<input></input>").attr({
				type : "hidden",
				name : "job",
				value :$("#job").val()
			}).appendTo($form);
			//alert('${num}')
			//return;
			$("<input></input>").attr({
				type : "hidden",
				name : "writer",
				value :'<c:out value="${userid}"></c:out>'
			}).appendTo($form);
		//	alert('<c:out value="${num}"></c:out>')
		
			
			///////ajax 
				$
													.ajax({
														type : "POST",
														url : "/admin/reportresult/add",
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
														},
														data : $form
																.serialize(),
														success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
															alert("저장 되었습니다");
															//window.opener.List(); // 부모창 함수 호출 
															window.close();
															//$("#num").val("0");

															
														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
																		alert("저장중 에러 발생")
														}
													});
		}

		$(document).ready(function() {

			$(document).on("click","#clear",function(){
				signature.clear();
			})
			$(document).on("click","#close",function(){
				window.close();
			})
			$(document).on("click","#Save",function(){
				if (signature.isEmpty()) {
					alert("사인해 주세요!!");
					return;
				}
				/////////////// ajax 
				$.ajax({
					url : "/admin/reportresult/reportSaveimg",
					method : "post",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data : {
						sign : signature.toDataURL()
					},
					success : function(res) {
						//alert("이미지 저장완료 : " + res);
						$("#uuid").val(res)
						Save();
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						//			alert(errorThrown)
					}
				});
				////////////// ajax 

			});

		})
	</script>
</body>
</html>