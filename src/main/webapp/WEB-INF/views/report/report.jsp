<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 보고서</title>
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
	
	<div>
		<button id='btnadd'	class="btn" style="width:70px; margin-top:8px; margin-right:5px; float:right; color:white; background-color: #343A40">추가</button>
	</div>
	<div style="padding:10px;color:#4272D7; font-size:19px; font-weight: bold; ">목 록 현 황
	</div>
	
	
	<hr>
	
	<div class="table100 ver5 m-b-110">

		<div class="table100-head" style="margin-left:10px; font-weight: bold; font-size: 100px;">

			<table>
				<thead>
					<tr class="row100 head">
						<th class="cell100 column3">일자</th>
						<th class="cell100 column1">내용</th>
						<th class="cell100 column4">금액</th>
						<th class="cell100 column2">삭제</th>
						<!-- 						<th class="cell100 column5">Spots</th> -->
					</tr>
				</thead>
			
			</table>
		</div>

		<div class="table100-body js-pscroll">
			<table>
				<tbody class="table" id="tab">
			
				</tbody>
			</table>
		</div>
	</div>
</div>
	<!--  전자 서명 -->
<div style="padding:10px;">

	<div class="table100 ver4 m-b-110">
		<div class="table100-head">

			<table>
				<thead>
					<tr class="row100 head">
						<th align="center" colspan="4" class="cell100 column1"><strong>제
							&nbsp;출 &nbsp;자 &nbsp;사 &nbsp;인</strong></th>
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
	<form id="myForm"></form>
	<script type="text/javascript">
		var error = '<c:out value="${error}"></c:out>';
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		//alert(error)
		if (error != "") {
			alert("지정된 담당자만 접근가능합니다")
			window.close();
		}
		var canvas = $("#signature")[0];
		var signature = new SignaturePad(canvas, {
			minWidth : 2,
			maxWidth : 2,
			penColor : "rgb(0, 0, 0)"
		});
		//천단위마다 콤마 생성
		function addComma(data) {
		    return data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		//모든 콤마 제거 방법
		function removeComma(data) {
		    if(!data || data.length == 0){
		    	return "";
		    }else{
		    	return data.split(",").join("");
		    }
		}
		
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
				value :"sign.png"
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
			//alert('${num}')
			//return;
			$("<input></input>").attr({
				type : "hidden",
				name : "writer",
				value :'<c:out value="${userid}"></c:out>'
			}).appendTo($form);
			//alert("")
			
			$('.sel' ).each( function(i,v) {
				var sel = $(this).val();
				var key = $(this).closest("tr").attr("id").replace("tr","")
				var txt= $("#txt"+key).val()
		
				
				$("<input></input>").attr({
					type : "hidden",
					name : "arrList["+i+"].sel",
					value :sel
				}).appendTo($form);
				
				$("<input></input>").attr({
					type : "hidden",
					name : "arrList["+i+"].txt",
					value :txt
				}).appendTo($form);
				
	       });
			
			///////ajax 
				$
													.ajax({
														type : "POST",
														url : "/report/reportadd",
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
															window.opener.List(); // 부모창 함수 호출 
															window.close();
															//$("#num").val("0");

															
														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
																		alert(errorThrown)
														}
													});
			///////ajax
			
		}
		
		
		
		$(document).ready(function() {
			$("#clear").on("click", function() {
				signature.clear();
			});
			$("#close").on("click", function() {
				window.close();
			});

			$("#Save").on("click", function() {
				if (signature.isEmpty()) {
					alert("사인해 주세요!!");
					return;
				}

				/////////////////
				$.ajax({
					url : "/report/reportSaveimg",
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
				////////////////

			});
			$("#btnadd").on("click", function() {
				var row = $('#tab>tr').length; // 전체 행을 알아 온다 
				if(row>0)
				{
				//	alert(Number($('#tab>tr:last').attr("id").replace('tr',''))+1);
					row = Number($('#tab>tr:last').attr("id").replace('tr',''))+1;
				}
				//alert(row)
				// 만약 1건 이상이라면 전체 합계가 있다는 얘기이므로 한 행은 삭제
				for (var i = 0; i <=row; i++) {
					if($('#txt'+i).val()==undefined)
					{
						$('#tr'+i).remove();				
					}
					 
				};
				if($('#tab>tr').length==4)
				{
					alert("더이상 추가하실수 없습니다")
					return;
				}				
				var now = new Date();
				var mm = Number(now.getMonth()+1);
				
				if(mm<10)
				{
					mm = '0'+mm;
				}
				//alert(mm)
				var dd = now.getDate();
				if(dd<10)
				{
					dd ='0'+dd;
				}
				var yy =now.getFullYear();
				var hh = now.getHours();
				
				var m = now.getMinutes(); // /분
				var date = yy +'-'+mm+'-'+dd
				var str ="";
				str +="<tr id='tr"+row+"' class='row100 body'> ";
				str +="<td class='cell100 column3'><input type='hidden' id='idx"+row+" ' ";
				str +=" name='idx"+row+"' value='0'>"+date+"</td>";
				str +="<td class='cell100 column1'><input type='text'";
				str +=" class='form-control sel' id='sel"+row+"' name='sel"+row+"'></td>";
				str +="<td class='cell100 column4'><input type='text'";
				str +="class='form-control money' id='txt"+row+"' name='txt"+row+"'></td>";
				str +="<td class='cell100 column2'><button id='btndel' data-idx='"+row+"' ";
				str +=" style='border:none; font-weight:bold; color:black;'>[삭제]</button></td>";
				str +="</tr>";
				$('#tab').append(str);			
				// 만약 4행이상이라면 총 합계가 있다는 의미로 총합은 삭제후 다시 붙여준다 
				
			});
			
			// 삭제 버튼 클릭한 행 삭제 로직
			$(document).on("click","#btndel",function(){
				var idx = $(this).data("idx");
				//alert(idx)
				$('#tr'+idx).remove();
				
				var rowcount = $('#tab>tr').length;
				var cnt =0;
				// 모두 컴마 제거후 숫자형으로 변환해서 합계 구한다
				
				$( '.money' ).each( function() {
					cnt +=Number(removeComma($(this).val()));
		       });
// 				for (var i = 0; i <rowcount; i++) {
// 					if($('#txt'+i).val()!=undefined)
// 					{			
// 						cnt +=Number(removeComma($('#txt'+i).val()));		
// 					}
// 				};
				var str ="";
				var row =0; // 실제 행을 기억하기 위함
				for (var i = 0; i <=rowcount; i++) {
					if($('#txt'+i).val()!=undefined)
					{
						//alert(row)
						str +="<tr id='tr"+row+"' class='row100 body'> ";
						str +="<td class='cell100 column3'><input type='hidden' id='idx"+row+" ' ";
						str +=" name='idx"+row+"' value='0'>"+date+"</td>";
						str +="<td class='cell100 column1'><input type='text'";
						str +=" class='form-control sel' id='sel"+row+"' name='sel"+row+"' value='"+$("#sel"+i).val()+"'></td>";
						str +="<td class='cell100 column4'><input type='text'";
						str +="class='form-control money' id='txt"+row+"' name='txt"+row+"' value='"+$("#txt"+i).val()+"'></td>";
						str +="<td class='cell100 column2'><button id='btndel' data-idx='"+row+"' ";
						str +=" style='border:none; font-weight:bold; color:black;'>[삭제]</button></td>";
						str +="</tr>";
						row +=1;
					}
				};
				
				str +="<tr id='tr"+row+"'><td cols=3>총 합계 : </td><td align='right'>"+addComma(cnt)+"</td></tr>";
				$('#tab').empty();
				$('#tab').append(str);
			});
			
			// 금액 입력 부분 콤마로 붙여주고 
			$(document).on("keyup",".money",function(){
				$(this).val($(this).val().replace(/[^0-9]/g,"")); // 숫자만 입력하게한다
				$(this).val( addComma($(this).val()));
				
			});
			$(document).on("change",".money",function(){
				var rowcount = $('#tab>tr').length;
				var cnt =0;
				// 모두 컴마 제거후 숫자형으로 변환해서 합계 구한다
				
				$( '.money' ).each( function() {
					cnt +=Number(removeComma($(this).val()));
		       });
				var str ="";
				var row =0; // 실제 행을 기억하기 위함
				for (var i = 0; i <=rowcount; i++) {
					if($('#txt'+i).val()!=undefined)
					{
						str +="<tr id='tr"+row+"' class='row100 body'> ";
						str +="<td class='cell100 column3'><input type='hidden' id='idx"+row+" ' ";
						str +=" name='idx"+row+"' value='0'>"+date+"</td>";
						str +="<td class='cell100 column1'><input type='text'";
						str +=" class='form-control sel' id='sel"+row+"' name='sel"+row+"' value='"+$("#sel"+i).val()+"'></td>";
						str +="<td class='cell100 column4'><input type='text'";
						str +="class='form-control money' id='txt"+row+"' name='txt"+row+"' value='"+$("#txt"+i).val()+"'></td>";
						str +="<td class='cell100 column2'><button id='btndel' data-idx='"+row+"' ";
						str +=" style='border:none; font-weight:bold; color:black;'>[삭제]</button></td>";
						str +="</tr>";
						row +=1;
					}
				};
				
				str +="<tr id='tr"+row+"'><td cols=3>총 합계 : </td><td align='right'>"+addComma(cnt)+"</td></tr>";
				$('#tab').empty();
				$('#tab').append(str);
				
			
			});
		})
	</script>
</body>
</html>