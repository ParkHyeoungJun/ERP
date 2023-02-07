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

table {
   table-layout: fixed;
   word-break: break-all;
}
</style>

<input type="hidden" id="code" name="code" value="${code}">
<input type="hidden" id="pageNum" name="pageNum" value="1">
<input type="hidden" id="cnt" name="cnt" value="0">
<input type="hidden" id="writer" name="writer" value=userid>

<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">내 게시글</h1>
   </div>
</div>
<br>
<div class="card shadow mb-4">
   <div class="card-body">
      <select id="amount" name="amount">
         <option value="10">10</option>
         <option value="30">30</option>
         <option value="50">50</option>
         <option value="100">100</option>
      </select> &nbsp;&nbsp;&nbsp;<select name="type" id="type">
         <option value="T">게시판이름</option>
         <option value="C">제목</option>
         <option value="W">내용</option>
      </select> &nbsp;&nbsp;&nbsp; <input type="text" id="keyword" name="keyword">
      <button id="btnSearch"
         style="color: white; width:70px; height:30px; border:none; border-radius:3px; background-color: #343A40;">검색</button>

   </div>
   <div class="card-body">
      <div class="table-responsive">
         <table class="table table-bordered" id="dataTable">
            <thead>
               <tr>
                  <th width='6%'>번호</th>
                  <th width='64%'>제목</th>
                  <th width='15%'>작성자</th>
                  <th width='15%'>작성일</th>
               </tr>
            </thead>
         </table>
         <br>
         <div id='cntview' style='float: right;'></div>
         <div class="center" id="pager"></div>
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
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   <sec:authorize access="isAnonymous()">
      window.location.href = "/login";
   </sec:authorize>
   <sec:authorize access="isAuthenticated()">
      var userid = '<sec:authentication property="principal.username"/>';
   </sec:authorize>
   $(document).ready(function(e) {
       List();
   });
</script>
<script>
   function List() {
      var params = {            
            pageNum : $("#pageNum").val(),
            amount  : $("#amount").val(),
            type : $("#type").val(),
            keyword : $("#keyword").val(),
            code : $("#code").val(),
            writer : userid
         }
      
      
      $.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/admin/board/myselect", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            
            $('#load').show();
           // 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
           $("#hiddenDivLoading").show().css({
               top: $(document).scrollTop()+ ($(window).height() )/2.6 + 'px',
               left: ($(window).width() )/2.6 + 'px'
           });
         },
         data : params, // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
       //  alert(Object.keys(res).length)
         
          var str = "";
         
         $('#dataTable').empty();
         $('#dataTable')
               .append(
                     "<thead><th width='6%'>번호</th><th width='64%'>제목</th><th width='15%'>작성자</th><th width='15%'>작성일</th></thead>")
        
         if (Object.keys(res).length == 0) { //데이터가 없을 경우
                      
                       str += "<tr><td colspan=4 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
                       
                       $("#cnt").val("0");
                      $("#cntview").text("총 게시물 수: " + "0" + "개");
                       $('#dataTable').append(str);
                       getPager();
                       return ;
                    }
         
         $.each(res,function(i, v) { //i 인덱스 , v 값
                     //alert(v.cnt)
                     $("#cnt").val(v.cnt);
                     $("#cntview").text("총 게시물 수: " + v.cnt + "개");
                        str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
                        if(v.notice==true)
                        {
                        
                           str += "<td style='color:green;'>"+ v.num+ "</td>"                        
                            str += '<td><a style="color:green;" href=/board/get?code='+ v.code +"&num="+v.num+" class='move'>"+ getDepth(v.depth,v.title) + '</a></td>';
                            str += '<td style="color:green;">' + v.writer + '</td>';
                            str += '<td style="color:green;">' + v.daytostring + '</td>';                            
                        }
                        else
                        {
                           str += "<td>"+ v.num+ "</td>"                        
                            str += '<td><a href=/board/get?code='+ v.code +"&num="+v.num+" class='move'>"+ getDepth(v.depth,v.title) + '</a></td>';
                            str += '<td>' + v.writer + '</td>';
                            str += '<td>' + v.daytostring + '</td>';                            
                        }
               
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

   function getPager()
   {
      var totalData =$("#cnt").val(); //총 데이터 수
      var dataPerPage = $("#amount").val(); //한 페이지에 나타낼 글 수
      var pagelist = Math.ceil($("#cnt").val()/$("#amount").val(),0);
      //if(pagelist>10) pagelist =10;
      var pageCount = pagelist //페이징에 나타낼 페이지 수 무족건 10
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


   
   // depth가 0 이면 그냥 제목만 아님 depth 만큼 깊이 구현 해주고 이미지 구현
   function getDepth(depth,title)
   {
      var str="";
      if(depth==0)
      {
         return title;
      }
      else
      {
         for (var i = 0; i < depth; i++) {
            str +="&nbsp;&nbsp;";   
         }
         str +="<img src='/resources/img/re.gif' />"
         str +=title;
      }
      
      return str;
   }
  
  
</script>


<script>
   $(document).ready(function() {      
      List();

      // 검색 버튼 클릭시
      $("#btnSearch").on("click",function(){
         List();         
      });
      // 페이징 SELECT BOX 선택시
      $("#amount").on("change",function(){
         List();
      });
     
      // 페이징 처리후 다시 조회 
      $(document).on("click", ".page-item a", function(e){
         e.preventDefault();
         $("#pageNum").val($(this).attr("href"));   
         List();
         var delay =1000; // 스크롤 최상단으로 이동
         $('html, body').animate({scrollTop: 0}, delay);
      });
      
    
   });
</script>
<%@ include file="../includes/clientfooter.jsp"%>