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
<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 id="titlename" class="page-header">스케쥴 추가</h1>
   </div>
</div>

<div>
<br>
   <div class=col-lg-12>
      <div class="panel-heading"></div>
      <div class="panel-body">
         <input type="hidden" id="num" name="num" value="0" />

         <div class="form-group row">
            <label class="control-label col-1" for="title">일정명</label>
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
                  id="startday" name='startday' type="datetime-local"> <span>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
               <input class="form-control" maxlength="10"
                  style="display: inline-block; width: 47%;" id="endday"
                  name='endday' type="datetime-local">
               
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
            <label class="control-label col-1" for="personal">분류</label>
            <div class="col-11">
                  <select class="form-control" id="personal" name="personal"><option
                        value="">-----</option></select>
               </div>
         </div>

         <br />
         <div align="right">
            <button id="btnSave" type="button" style="color:white;" class="btn btn-warning">등록</button>
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
   <sec:authorize access="isAnonymous()">
   window.location.href = "/login";
   </sec:authorize>
   <sec:authorize access="isAuthenticated()">
   var userid = '<sec:authentication property="principal.username"/>';
   </sec:authorize>

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
   $.ajax({
        type : "POST", // HTTP method type(GET, POST) 형식이다.
        url : "/schedule/personal", // 컨트롤러에서 대기중인 URL 주소이다.
        beforeSend : function(xhr) {
           xhr.setRequestHeader(csrfHeaderName,
                 csrfTokenValue);
        },
        //data : "list", // Json 형식의 데이터이다.
        success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
           $.each(res, function(i, item) {
              $('#personal').append($('<option>', {
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
      $('#boardListBtn').on("click",function(e) {
         e.preventDefault();

         window.location.href = "/schedule/select";
      });

      $("#btnSave").on("click",function(e) {
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
         if ($("#endday").val() < $("#startday").val()) {
            alert("기간을 다시 확인 해주세요");
            $("#endday").focus();
            return false;
         }
         if ($("#personal").val() === "") {
            alert("일정을 분류 해주세요");
            $("#personal").focus();
            return false;
         }

         var params = {
            num : $("#num").val(),
            title : $("#title").val(),
            content : CKEDITOR.instances['con'].getData(),
            startday: $("#startday").val(),
            endday: $("#endday").val(),
            personal: $("#personal").val(),
            writer: userid
         }
                                 
         $.ajax({
            type : "POST",
            url : "/schedule/add",
            beforeSend : function(xhr) {
               xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
            },
            data : params,
            success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               alert("저장 되었습니다");

               window.location.href = "/schedule/select";
            },
            error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("통신 실패.")
            }
         });

      });

});
</script>



<%@ include file="../includes/clientfooter.jsp"%>