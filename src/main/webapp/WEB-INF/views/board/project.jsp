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
      <h1 id="titlename" class="page-header">프로젝트 확인</h1>
   </div>
</div>
<hr><br>
<div>
   <div class=col-lg-12>
      <div class="panel-heading"></div>
      <div class="panel-body">

         <div class="form-group row">
            <label class="control-label col-1" for="title">제목</label>
            <div class="col-11">
               <label class="control-label"><c:out value='${vo.title}' /></label>
            </div>
         </div>
         <div class="form-group row">
            <label class="control-label col-1" for="period">기간</label>
            <div class="col-11">
               <label class="control-label"><c:out value='${vo.startday}' /></label>
               <span>&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
               <label class="control-label"><c:out value='${vo.endday}' /></label>
               <span style="color:red;" id="deadlinefin"><b id="deadline"></b> 일 남음)</span>
            </div>
         </div>

         <div class="form-group row">
            <label class="control-label col-1" for="con">내용</label>
            <div class="col-11">
               <div class="col-11">${vo.content}</div>

            </div>
         </div>
         <div class="form-group row">
               <label class="control-label col-1" for="memberselect">담당자</label>
               <div class="col-11">
                     <div id="member"></div>
                     <%-- <textarea rows="5" cols="50" class="form-control" id="member"
                  name="member" maxlength="1000" readonly="readonly"><c:out value="${vo.member}"></c:out></textarea> --%>
            </div>
            </div>
            
         <div class="form-group row">
            <label class="control-label col-1" for="writer">작성자</label>
            <div class="col-11">${vo.writer}</div>
         </div>
         <div class="form-group row">
               <label class="control-label col-1" for="day">작성일</label>
               <div class="col-11">
               <label class="control-label"><fmt:formatDate
                        pattern="yyyy-MM-dd" value="${vo.day}" /></label>
               
            </div>
            </div>
         <div class="form-group row">
            <label class="control-label col-1" for="progress">완료 여부</label>
            
            <div class="col-11">
            <label class="control-label"><c:set var='progress'
                        value='${vo.progress}' /> <c:if test='${progress eq "false"}'>
                        <c:out value='진행중' />
                     </c:if> <c:if test='${progress eq "true"}'>
                        <c:out value='완료' />
                     </c:if></label>
            </div>
            
         </div>
         <br />
         <button class="btn btn-info" id="boardListBtn" style='float: right;'>목록</button>
         <br><br>
      
      </div>
      
   </div>
   
</div>
</div>
<div style='visibility: hidden;'>
      <input type='text' id="day" name="day" value="${vo.day}" />
      <input type='date' id="endday" name="endday" value="${vo.endday}" />
      <input type='text' id="progress" name="progress" value="${vo.progress}" />
   </div>
<script>
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   $(document).ready(
         function() {

            deadline();
            $('#boardListBtn').on(
                  "click",
                  function(e) {
                     e.preventDefault();

                     window.location.href = "/board/project";   
                  });
            
            MemberList();
         });

            
</script>
<script>
function deadline(){
   
   var e = $('#endday').val();
   var p = $('#progress').val();
   
   var now = new Date();
         
   var year = now.getFullYear();
   var month = now.getMonth();
   var date = now.getDate();
         
   var sys = new Date (year,month,date);
   var endday = new Date(e);
   
   var gap = endday.getTime() - sys.getTime();
   var deadline = Math.ceil(gap / (1000*60*60*24));
   
   if(deadline<0){
      $("#deadlinefin").text(" (기간 지남)");
   }else if(deadline==0){
      $("#deadlinefin").text(" (당일 마감)");
   }else{
      $("#deadline").text(" ("+deadline);
   }
   
   if(p == "true"){
      $("#deadlinefin").text(" (완료된 프로젝트)");
   }
   
   
   }
   
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

               $.each(res,function(i, v) { //i 인덱스 , v 값
                              str += "<input type='hidden' id='idx' value='"+v.idx+"'>";
                              str += "<span id='username' style='font-size:16px;'>"+v.username+"</span>";
                              str += "<span id='userid' style='font-size:16px;'>(id :"+v.userid+")</span>";
                              str += "<br>";
                              
                           })

               $('#member').append(str);
               }if(res==null||res==''){
                  
                  
                  $('#member').text("담당자 없음");
                  
                        }

            },
            error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("통신 실패.")
            }
         });
}
</script>
<%@ include file="../includes/clientfooter.jsp"%>