<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>담당자 선택</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
#hole {
	border: solid 1px gray;
	border-radius: 10px;
	width: 500px;
	height: 400px;
	padding: 50px;
	margin: auto;
}
.checkbox {
	width: 20px; /*Desired width*/
	height: 20px; /*Desired height*/
	cursor: pointer;
}
.cbAll{
	width: 20px; /*Desired width*/
	height: 20px; /*Desired height*/
	cursor: pointer;
}
.form-group2 {
	max-height: calc(130px);
	overflow-y: scroll;
}

</style>
</head>
<body>
<div id="hole">
	<div class="form-group row" >
	<h1 style="color:#404040;">담당자 선택</h1>
	</div><hr><br>
	<div class="form-group row" >
		<label class="control-label col-1" style="font-size: 18px;" for="dept">부서</label>
		<span class="col-11">
			<select class="form-control" style="width:100px; height:30px;" id="dept" name="dept"><option
					value="">-----</option></select>
		</span>&nbsp;&nbsp;&nbsp;
		<label class="control-label col-1" style="font-size: 18px;" for="job">직책</label>
		<span class="col-11">
			<select class="form-control" style="width:100px; height:30px;" id="job" name="job"><option
					value="">-----</option></select>
		</span>
	</div>
	
	<br>
	<div style="border: 1px solid #A0A0A0;">
	<div class="form-group2">
	<div class="col-11">
       <div class="form-control" id="txt"></div>
	</div>
	</div>
	</div>
	<br>
	<div>
	<input type='checkbox' class='cbAll' id='cbAll'>전체 선택
	</div>
	<br><br>
	<div class="form-group" style="text-align: right;">
	<button id="btnSubmit" style="display:inline-block; cursor:pointer; border-radius:5px; width:100px; height:40px; border:none; color:white; background-color: #F6C23E;" class="form-control">저장</button>
	<button id='close' style="display:inline-block; cursor:pointer; border-radius:5px; width:100px; height:40px; border:none; color:white; background-color: #858796;" class="form-control">Close</button>
	</div>
	</div>
<input type="hidden" id="num" value='${num}'>
<input type="hidden" id="useridsp" >
<input type="hidden" id="usernamesp">
<input type="hidden" id="plus">
<div id="pl"></div>
	<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
		$(document).ready(function() {
			$.ajax({
                type : "POST", // HTTP method type(GET, POST) 형식이다.
                url : "/member/dept", // 컨트롤러에서 대기중인 URL 주소이다.
                beforeSend : function(xhr) {
                   xhr.setRequestHeader(csrfHeaderName,
                         csrfTokenValue);
                },
                //data : "list", // Json 형식의 데이터이다.
                success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                   $.each(res, function(i, item) {
                      $('#dept').append($('<option>', {
                         value : item.code,
                         text : item.name
                      }));
                   });
                },
                error : function(XMLHttpRequest, textStatus,
                      errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                   alert("통신 실패.")
                }
             });

             $.ajax({
                type : "POST", // HTTP method type(GET, POST) 형식이다.
                url : "/member/job", // 컨트롤러에서 대기중인 URL 주소이다.
                beforeSend : function(xhr) {
                   xhr.setRequestHeader(csrfHeaderName,
                         csrfTokenValue);
                },
                //data : "list", // Json 형식의 데이터이다.
                success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                   $.each(res, function(i, item) {
                      $('#job').append($('<option>', {
                         value : item.code,
                         text : item.name
                      }));
                   });
                },
                error : function(XMLHttpRequest, textStatus,
                      errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                   alert("통신 실패.")
                }
             });
             
             var str="";
             var params={
    					dept : $("#dept").val(),
    		            job  : $("#job").val(),
    		            num : $("#num").val()
    			}
             $.ajax({
                 type : "POST", // HTTP method type(GET, POST) 형식이다.
                 url : "/member/memberselect2", // 컨트롤러에서 대기중인 URL 주소이다.
                 beforeSend : function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName,
                          csrfTokenValue);
                 },
                 data : params, // Json 형식의 데이터이다.
                 
                 success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                	 
                	 $.each(res, function(i, item) {
                       str+="<input id='cb"+i+"' type='checkbox' class='checkbox' name='memberselect' value='username'>";
                       str+="<label id='lbl"+i+"' data-name='"+item.username+"' data-id='"+item.userid+"'>"+item.username+" (id: "+item.userid+")</label><br>";
                       
                       });
 						
                 	$('#txt').append(str);
                    
                 },
                 error : function(XMLHttpRequest, textStatus,
                       errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("통신 실패.")
                 }
              });
             
             $("#dept").on("change",function(){//부서 조건 넣었을때
            	 var str="";
            	 var params={
       					dept : $("#dept").val(),
       		            job  : $("#job").val(),
       		        	num : $("#num").val()
       			}
                  
                 $.ajax({
                     type : "POST", // HTTP method type(GET, POST) 형식이다.
                     url : "/member/memberselect2", // 컨트롤러에서 대기중인 URL 주소이다.
                     beforeSend : function(xhr) {
                        xhr.setRequestHeader(csrfHeaderName,
                              csrfTokenValue);
                     },
                     data : params, // Json 형식의 데이터이다.
                     
                     success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    	 $('#txt').empty();
                    	 $.each(res, function(i, item) {
                           str+="<input id='cb"+i+"' type='checkbox' class='checkbox' name='memberselect' value='username'>";
                           str+="<label id='lbl"+i+"' data-name='"+item.username+"' data-id='"+item.userid+"'>"+item.username+" (id: "+item.userid+")</label><br>";
                           
                           });
     						
                     	$('#txt').append(str);
                        
                     },
                     error : function(XMLHttpRequest, textStatus,
                           errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert("통신 실패.")
                     }
                  });
             });
             
             $("#job").on("change",function(){//직책 조건 넣었을 때
            	 var str="";
            	 var params={
       					dept : $("#dept").val(),
       		            job  : $("#job").val(),
       		         	num : $("#num").val()
       			}
                  
                 $.ajax({
                     type : "POST", // HTTP method type(GET, POST) 형식이다.
                     url : "/member/memberselect2", // 컨트롤러에서 대기중인 URL 주소이다.
                     beforeSend : function(xhr) {
                        xhr.setRequestHeader(csrfHeaderName,
                              csrfTokenValue);
                     },
                     data : params, // Json 형식의 데이터이다.
                     
                     success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    	 $('#txt').empty();
                    	 $.each(res, function(i, item) {
                    		str+="<input id='cb"+i+"' type='checkbox' class='checkbox' name='memberselect' value='username'>";            
                           str+="<label id='lbl"+i+"' data-name='"+item.username+"' data-id='"+item.userid+"'>"+item.username+" (id: "+item.userid+")</label><br>";
                           
                           });
     						
                     	$('#txt').append(str);
                        
                     },
                     error : function(XMLHttpRequest, textStatus,
                           errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert("통신 실패.")
                     }
                  });
             });
             
             
             $("#cbAll").on("change", function() {
     			var flag = $(this).is(":checked");
     			$(".checkbox").attr("checked", flag);
     		});//체크하든 안 하든 발생
     		
     		$(document).on("click","#close",function(){
				window.close();
			})
     		
			$("#btnSubmit").on("click", function() {
				
				//var str='';
				
				 $(".checkbox")
								.each(
										function(i, obj) {
											var id=$(this).closest("label").attr("id");
											
											if($(this).is(":checked") == true){
												//str+="<input id='idx"+i+"' type='checkbox' class='checkbox' style='width: 20px; height: 20px; cursor: pointer;' name='memberselect' value='"+obj.idx+"'>";
						                        //str+="<label id='lbl2"+i+"' data-name='"+$("#lbl"+i).data("name")+"' data-id='"+$("#lbl"+i).data("id")+"' style='font-size:17px;'>"+"&nbsp;"+$("#lbl"+i).data("name")+" (id: "+$("#lbl"+i).data("id")+")</label><br>";
						                       
												$("#plus").val($("#plus").val()+" "+$("#lbl"+i).data("name")+" (id: "+$("#lbl"+i).data("id")+'),');
												$("#useridsp").val($("#useridsp").val()+$("#lbl"+i).data("id")+",");
												$("#usernamesp").val($("#usernamesp").val()+$("#lbl"+i).data("name")+",");
												
											}
										});
				  //$("#pl").append(str);
				 
				 window.opener.GetData($("#plus").val(),$("#useridsp").val(),$("#usernamesp").val());
			 
				 window.close();
			});
		});
	</script>
</body>
</html>



