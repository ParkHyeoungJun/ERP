<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<style>
.checkbox,.progress {
	width: 20px; /*Desired width*/
	height: 20px; /*Desired height*/
	cursor: pointer; . inner { position : absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
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
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type='hidden' id="num" name="num" value="${num}" />


<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">프로젝트 수정</h1>
	</div>
</div>
<br>
<div>
	<div class=col-lg-12>
		<div class="panel-heading"></div>
		<div class="panel-body">

			<div class="form-group row">
				<label class="control-label col-1" for="title">제목</label>
				<div class="col-11">
					<input class="form-control" type="text" id="title" name="title"
						maxlength="100" value="<c:out value='${vo.title}'/>">
				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="period">기간</label>
				<div class="col-11">
					<input class="form-control"
						style="display: inline-block; width: 48%;" maxlength="10"
						id="startday" type="date" name='startday'
						value="<c:out value='${vo.startday}'/>"> <span>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
					<input class="form-control" maxlength="10"
						style="display: inline-block; width: 47%;" id="endday" type="date"
						name='endday' value="<c:out value='${vo.endday}'/>">
				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="con">내용</label>
				<div class="col-11">
					<textarea class="form-control" rows="10" cols="50" id="con"
						name="con"><c:out value="${vo.content}" /></textarea>
				</div>
			</div>

			<div class="form-group row" id="nomember">
				<label class="control-label col-1" for="memberselect">담당자</label>

				<div class="col-11">
					<div id="member"></div>
				</div>

				<label class="control-label col-1" for="member"></label>

				<div class="col-11" id='nono'>

					<br>
					<div id='allselect'>
						<input type='checkbox' class='cbAll'
							style='width: 17px; height: 17px; cursor: pointer;' id='cbAll'>전체
						선택
					</div>
					<br>
					<button class="form-control"
						style="display: inline-block; float: left; width: 200px; border: none; color: white; background-color: #E74A3B;"
						id="delete" class="form-control">선택 삭제</button>

				</div>
			</div>

			<div class="form-group row" id="nomemberlabel">
				<label class="control-label col-1" for="memberselect2"></label>

				<div class="col-11">
					<hr>
					<button class="form-control"
						style="display: inline-block; width: 200px; border: none; color: white; background-color: #F6C23E;"
						id="ok" class="form-control">담당자 추가</button>
					<button class="form-control"
						style="display: inline-block; float: right; width: 200px; border: none; color: white; background-color: #4E73DF;"
						id="reset" class="form-control">선택 초기화</button>

				</div>
				<br><br><br>
				<br> <label class="control-label col-1" for="memberplus"></label>
				<div class="col-11">
					<textarea rows="5" cols="50" class="form-control" id="memberplus"
						name="memberplus" maxlength="1000"><c:out value=""></c:out></textarea>
				</div>
			</div>

			<div class="form-group row">
				<label class="control-label col-1" for="updater">수정자</label>
				<div class="col-11">
					<input class="form-control" type="text" id="updater" name="updater"
						maxlength="20"
						value='<sec:authentication property="principal.username"/>'
						readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<label class="control-label col-1" for="progress">완료</label>
				<div class="col-11">
					<input class="progress" type="checkbox" id="progress"
						name="progress">
				</div>
			</div>
			<div align="right">
			<button id="boardModBtn" class="btn btn-warning">수정</button>
			<button id="boardDeleteBtn" class="btn btn-danger">삭제</button>
			<button id="boardListBtn" class="btn btn-info">목록</button>
			</div>
		</div>
	</div>
</div>
</div>
<div style="visibility: hidden;" id="useridsp"></div>
<div style="visibility: hidden;" id="useridspplus"></div>
<div style="visibility: hidden;" id="usernamesp"></div>
<div style="visibility: hidden;" id="pastprogress"></div>

<script src="//cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script>
var csrfHeaderName= "${_csrf.headerName}";
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

$(document).ready(function() {
	
	if(${vo.progress} === true){
        $("#progress").attr("checked", true);//기존 완료 정보를 가져와 유지시킴.
        $("#pastprogress").text("abc");//완료된 프로젝트를 진행중으로 다시 바꿨을 경우 대비
     }
     
	MemberList();
         $("#boardDeleteBtn").on("click",function(e){
            e.preventDefault();
            if (confirm("정말로 삭제하시겠습니까?")) {
               var params = {
                  num : $("#num").val()
               }
               $.ajax({
                  type : "POST", // HTTP method type(GET, POST) 형식이다.
                  url : "/admin/projectadmin/delete", // 컨트롤러에서 대기중인 URL 주소이다.
                  beforeSend : function(xhr) {
                     xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                  },
                  data : params, // Json 형식의 데이터이다.
                  success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                     alert("삭제되었습니다");
                     
                     window.location.href="/admin/projectadmin/select";
            
                  },
                  error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                     alert("통신 실패.")
                  }
               });
            }
         });
         
         $('#boardListBtn').on("click", function(e) {
            e.preventDefault();

            window.location.href="/admin/projectadmin/select";
         });
         
         $("#endday").on("change",function(e){
 			e.preventDefault();
 			
 			if ($("#startday").val() > $("#endday").val()) {
 				alert("시작 날짜보다 이전 날짜로 지정할 수 없습니다.");
 				$("#endday").focus();
 				return false;
 			}
 		});
         
         $('#boardModBtn').on("click", function(e) {
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
			if ($("#updater").val() === "") {
				alert("수정자를 입력하여 주세요");
				$("#updater").focus();
				return false;
			}
         
		
			var params = {
            num:$("#num").val(),
            title : $("#title").val(),
			content : CKEDITOR.instances['con'].getData(),
			updater : $("#updater").val(),
			startday: $("#startday").val(),
			endday: $("#endday").val(),
			member: $("#member").val(),
			useridsp: $("#useridsp").text(),
			useridspplus: $("#useridspplus").text(),
			usernamesp: $("#usernamesp").text(),
			bonus:'100',
			con:'1',
			pastprogress:$("#pastprogress").text(),
			progress : $("#progress").is(":checked")
         }
         //
         $.ajax({
            type : "POST", // HTTP method type(GET, POST) 형식이다.
            url : "/admin/projectadmin/add", // 컨트롤러에서 대기중인 URL 주소이다.
            beforeSend : function(xhr) {
               xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data : params, // Json 형식의 데이터이다.
            success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               alert("수정 되었습니다");
				
               window.location.href="/admin/projectadmin/get?num="+$("#num").val();
               
                 
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("통신 실패.")
            }
         });
      });
   });
</script>
<script>
function GetData(all,id,name)
{
   $("#memberplus").text($("#memberplus").val()+all);
   $("#useridspplus").append(id);
   $("#usernamesp").append(name);
   $("#useridsp").append(id);
   
}
$(document).ready(function(){
   $("#ok").click(function(){//담당자 수정
      window.open(
             "/admin/projectadmin/memberselect?num="+$("#num").val(),
             "DescriptiveWindowName",
             "left=100,top=100,width=640,height=520"
           );
   })
   //window.open("/test2");
   
   
   
   $("#cbAll").on("change", function() {
		var flag = $(this).is(":checked");
		$(".checkbox").attr("checked", flag);
	});//체크하든 안 하든 발생
   
	$("#reset").click(function(){
	   $("#memberplus").empty();
	   $("#useridspplus").empty();
	   $("#usernamesp").empty();
	   $("#useridsp").empty();
	   MemberList();
	   
   });
	
	$("#delete").on("click",function(){
		if (confirm("정말로 삭제하시겠습니까?")) {
		$(".checkbox").each(function(i, obj) {
					var id=$(this).closest("label").attr("id");
					
					if($(this).is(":checked") == true){
						var idx = $("#lbl2"+i).data("idx");
						var params={
								idx:idx
						}
						$.ajax({
							type : "POST", // HTTP method type(GET, POST) 형식이다.
							url : "/memberselect/delete", // 컨트롤러에서 대기중인 URL 주소이다.
							beforeSend : function(xhr) {
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							data : params, // Json 형식의 데이터이다.
							success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
								alert("삭제되었습니다.");
								$("#useridsp").empty();
								MemberList();
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
								alert("통신 실패.")
							}
						});
					}
				});
		}
	});
});
 
</script>
<script>
function MemberList() {
	var params={
			num:$("#num").val()
			
	}
	
	$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/memberselect/select", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					
					if(res!=null||res!=''){
					$('#member').empty();
					var str = "";
					var uid="";

					$.each(res,function(i, v) { //i 인덱스 , v 값
						 str+="<input id='idx"+i+"' type='checkbox' class='checkbox' style='width: 17px; height: 17px; cursor: pointer;' name='memberselect' value='"+v.idx+"'>";
                         str+="<label id='lbl2"+i+"' data-idx='"+v.idx+"' data-name='"+v.username+"' data-id='"+v.userid+"' style='font-size:16px;'>"+"&nbsp;"+v.username+" (id: "+v.userid+")</label><br>";
                         uid+=v.userid+","
										
									})

					$('#member').append(str);
					$('#useridsp').append(uid);
					}
					if(res==null||res==''){
						
						$('#member').empty();
						$('#member').text("기존 담당자 없음");
						$("#nono").empty();
								}

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
	
}
</script>
<%@ include file="../../includes/adminfooter.jsp"%>