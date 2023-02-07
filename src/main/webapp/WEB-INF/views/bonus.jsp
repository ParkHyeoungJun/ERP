<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="includes/clientheader.jsp"%>


<input type="hidden" id="pageNum" name="pageNum" value="1">
<input type="hidden" id="cnt" name="cnt" value="0">
<div>
	<h1>실적 리스트</h1>
</div>
<hr>
<div class="card-body">
	<select id="amount" name="amount">
		<option value="10">10</option>
		<option value="30">30</option>
		<option value="50">50</option>
		<option value="100">100</option>
	</select> &nbsp;&nbsp;&nbsp;<select name="type" id="type">
		<option value="T">아이디</option>
		<option value="C">프로젝트 넘버</option>
	</select> &nbsp;&nbsp;&nbsp; <input type="text" id="keyword" name="keyword">
	<button id="btnSearch" style="color: white; width:70px; height:30px; border:none; border-radius:3px; background-color: #343A40;">검색</button>
	<div style="float: right;">
		사유별로 검색: &nbsp;&nbsp;<select name="contentselect" id="contentselect">
			<option value="">-----</option>
			<option value="1">프로젝트 완료</option>
			<option value="2">관리자 권한으로 부여</option>
			<option value="3">기타</option>
		</select>
	</div>

</div>

<div class="card-body">
	<div class="table-responsive">
		<table class="table table-bordered " id="dataTable" width="100%">
			<thead>
				<tr>
					<th width='5%'>#</th>
					<th width='20%'>사유</th>
					<th width='20%'>아이디</th>
					<th width='15%'>추가실적</th>
					<th width='10%'>넘버</th>
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
<div id="hiddenDivLoading" style="visibility: hidden">
	<div id='load'>
		<img src='/resources/img/loading.gif' />
	</div>
</div>

<div style="text-align: center;">
	<button class="form-control"
		style="display: inline-block; width: 200px; border: none; color: white; background-color: #17a2b8;"
		id="bonusmove">실적 차트로 이동</button>
</div>
<br><br>

<script>
function List() {
   
   var params = {            
         pageNum : $("#pageNum").val(),
            amount  : $("#amount").val(),
            type : $("#type").val(),
            keyword : $("#keyword").val(),
            contentselect : $("#contentselect").val()
         }

$.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/admin/bonus/select", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

            $('#load').show();
            // 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
            $("#hiddenDivLoading").show()
                  .css(
                        {
                           top : $(document).scrollTop()
                                 + ($(window).height())
                                 / 2.6 + 'px',
                           left : ($(window).width()) / 2.6
                                 + 'px'
                        });
            $("#hiddenDivLoading").show();
         },
         data : params, // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            // 응답코드 > 0000
            //alert(res);

            $('#dataTable').empty();
            $('#dataTable')
                  .append(
                  
                        "<thead><th width='5%'>#</th><th width='20%'>사유</th><th width='20%'>아이디</th><th width='15%'>추가실적</th><th width='10%'>넘버</th><th width='15%'>작성자</th><th width='15%'>작성일</th></thead>")
            var str = "";

            if (Object.keys(res).length == 0) { //데이터가 없을 경우
            	
                str += "<tr><td colspan=7 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
                
                $("#cnt").val("0");
                $("#cntview").text("총 게시물 수: " + "0" + "개");
                $('#dataTable').append(str);
                getPager();
                return ;
             }
            
            $
                  .each(
                        res,
                        function(i, v) { //i 인덱스 , v 값
                           
                           $("#cnt").val(v.cnt);
                           $("#cntview").text("총 게시물 수: " + v.cnt + "개");
                           str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
                           str += '<td>' + v.idx + "</td>"
                           str += '<td>' + getConData(v.con) +'</td>';
                           str += '<td>' + v.userid +'</td>';
                           str += '<td>' + v.bonus +'</td>';
                           str += '<td>' + getNumData(v.num) +'</td>';
                           str += '<td>' + v.writer + '</td>';
                           str += '<td>' + v.daytostring + '</td>';
                           
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
  if(pagelist>10) pagelist =10;
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

function getNumData(num){
   if(num==null || num==''){
      return '-';
   }else{
      return num;
   }
}

function getConData(con){
   if(con=='1'){
      return '프로젝트 완료';
   }
   if(con=='2'){
      return '관리자 권한으로 부여';
   }
   if(con=='3'){
      return '기타';
   }
}

</script>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ready(function() {
   List();
   
   $("#bonusmove").on("click", function() {
		window.location.href = "/clientcharts";	
	});
   
   // 검색 버튼 클릭시
   $("#btnSearch").on("click",function(){
        List();         
   });
  //기간 설정시
   $("#contentselect").on("change",function(){
      
        List();         
   });
   
   // 페이징 SELECT BOX 선택시
     $("#amount").on("change",function(){
        $("#pageNum").val("1");
        List();
     });
   
   // 페이징 처리후 다시 조회 
   $(document).on("click", ".page-item a", function(e){
        e.preventDefault();
        $("#pageNum").val($(this).attr("href"));   
        List();
        
   });
   
});
</script>


<%@ include file="includes/clientfooter.jsp"%>