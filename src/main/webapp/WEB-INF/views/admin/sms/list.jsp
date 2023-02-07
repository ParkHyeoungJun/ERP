<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<div class="card shadow mb-4">
<div class="card-body">
<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">
			 sms 잔액 조회
		</h1>
	</div>
</div>
<hr>
	<div align="right" >
		<button id="btnwriter" class="btn btn-warning">문자보내기</button>
	</div>
	
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable">
				<thead>
					<tr>
						<th width='50%'>현금</th>
						<th width='50%'>포인트</th>
					</tr>
				</thead>
			</table>
			<br>
			<div class="center" id="pager"></div>
		</div>

	</div>


<div id="hiddenDivLoading" style="visibility: hidden">
	<div id='load'>
		<img src='/resources/img/loading.gif' />
	</div>
</div>
</div>
</div>

<script>
   function List() {
//       var params = {            
//             pageNum : $("#pageNum").val(),
//             amount  : $("#amount").val(),
//             type : $("#type").val(),
//             keyword : $("#keyword").val(),
//             code : $("#code").val()
//          }
  //    alert("")
      
      $.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/admin/sms/getblance", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            
            $('#load').show();
	        // 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
	        $("#hiddenDivLoading").show().css({
	            top: $(document).scrollTop()+ ($(window).height() )/2.6 + 'px',
	            left: ($(window).width() )/2.6 + 'px'
	        });
         },
        // data : params, // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
        	// alert(res.split("Balance")[1])
        	var data = res.split("Balance")[1].replace("(","").replace(")","");
         var balance = data.split(",")[0].split("balance=")[1]
         var point = data.split(",")[1].split("point=")[1]
         // alert(balance)
          var str = "";
         if (Object.keys(res).length == 0) { //데이터가 없을 경우
            str += "<tr><td colspan=2 style='text-align: center;'>잔액이 부족합니다</td></tr>"
            $('#dataTable').append(str);
         }
         
          $('#dataTable').empty();
          $('#dataTable')
                .append(
                      "<thead><th width='50%'>현금</th><th width='50%'>포인트</th></thead>")
          str +="<tr><td>"+balance+"</td><td>"+point+"</td></tr>";
          $('#dataTable').append(str);         
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
			pageNum = 	$("#pageNum").val()
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
   
  
  
</script>


<script>
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   $(document).ready(function() {
	   
	   
      List();
      //글쓰기
      $("#btnwriter").on("click", function() {
         window.location.href = "/admin/sms/send";
      });
//       $("#btnSearch").on("click",function(){
//     	  List();    	  
//       });
//       // 페이징 SELECT BOX 선택시
//       $("#amount").on("change",function(){
//     	  $("#pageNum").val("1");
//     	  List();
//       });
//       $(document).on("click", ".page-item a", function(e){
//     	  e.preventDefault();
//     	  $("#pageNum").val($(this).attr("href"));   
//     	  //alert($("#pageNum").val())
//     	  List();
//     	  var delay =1000; // 스크롤 최상단으로 이동
//     	  $('html, body').animate({scrollTop: 0}, delay);
//       });
      
//       // 텍스트 박스에서 엔터 입력시 검색 
//       $("#keyword").on("keyup",function(key){
//           if(key.keyCode==13) {
//         	  List();
//           }
//       });

   
    
   });
</script>
<%@ include file="../../includes/adminfooter.jsp"%>