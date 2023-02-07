<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>

<style>
.col-1 {
  flex: 0 0 11.33333%;
  max-width: 11.33333%;
}

.col-11 {
  flex: 0 0 88.66667%;
  max-width: 88.66667%;
}
</style>
<input type='hidden' id="idx" name="idx" value="<c:out value="${vo.idx}"></c:out>" />
<input type='hidden' id="code" name="code" value="<c:out value="${vo.code}"></c:out>" />
<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">신고글 확인</h1>
   </div>
</div>
<hr><br>
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
                       <label class="control-label"><c:out value='${vo.num}' /></label>
                    </div>
               </div>
               <div class="form-group row">
                     <label class="control-label col-1" for="title">제목</label>
                     <div class="col-11">
                        <label class="control-label"><c:out value='${vo.title}' /></label>
                     </div>
               </div>
            <div class="form-group row">
               <label class="control-label col-1" for="sel">신고사유</label>
               <div class="col-11">
                  <label class="control-label"><c:out value='${vo.sel}' /></label>
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="content">원글 내용</label>
               <div class="col-11">
                  <label class="control-label"><c:out value='${vo.content}' /></label>
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="val">신고글 내용</label>
               <div class="col-11">${vo.val}</div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="writer">작성자</label>
               <div class="col-11">
                  <label class="control-label"><c:out value='${vo.writer}' /></label>
               </div>
            </div>
            <div class="form-group row">
            	<label class="control-label col-1" for="day">작성일</label>
                <div class="col-11">
                	 <label class="control-label"><fmt:formatDate
                        pattern="yyyy-MM-dd" value="${vo.day}" /></label>
                  </div>
            </div>
            
            <br />
            <div align="right">
            <!-- <button class="btn btn-warning" id="boardGetBtn">확인</button> -->
            <button class="btn btn-danger" id="boardDeleteBtn">삭제</button>
            <button class="btn btn-info" id="boardListBtn">목록</button>
            </div><br>
         </div>
      </div>
   </div>
</div>
</div>

<script>
var csrfHeaderName= "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

</script>
<script>

$(document).ready(function(e){
	/* $("#boardGetBtn").on("click", function() {
      if("<c:out value='${vo.title}'/>" == "") {
         alert("신고된 게시글이 삭제되었습니다.");
         return;
      } else {
         window.location.href="/client/board/get?code="+$("#code").val()+ "&num=" + $("#num").val();
         return;
      } 
   }); */
   $("#boardListBtn").on("click", function() {
      window.location.href = "/declar/mydeclar";
   });
    $("#boardDeleteBtn").on("click",function(e){
        e.preventDefault();
        if (confirm("정말로 삭제하시겠습니까?")) {
           var params = {
              idx : $("#idx").val()
           }
           $.ajax({
              type : "POST", // HTTP method type(GET, POST) 형식이다.
              url : "/admin/board/declardelete", // 컨트롤러에서 대기중인 URL 주소이다.
              beforeSend : function(xhr) {
                 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
              },
              data : params, // Json 형식의 데이터이다.
              success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                 alert("삭제되었습니다");                 
                 window.location.href = "/declar/mydeclar";        
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