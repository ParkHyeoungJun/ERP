<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>
.daybtn{
	float:right;
	width:80px;
	height:35px;
	border:none;
	color:white; 

}
</style>
<div class="card shadow mb-4">
<div class="card-body">
<br>
	<div>
	<input type='button' class='daybtn' id='mbtn' style='background-color:#ABABAB; margin-right: 20px; border-radius: 0px 20px 20px 0px;' value='이달'>
	<input type='button' class='daybtn' id='hbtn' style='background-color:#4E73DF; margin-right: 1px; border-radius: 20px 0px 0px 20px;' value='전체'>
	</div>
	
	<div>
		<h1>실적차트</h1>
	</div>
	
	<hr>
	<br>
	
	<div style="text-align: center;">
		<span style="font-size: 17px;" id='fpspan'>최우수 사원: </span><span
			style="font-size: 20px;"><b id='firstper'></b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span style="font-size: 17px;" id='fdspan'>최우수 부서: </span><span
			style="font-size: 20px;"><b id='firstdept'></b></span>
	</div>
	<br>
	<hr>
	<br>
	<div style="text-align: center;">
		<button class="form-control"
			style="display: inline-block; width: 200px; border: none; color: white; background-color: #4E73DF;"
			id="perbtn">개인별</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="form-control"
			style="display: inline-block; width: 200px; border: none; color: white; background-color: #ABABAB;"
			id="deptbtn">부서별</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="form-control"
			style="display: inline-block; width: 200px; border: none; color: white; background-color: #ABABAB;"
			id="jobbtn">직책별</button>
			
	</div>
</div>
<br>
<br>
<div class="container">
	<canvas id="myChart"></canvas>
</div><br><br>
</div>

<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
	$(document).ready(function(){
		var ctx = $("#myChart");
		
		List();
		HPerList();
		HDeptList();
		HJobList();
		
		//최우수 사원
		$.ajax({
			type : "POST",
			url : "/member/firstper",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				$("#firstper").empty();
				var str = ''; 
				$.each(res,function(i, v) {
					str+=v.username+" (id: "+v.userid+")"				
				 })
				 
				 $("#firstper").append(str);
				
				if (Object.keys(res).length == 0) { //데이터가 없을 경우
					$('#firstper').empty();
					$('#firstper').append("-");
				}
			},
			error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});

		//최우수 부서
		$.ajax({
			type : "POST",
			url : "/member/firstdept",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				$("#firstdept").empty();
				
				$.each(res,function(i, v) {
					 $("#firstdept").append(v.dept);
				 })
				 
				 if (Object.keys(res).length == 0) { //데이터가 없을 경우
						$('#firstdept').empty();
						$('#firstdept').append("-");
					}
				 
				
			},
			error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
		
		
$("#hbtn").on("click",function(){
	$("#fpspan").text("최우수 사원: ");
	$("#fdspan").text("최우수 부서: ");
	$("#hbtn").css("background-color","#4E73DF");
	$("#mbtn").css("background-color","#ABABAB");
	
			List();
			HPerList();
			HDeptList();
			HJobList();
			
			//최우수 사원
			$.ajax({
				type : "POST",
				url : "/member/firstper",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					$("#firstper").empty();
					var str = ''; 
					$.each(res,function(i, v) {
						str+=v.username+" (id: "+v.userid+")"				
					 })
					 
					 $("#firstper").append(str);
					
					if (Object.keys(res).length == 0) { //데이터가 없을 경우
						$('#firstper').empty();
						$('#firstper').append("-");
					}
					
				},
				error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});

			//최우수 부서
			$.ajax({
				type : "POST",
				url : "/member/firstdept",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					$("#firstdept").empty();
					
					$.each(res,function(i, v) {
						 $("#firstdept").append(v.dept);
					 })
					 
					 
					 if (Object.keys(res).length == 0) { //데이터가 없을 경우
						$('#firstdept').empty();
						$('#firstdept').append("-");
					}
					
				},
				error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
		});
		
		
$("#mbtn").on("click",function(){
	$("#fpspan").text("이달의 최우수 사원: ");
	$("#fdspan").text("이달의 최우수 부서: ");
	$("#mbtn").css("background-color","#4E73DF");
	$("#hbtn").css("background-color","#ABABAB");
	
	MList();
	MPerList();
	MDeptList();
	MJobList();
	
	//이번달 최우수 사원
	$.ajax({
		type : "POST",
		url : "/member/mfirstper",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
		},
		success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			$("#firstper").empty();
			var str = ''; 
			$.each(res,function(i, v) {
				str+=v.username+" (id: "+v.userid+")"				
			 })
			 
			 $("#firstper").append(str);
			
			if (Object.keys(res).length == 0) { //데이터가 없을 경우
				$('#firstper').empty();
				$('#firstper').append("-");
			}
		},
		error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			alert("통신 실패.")
		}
	});

	//이번달 최우수 부서
	$.ajax({
		type : "POST",
		url : "/member/mfirstdept",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
		},
		success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			$("#firstdept").empty();
			
			$.each(res,function(i, v) {
				 $("#firstdept").append(v.dept);
			 })
			 
			 if (Object.keys(res).length == 0) { //데이터가 없을 경우
						$('#firstdept').empty();
						$('#firstdept').append("-");
					}
			 
			
		},
		error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			alert("통신 실패.")
		}
	});
	
});
		
	});
</script>
<script>
function List() {
	$("#perbtn").css("background-color", "#4E73DF");
	$("#deptbtn").css("background-color", "#ABABAB");
	$("#jobbtn").css("background-color", "#ABABAB");
	$.ajax({
		type : "POST", // HTTP method type(GET, POST) 형식이다.
		url : "/member/bonuslist", // 컨트롤러에서 대기중인 URL 주소이다.
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		
		//data : params, // Json 형식의 데이터이다.
		
		success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			resetCanvas();
			var ctx = $("#myChart");
			
			var arr = new Array();
			var bon = new Array();
			 $.each(res,function(i, v) { //i 인덱스 , v 값				
				 arr[i] =v.username;	
				 bon[i]=v.bonus;
				})
			
			
				var myChart = new Chart(ctx, {
					//type : 'horizontalBar',
					type : 'horizontalBar',
					data : {
						labels : arr,
						datasets : [ {
							label : '실적',
							data : bon,
							backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
							borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
							borderWidth : 1
						} ]
					},
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			alert("통신 실패.")
		}
	});
}
function HPerList() {//개인별 조회
	$("#perbtn").on("click",function(){
		$("#perbtn").css("background-color", "#4E73DF");
		$("#deptbtn").css("background-color", "#ABABAB");
		$("#jobbtn").css("background-color", "#ABABAB");
		List();
		
	});
	}
	function HDeptList() {//부서별 조회
	$("#deptbtn").on("click",function(){
		$("#perbtn").css("background-color", "#ABABAB");
		$("#deptbtn").css("background-color", "#4E73DF");
		$("#jobbtn").css("background-color", "#ABABAB");
		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/member/bonuslistdept", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			//data : params, // Json 형식의 데이터이다.
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				resetCanvas();
				var ctx = $("#myChart");
				
				
				var arr = new Array();
				var bon = new Array();
				 $.each(res,function(i, v) { //i 인덱스 , v 값				
					 arr[i] =v.dept;	
					 bon[i] = v.bonus;
					 
					})
				
				
					var myChart = new Chart(ctx, {
						type : 'horizontalBar',
						data : {
							labels : arr,
							datasets : [ {
								label : '실적',
								data : bon,
								backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
								borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
								borderWidth : 1
							} ]
						},
						options : {
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true
									}
								} ]
							}
						}
					});

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	
	});
}
	function HJobList() {//직책별 조회
	$("#jobbtn").on("click",function(){
		$("#perbtn").css("background-color", "#ABABAB");
		$("#deptbtn").css("background-color", "#ABABAB");
		$("#jobbtn").css("background-color", "#4E73DF");
		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/member/bonuslistjob", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			//data : params, // Json 형식의 데이터이다.
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				resetCanvas();
				var ctx = $("#myChart");
			
				var arr = new Array();
				var bon = new Array();
				 $.each(res,function(i, v) { //i 인덱스 , v 값				
					 arr[i] =v.job;	
					 bon[i] = v.bonus;
					})
				
				
					var myChart = new Chart(ctx, {
						type : 'horizontalBar',
						data : {
							labels : arr,
							datasets : [ {
								label : '실적',
								data : bon,
								backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
								borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
								borderWidth : 1
							} ]
						},
						options : {
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true
									}
								} ]
							}
						}
					});

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	});
	}
</script>
<script>
function MList() {	
	$("#perbtn").css("background-color", "#4E73DF");
	$("#deptbtn").css("background-color", "#ABABAB");
	$("#jobbtn").css("background-color", "#ABABAB");
	$.ajax({
		type : "POST", // HTTP method type(GET, POST) 형식이다.
		url : "/member/mbonuslist", // 컨트롤러에서 대기중인 URL 주소이다.
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		
		//data : params, // Json 형식의 데이터이다.
		
		success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			resetCanvas();
			var ctx = $("#myChart");
			
			var arr = new Array();
			var bon = new Array();
			 $.each(res,function(i, v) { //i 인덱스 , v 값				
				 arr[i] =v.username;	
				 bon[i]=v.bonus;
				})
			
			
				var myChart = new Chart(ctx, {
					type : 'horizontalBar',
					data : {
						labels : arr,
						datasets : [ {
							label : '실적',
							data : bon,
							backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
							borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
							borderWidth : 1
						} ]
					},
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			alert("통신 실패.")
		}
	});
}
function MPerList() {//개인별 조회
	$("#perbtn").on("click",function(){
		$("#perbtn").css("background-color", "#4E73DF");
		$("#deptbtn").css("background-color", "#ABABAB");
		$("#jobbtn").css("background-color", "#ABABAB");
		MList();
		
	});
	}
	function MDeptList() {//부서별 조회
	$("#deptbtn").on("click",function(){
		$("#perbtn").css("background-color", "#ABABAB");
		$("#deptbtn").css("background-color", "#4E73DF");
		$("#jobbtn").css("background-color", "#ABABAB");
		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/member/mbonuslistdept", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			//data : params, // Json 형식의 데이터이다.
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				resetCanvas();
				var ctx = $("#myChart");
			
				var arr = new Array();
				var bon = new Array();
				 $.each(res,function(i, v) { //i 인덱스 , v 값				
					 arr[i] =v.dept;	
					 bon[i] = v.bonus;
					 
					})
				
				
					var myChart = new Chart(ctx, {
						type : 'horizontalBar',
						data : {
							labels : arr,
							datasets : [ {
								label : '실적',
								data : bon,
								backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
								borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
								borderWidth : 1
							} ]
						},
						options : {
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true
									}
								} ]
							}
						}
					});

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	
	});
}
	function MJobList() {//직책별 조회
	$("#jobbtn").on("click",function(){
		$("#perbtn").css("background-color", "#ABABAB");
		$("#deptbtn").css("background-color", "#ABABAB");
		$("#jobbtn").css("background-color", "#4E73DF");
		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/member/mbonuslistjob", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			//data : params, // Json 형식의 데이터이다.
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				resetCanvas();
				var ctx = $("#myChart");
			
				var arr = new Array();
				var bon = new Array();
				 $.each(res,function(i, v) { //i 인덱스 , v 값				
					 arr[i] =v.job;	
					 bon[i] = v.bonus;
					})
				
				
					var myChart = new Chart(ctx, {
						type : 'horizontalBar',
						data : {
							labels : arr,
							datasets : [ {
								label : '실적',
								data : bon,
								backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
								borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)','rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
								borderWidth : 1
							} ]
						},
						options : {
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true
									}
								} ]
							}
						}
					});

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	});
	}
	
	
	function resetCanvas() {
		  $('#myChart').remove();
		  $('.container').append('<canvas id="myChart"><canvas>');
		};

</script>

<%@ include file="../../includes/adminfooter.jsp"%>