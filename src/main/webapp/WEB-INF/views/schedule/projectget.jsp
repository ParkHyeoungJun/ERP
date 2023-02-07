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
      <h1 id="titlename" class="page-header">프로젝트 일정 추가</h1>
   </div>
</div>
<hr><br>

   <div class=col-lg-12>
      <div class="panel-heading"></div>
      <div class="panel-body">
         <input type="hidden" id="num" name="num" value="0" />
<div class=col-lg-12>
      <div class="panel-heading"></div>
      <div class="panel-body">
         <div class="form-group row">
            <label class="control-label col-1" for="title">일정명</label>
            <div class="col-11">
            <label class="control-label"><c:out value='${vo.title}' /></label>
            <input type='hidden' id="title" value="${vo.title}" />
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
                <textarea rows="10" cols="50" class="form-control" id="con"
                  name="con"><c:out value='${vo.content}'/></textarea>

            </div>
         </div>
         <br /><br><br>
            <div align="right">
               <button id="btnSave" type="button" style="color:white;" class="btn btn-warning">스케쥴에 등록</button>
               <button class="btn btn-info" id="boardListBtn">목록</button>
            </div>
      </div>
   </div>
</div>


     </div>
</div>  
    <div style='visibility: hidden;'>
      <input type='date' id="startday" name="startday" value="${vo.startday}" />
      <input type='date' id="endday" name="endday" value="${vo.endday}" />
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
$(document).ready(function() {            
   $('#btnSave').on("click", function(e) {
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

      var params = {
         num : "0",
         title : $("#title").val(),
         content : CKEDITOR.instances['con'].getData(),
         startday: $("#startday").val()+"T00:00",
         endday: $("#endday").val()+"T23:59",
         personal: "1",
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
            alert("일정이 추가 되었습니다.");

            window.location.href = "/schedule/select";
         },
         error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });
   });
   $('#boardListBtn').on("click", function(e) {
      e.preventDefault();
      window.location.href = "/schedule/projectschedule";
   });
});
</script>

<%@ include file="../includes/clientfooter.jsp"%>

