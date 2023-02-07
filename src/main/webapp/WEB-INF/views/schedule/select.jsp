<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>
<style>
.center {
   justify-content: center;
   align-items: center;
}
</style>
<input type="hidden" id="pageNum" name="pageNum" value="1">
<input type="hidden" id="cnt" name="cnt" value="0">
<input type="hidden" id="writer" name="writer" value=userid>

<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">스케쥴 관리</h1>
   </div>
</div>
<br>
<div class="card shadow mb-4">
   <div>
   <div class="card-body" style="width:50%; padding-top:20px; display: inline-block;">
      <select id="amount" name="amount">
         <option value="10">10</option>
         <option value="30">30</option>
         <option value="50">50</option>
      </select> &nbsp;&nbsp;&nbsp;<select name="type" id="type">
         <option value="T">번호</option>
         <option value="C">일정분류</option>
         <option value="W">제목</option>
         <!-- <option value="W">아이디</option> -->
      </select> &nbsp;&nbsp;&nbsp; <input type="text" id="keyword" name="keyword">
      <button id="btnSearch"
         style="color: white; width:70px; height:30px; border:none; border-radius:3px; background-color: #343A40;">검색</button>
</div>  
      <div align="right" style="float:right; width:20px; padding-top:15px; padding-right:120px; display: inline-block;">
      <button id="btnwriter"
         class="btn btn-warning" style="color:white; width:100px;">일정추가</button>
      </div>
   </div>
   <div class="card-body">
      <div class="table-responsive">
         <table class="table table-bordered" id="dataTable" width="100%"
            cellspacing="0">
            <thead>
               <tr>
                  <th>번호</th>
                  <th>일정분류</th>
                  <th>기간</th>
                  <th>제목</th>
                  <th>입력일</th>
                  <th>수정일</th>
               </tr>
            </thead>
         </table>
      </div>
      <br>
      <div id='cntview' style='float: right;'></div>
      <div class="row center" id="pager"></div>
   </div>
</div>

<div id="hiddenDivLoading" style="visibility: hidden">
   <div id='load'>
      <img src='/resources/img/loading.gif' />
   </div>
</div>
</div>
<script>
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   <sec:authorize access="isAnonymous()">
      window.location.href = "/login";
   </sec:authorize>
   <sec:authorize access="isAuthenticated()">
      var userid = '<sec:authentication property="principal.username"/>';
   </sec:authorize>
</script>
<script>
function List()
{

   var params = {
         type : $("#type").val(),
         keyword : $("#keyword").val(),
         pageNum : $("#pageNum").val(),
         amount  : $("#amount").val(),
         writer : userid
      }
   
   $
   $.ajax({
      type : "POST", // HTTP method type(GET, POST) 형식이다.
      url : "/schedule/select", // 컨트롤러에서 대기중인 URL 주소이다.
      beforeSend : function(xhr) {
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      data : params, // Json 형식의 데이터이다.
      success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
      //   alert(Object.keys(res).length)
      $('#dataTable').empty();
      var str ="<thead><tr><th>번호</th><th>일정분류</th><th>기간</th><th>제목</th><th>입력일</th><th>수정일</th></tr></thead>"; 
      
      if (Object.keys(res).length == 0) { //데이터가 없을 경우
            
          str += "<tr><td colspan=6 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
          
          $("#cnt").val("0");
          $("#cntview").text("총 게시물 수: " + "0" + "개");
          $('#dataTable').append(str);
          getPager();
          return ;
       }
      
         $.each(res,   function(i, v) { //i 인덱스           
            $("#cnt").val(v.cnt);
            $("#cntview").text("총 게시물 수: " + v.cnt + "개");
            str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
            str += "<td style='cursor:pointer' onclick=getRowData('"+ v.num + "'";
            str += ")>" + v.num + "</td>"
            str += '<td>' + v.personal + '</td>';
            str += '<td>' + v.startday.slice(0, 10) + '&nbsp;' + v.startday.slice(11, 16) + '~' + v.endday.slice(0, 10) + '&nbsp;' + v.endday.slice(11, 16) + '</td>';
            str += '<td>' + v.title.slice(0, 10) + '</td>';
            str += '<td>' + new Date(v.day).toISOString().slice(0, 10) + '</td>';
            str += '<td>' + new Date(v.updatedate).toISOString().slice(0, 10) + '</td>';
            str += '</tr>'            
            })
         $('#dataTable').append(str);         
         getPager();
      },
      error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
         alert("통신 실패.")
      }
   });
}

function getRowData(num)
{   
   window.location.href="/schedule/get?num="+num   
}

function getPager()
{
   var totalData =$("#cnt").val(); //총 데이터 수
   //alert(totalData)
   var dataPerPage = $("#amount").val(); //한 페이지에 나타낼 글 수
   var pagelist = parseFloat(Math.ceil($("#cnt").val()/$("#amount").val()));
   //alert(pagelist)
  // if(pagelist>10) pagelist =10;
   var pageCount = pagelist //페이징에 나타낼 페이지 수 무족건 10
   //alert(pagelist)
   //alert("총건수:"+$("#cnt").val()+",amount:"+$("#amount").val()+",pageCount:"+pageCount)
   var currentPage=$("#pageNum").val(); //현재 페이지
   var pageNum =1;
   if($("#pageNum").val() !="1")
   {
      pageNum =    $("#pageNum").val()
   }
   
   var endNum = Math.ceil(pageNum / 10) * 10;
   //var startNum = endNum - (endNum -currentPage);// 1
   var startNum = (endNum +1) -dataPerPage
     if(startNum <0)
     {
        startNum =1;   
     }
   totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
  
   if(totalPage<pageCount){
     pageCount=totalPage;
   }
   //alert(startNum+","+totalPage+","+totalPage)
  var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
   var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
   

   var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
     if(last > totalPage)
         last = totalPage;
     var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
     var next = last+1;
     var prev = first-1;
   //let pageHtml = "";
   
       var str = "<ul class='pagination";
       str+=" justify-content-center'>";
       if (currentPage>10) {
          str += "<li class='page-item'><a ";
          str += "class='page-link' href='";
          str += (startNum - 1);
          str += "'>이전</a></li>";
       }
       //alert(Math.round((10/currentPage) == prev))
       for (var i = startNum; i <= pageCount; i++) {
          var active = pageNum == i ? "active" : "";
          str += "<li class='page-item "+ active
          +"'><a  class='page-link' ";
          
          if(last ==i)
         {
             str+="href='"+i+"'>마지막</a></li>";
         }
         else
         {
             str+="href='"+i+"'>"
              + i + "</a></li>";
         }
         
       }
       if (last < totalPage) {
          str += "<li class='page-item'>";
          str += "<a  class='page-link' href='";
          str += (endNum + 1) + "'>다음</a></li>";
       }

       str += "</ul>";
     //  alert(str);
    $("#pager").html(str);
}    





// 페이징 SELECT BOX 선택시
   $("#amount").on("change",function(){
      $("#pageNum").val("1");
      List();
   });


$(document).ready(function(){
   List();
   $("#btnwriter").on("click", function() {
       window.location.href = "/schedule/add";
    });
   $("#btnSearch").on("click",function(){
      List();
   });
   $(document).on("click", ".page-item a", function(e){
       e.preventDefault();
       $("#pageNum").val($(this).attr("href"));   
       //alert($("#pageNum").val())
       List();
       var delay =1000; // 스크롤 최상단으로 이동
       $('html, body').animate({scrollTop: 0}, delay);
    });
   $("#amount").on("change",function(){
      List();
   });
});
</script>
<%@ include file="../includes/clientfooter.jsp"%>