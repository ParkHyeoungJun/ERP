<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="../includes/clientheader.jsp"%>

<input type='hidden' id="idx" name="idx" value="<c:out value="${vo.idx}"></c:out>" />
<input type='hidden' id="code" name="code" value="<c:out value="${vo.code}"></c:out>" />

<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">신고글 확인</h1>
   </div>
</div>

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
                  <input class="form-control" id="sel" name="sel" 
                  value="<c:out value='${vo.sel}'/>" readonly="readonly" />
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="content">원글 내용</label>
               <div class="col-11">
                  <textarea class="form-control" rows="5" cols="50" id="content"
                     name="content" readonly="readonly"><c:out
                        value="${vo.content}" /></textarea>
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="val">신고글 내용</label>
               <div class="col-11">
                  <textarea class="form-control" rows="10" cols="50" id="val"
                     name="val" readonly="readonly"><c:out
                        value="${vo.val}" /></textarea>
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="writer">작성자</label>
               <div class="col-11">
                  <input class="form-control" id="writer" name="writer" 
                  value='<c:out value="${vo.writer}"/>' readonly="readonly" />
               </div>
            </div>
            <div class="form-group row">
                     <label class="control-label col-1" for="day">작성일</label>
                     <div class="col-11">
                        <input class="form-control" id="day" name="day" 
                        value='<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.day}" />' 
                        readonly="readonly" />
                  </div>
            </div>
            
            <br />
            <!-- <button class="btn btn-warning" id="boardGetBtn">확인</button> -->
            <div align="right">
            <button class="btn btn-danger" id="boardDeleteBtn">삭제</button>
            <button class="btn btn-info" id="boardListBtn">목록</button>
            </div>
         </div>
      </div>
   </div>
</div>


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
CKEDITOR.replace('val', ckeditor_config); //웹에디터

$(document).ready(function(e){
   /* $("#boardGetBtn").on("click", function() {
      if("<c:out value='${vo.title}'/>" == "") {
         alert("신고된 게시글이 삭제되었습니다.");
         return;
      } else {
         window.location.href="/admin/board/get?code="+$("#code").val()+ "&num=" + $("#num").val();
         return;
      } 
   }); */
   $("#boardListBtn").on("click", function() {
      window.location.href = "/board/declarlist";
   });
    $("#boardDeleteBtn").on("click",function(e){
        e.preventDefault();
        if (confirm("정말로 삭제하시겠습니까?")) {
           var params = {
              idx : $("#idx").val()
           }
           $.ajax({
              type : "POST", // HTTP method type(GET, POST) 형식이다.
              url : "/board/declardelete", // 컨트롤러에서 대기중인 URL 주소이다.
              beforeSend : function(xhr) {
                 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
              },
              data : params, // Json 형식의 데이터이다.
              success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                 alert("삭제되었습니다");                 
                 window.location.href = "/board/declarlist";        
              },
              error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                 alert("통신 실패.")
              }
           });
        }
     });
});
</script>
<%@ include file="../includes/clientfooter.jsp"%>