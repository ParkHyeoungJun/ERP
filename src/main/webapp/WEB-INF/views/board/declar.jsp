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

<input type='hidden' id="code" name="code" value="<c:out value="${code}"></c:out>" />
<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">작성물 신고</h1>
   </div>
</div>
<br>
<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default">
         <div class="panel-body container">
            <input type="hidden" name="${_csrf.parameterName }"
               value="${_csrf.token}" /> <input type="hidden"
               name="${_csrf.parameterName }" value="${_csrf.token}" />
            <div class="form-group row">
                     <label class="control-label col-1" for="num">게시물번호</label>
                     <div class="col-11">
                        <input class="form-control" id="num" name="num"
                        value="<c:out value='${vo.num}'/>" readonly="readonly" />
                    </div>
               </div>
               <div class="form-group row">
                     <label class="control-label col-1" for="title">제목</label>
                     <div class="col-11">
                        <input class="form-control" id="title" name="title"
                        value="<c:out value='${vo.title}'/>" readonly="readonly" />
                     </div>
               </div>
            <div class="form-group row">
               <label class="control-label col-1" for="sel">신고사유</label>
               <div class="col-11">
                  <select class="form-control" id="sel" name="sel"><option
                        value="">-----</option></select>
               </div>
            </div>
            <div class="form-group row">
                     <label class="control-label col-1" for="con">원글 내용</label>
                     <div class="col-11">
                        <input class="form-control" id="con" name="con"
                        value="<c:out value='${vo.content}'/>" readonly="readonly" />
                     </div>
               </div>
            <div class="form-group row">
               <label class="control-label col-1" for="val">내용</label>
               <div class="col-11">
                  <textarea class="form-control" rows="10" cols="50" id="val"
                     name="val"></textarea>
               </div>
            </div>
            
            <br />
            <div align="right">
            <button class="btn btn-danger" id="btnSave">신고</button>
            <button class="btn btn-info" id="boardGetBtn">이전</button>
            </div><br>
         </div>
      </div>
   </div>
</div>
</div>
<script src="//cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script>
var csrfHeaderName= "${_csrf.headerName}";
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
CKEDITOR.replace('val', ckeditor_config); //웹에디터

$(document).ready(function(e){
   $.ajax({
        type : "POST", // HTTP method type(GET, POST) 형식이다.
        url : "/declar/sel", // 컨트롤러에서 대기중인 URL 주소이다.
        beforeSend : function(xhr) {
           xhr.setRequestHeader(csrfHeaderName,
                 csrfTokenValue);
        },
        //data : "list", // Json 형식의 데이터이다.
        success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
           $.each(res, function(i, item) {
              $('#sel').append($('<option>', {
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
   $("#btnSave").on("click",function(e){
      e.preventDefault();
         if ($("#sel").val() === "") {
            alert("신고사유를 입력하여 주세요");
            $("#sel").focus();
            return false;
         }
         if (CKEDITOR.instances['val'].getData() === "") {
            alert("내용을 입력하여 주세요");
            return false;
         }

         var params = {
            idx : '0',
            code : $("#code").val(),
            num : $("#num").val(),
            sel : $("#sel").val(),
            val : CKEDITOR.instances['val'].getData(),
            writer : userid,
            title : $("#title").val(),
            content : $("#con").val()
         }
         //alert(params.content);
         
         $.ajax({
            type : "POST",
            url : "/board/declar",
            beforeSend : function(xhr) {
               xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data : params,
            success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               alert("해당 글을 신고하였습니다.");
               ///$("#num").val("0");
               
               window.location.href="/board/select?code="+$("#code").val(); //비동기 식 링크 넘기는 방식. 동기식은 form 액션값 바꿔서 보냄.
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("통신 실패.")
            }
         });
   });
   $('#boardGetBtn').on(
            "click",
            function(e) {
               e.preventDefault();

               window.location.href = "/board/get?code="
                   + $("#code").val() + "&num="
                   + $("#num").val();
            });
   
});
</script>
<%@ include file="../includes/clientfooter.jsp"%>