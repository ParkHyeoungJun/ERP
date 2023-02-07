<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<style>
.center {
   justify-content: center;
   align-items: center;
}

table {
   table-layout: fixed;
   word-break: break-all;
}
</style>

<input type="hidden" name="${_csrf.parameterName}"
   value="${_csrf.token}" />
<input type='hidden' id='writer'
   value='<sec:authentication property="principal.username"/>'>
<input type="hidden" id="cnt" name="cnt" value="0">
<input type="hidden" id="pageNum" name="pageNum" value="1">

<div class="card shadow mb-4">
   <div class="card-body">
	<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">
			신고리스트
		</h1>
	</div>
</div>
	<hr>
	<div style="width:70%; padding-top:5px; display: inline-block;">
      <select id="amount" name="amount">
         <option value="10">10</option>
         <option value="30">30</option>
         <option value="50">50</option>
         <option value="100">100</option>
      </select> <select name="type" id="type">
         <option value="T">번호</option>
         <option value="C">해당게시글 번호</option>
         <option value="W">작성자</option>
      </select> &nbsp;&nbsp;&nbsp; <input type="text" id="keyword">
      <button id="btnSearch"
			style="color: white; width:70px; height:30px; border:none; border-radius:3px; background-color: #4e73df;">검색</button>
	</div>
	<div align="right" style="float:right; display: inline-block;">
		<a onclick="ExportToExcel()" id="Excel"><button class="btn btn-warning">엑셀저장</button></a>
	</div>
	
		<br><br>
   <div class="card-body">
      <div class="table-responsive">
         <table class="table table-bordered " id="dataTable" width="100%">
            <thead>
               <tr>
                  <th>번호</th>
                  <th>해당게시물번호</th>
                  <th>신고사유</th>
                  <th>작성자</th>
                  <th>신고일</th>
               </tr>
            </thead>
         </table>
         <br>
         <div id='cntview' style='float: right;'></div>
         <div id="pager"></div>
      </div>
   </div>
</div>

<div id="hiddenDivLoading" style="visibility: hidden">
   <div id='load'>
      <img src='/resources/img/loading.gif' />
   </div>
</div>
</div>

<script>
   function List() {
        var params = {
                  type : $("#type").val(),
                  keyword : $("#keyword").val(),
                  pageNum : $("#pageNum").val(),
                  amount  : $("#amount").val()
               }
            
            $
            $.ajax({
               type : "POST", // HTTP method type(GET, POST) 형식이다.
               url : "/admin/board/declarlist", // 컨트롤러에서 대기중인 URL 주소이다.
               beforeSend : function(xhr) {
                  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
               },
               data : params, // Json 형식의 데이터이다.
               success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               //   alert(Object.keys(res).length)
                $('#dataTable').empty();
               var str ="<thead><tr><th>번호</th><th>해당게시물번호</th><th>신고사유</th><th>작성자</th><th>신고일</th></tr></thead>"; 
               
               if (Object.keys(res).length == 0) { //데이터가 없을 경우
               	
                   str += "<tr><td colspan=5 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
                   
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
                     str += "<td style='cursor:pointer' onclick=getRowData('"+ v.idx + "'";
                     str += ")>" + v.idx + "</td>"
                     str += '<td>' + v.num + '</td>';
                     str += '<td>' + v.sel + '</td>';
                     str += '<td>' + v.writer + '</td>';
                     str += '<td>' + new Date(v.day).toISOString().slice(0, 10) + '</td>';
                     str += '</tr>'
                  })
                  $('#dataTable').append(str);   
                  getPager();
               
               },
               error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                  alert("통신 실패.")
               }
            });
         //   getPager();
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
    function getRowData(idx)
      {
         window.location.href="/admin/board/declarview?idx="+idx
         //alert(userid)
      }
</script>
<script>
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   $(document).ready(function() {
      List();
      
       $("#btnSearch").on("click",function(){
            List();         
         });
         // 페이징 SELECT BOX 선택시
         $("#amount").on("change",function(){
            $("#pageNum").val("1");
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
         
         // 텍스트 박스에서 엔터 입력시 검색 
         $("#keyword").on("keyup",function(key){
             if(key.keyCode==13) {
                List();
             }
         });

      $(document).ajaxStop(function() {
      });
      //ajaxComplete 은 실행 완료 시에만 실행 
      $(document).ajaxComplete(function() {

         $('#load').hide();
         $("#hiddenDivLoading").hide();
      });
      
       // 페이징 처리후 다시 조회 
        
   });
</script>
<script>
   function ExportToExcel() {
      var htmltable = document.getElementById("dataTable");

      var html = htmltable.outerHTML; //innerHTML: 태그 안쪽 값만 가져옴. outer: 해당 태그까지 모두 가져옴.
      //alert(html)
      window
      .open('data:application/vnd.ms-excel,\ufeff'
                  + (encodeURIComponent(html)));
      //window.open : 팝업창 띄우는 함수
      //data:application/vnd.ms-excel : 파일의 헤더 정보를 강제로 엑셀로 지정함.
      //encodeURIComponent: URI의 특정한 문자를 UTF-8로 인코딩
   }
</script>

<%@ include file="../../includes/adminfooter.jsp"%>