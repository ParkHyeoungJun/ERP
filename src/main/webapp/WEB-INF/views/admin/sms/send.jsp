<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<style>
#con{
	border-top:80px solid black;
	border-left:10px solid black;
	border-right:10px solid black;
	border-bottom:80px solid black;
	border-radius:30px 30px 30px 30px;
	margin-top:50px;
	padding-top:20px;
	background-color:white;
	height:700px;
	display: inline-block;
}

th,td{
	padding:5px;
}

</style>
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">sms 보내기</h1>
	</div>
</div>
<hr>
<div style='text-align: center;'>
	<div class="card-body" id="con">
		<div style="color:black; font-weight:bold; font-size:20px;">Everyone's ERP</div>
		<hr>
		<div class="table-responsive">
			<table>
				<tr>
					<td>보내는 사람 : &nbsp;</td>
					<td><input type="text" name="form" id="form"
						style="border:none; border-bottom:1px solid #C0C0C0; height:30px;"  value="01085232382"></td>
				</tr>
				<tr>
					<td>받는 사람 : &nbsp;</td>
					<td><input type="text" name="to" id="to"
						style="border:none; border-bottom:1px solid #C0C0C0; height:30px;"></td>
				</tr>
				<tr>
					<td>남은 수 : &nbsp;</td>
					<td><input type="text" id="sms_remain" name="sms_remain"
						style="border:none; border-bottom:1px solid #C0C0C0; width:50px; height:30px;" maxLength="2"
						value="80" readonly>&nbsp;Bytes 남음</td>
				</tr>
				<tr>
					<td>내용 : &nbsp;</td>
					<td style="padding-top:20px;"><textarea id="text" name="text" rows="8" cols="20" placeholder="&nbsp;내용을 입력해 주세요."
							style="padding-top:5px; resize: none; border:1px solid #C0C0C0; height:180px;" onkeyup="smsByteChk(this);"
							onkeydown="smsByteChk(this);"></textarea></td>
				</tr>
				</table>
				<br><br>
				<div style="padding-top:10px;">
				<button id="btnsend" style="width:100%; border-radius:7px;" class="btn btn-warning">전송</button>
				</div>
			

		</div>

	</div>
	<br><br><br><br><br><br>
	<div>
	<button id="btncancel" style="width:100px; margin-right:20px; float: right;" class="btn btn-info">이전</button>
	</div>
</div>

<div id="hiddenDivLoading" style="visibility: hidden">
	<div id='load'>
		<img src='/resources/img/loading.gif' />
	</div>
</div>
</div>

<script type="text/javascript">
	function smsByteChk(content) {
		var temp_str = content.value;
		var remain = document.getElementById("sms_remain");

		remain.value = 80 - getByte(temp_str);
		//남은 바이트수를 표시 하기
		if (remain.value < 0) {
			alert(80 + "Bytes를 초과할 수 없습니다.");

			while (remain.value < 0) {
				temp_str = temp_str.substring(0, temp_str.length - 1);
				content.value = temp_str;
				remain.value = 80 - getByte(temp_str);
			}

			content.focus();
		}

	}

	function getByte(str) {
		var resultSize = 0;
		if (str == null) {
			return 0;
		}

		for (var i = 0; i < str.length; i++) {
			var c = escape(str.charAt(i));
			if (c.length == 1)//기본 아스키코드
			{
				resultSize++;
			} else if (c.indexOf("%u") != -1)//한글 혹은 기타
			{
				resultSize += 2;
			} else {
				resultSize++;
			}
		}

		return resultSize;
	}

	$(document)
			.ready(
					function() {
						$(document).on("click", "#btncancel", function() {
							window.location.href = "/admin/sms/list";
						})

						$(document)
								.on(
										"click",
										"#btnsend",
										function() {

													       var params = {            
													    		   form : $("#form").val(),
													    		   to  : $("#to").val(),
													    		   text : $("#text").val()
											        }
											//    alert("")

											$
													.ajax({
														type : "POST", // HTTP method type(GET, POST) 형식이다.
														url : "/admin/sms/sendone", // 컨트롤러에서 대기중인 URL 주소이다.
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);

															$('#load').show();
														
														},
														 data : params, // Json 형식의 데이터이다.
														success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
															 alert(res)
														
														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
															alert("문자 전송 실패.")
														}
													});
										})

					})
</script>



<%@ include file="../../includes/adminfooter.jsp"%>