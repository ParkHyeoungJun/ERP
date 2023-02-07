<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<style>
.modal-body {
   max-height: calc(400px);
   overflow-y: scroll;
}

.imgsize{
	width:500px;
}

label {
   width: 150px;
}
</style>
 
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="card shadow mb-4">
<div class="card-body">
	<div class="row">
	<div class="col-lg-12">
		<h1 id="titlename" class="page-header">
			메인 배너 관리
		</h1>
	</div>
</div>
	<hr>
  <div align="right" >
      <button id="addbtn" class="btn btn-warning" style="width:100px;">추가</button>
   </div>
   
   <div class="card-body">
      <div class="table-responsive">
         <table class="table table-bordered " id="dataTable" width="100%">
            <thead>
               <tr>
                  <th width='5%'>#</th>
                  <th width='40%'>이미지</th>
                  <th width='15%'>링크</th>
                  <th width='15%'>작성자</th>
                  <th width='15%'>작성일</th>
                  <th width='10%'>삭제</th>
                  
               </tr>
            </thead>

         </table>
         
      </div>
   </div>
</div>

<div class="modal fade" id="modal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">배너 추가</h5>
            <button type="button" class="close" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form role="form" action="/admin/mainbanner/list" method="post" id='bannerform'>
         <div class="modal-body">
            <div class="panel-body">
            <input type="hidden" id="idx" name="idx" value="0">
               <div class="form-group">
                  <label>배너 순서</label> 
                 <input class="form-control" type="number"  min="1"
                     id="num" name='num'><small style="color:red;">1, 2, 3 ... 이런 식으로 값 입력 가능</small>
               </div>
               
               <div class="form-group">
                  <label>링크</label><input class="form-control" type="text" id="link" name='link'>
               </div>
               <div class="form-group">
                  <label>이미지</label>
                   <input type="file" id="imgattach" name="file" />
                  <div class="select_img" id="image"><img src='' /></div>
               
               <script>
  					$("#imgattach").change(function(){//추가한 이미지가 바로 보이게 하기
   						if(this.files && this.files[0]) {
    						var reader = new FileReader;
  							reader.onload = function(data) {
 							$(".select_img img").attr("src", data.target.result).width(500);
 							}
    						reader.readAsDataURL(this.files[0]);
  					 	}
  					});
 				</script>
               </div>
               
               <div class="form-group">
                  <label id="writerlabel">작성자</label> <input class="form-control" type="text"
                     id="writer" name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly">
               </div>
               
            </div>
         </div>
         
         </form>
         <div class="modal-footer">
            <button id="add" type="button" class="btn btn-warning">등록</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		
         </div>
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

$.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/admin/mainbanner/select", // 컨트롤러에서 대기중인 URL 주소이다.
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
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            // 응답코드 > 0000
            //alert(res);

            $('#dataTable').empty();
            $('#dataTable')
                  .append(
                  
                        "<thead><th width='5%'>#</th><th width='40%'>이미지</th><th width='15%'>링크</th><th width='15%'>작성자</th><th width='15%'>작성일</th><th width='10%'>삭제</th></thead>")
            var str = "";

            if (Object.keys(res).length == 0) { //데이터가 없을 경우
                str += "<tr><td colspan=6 style='text-align: center;'>등록된 배너가 없습니다</td></tr>"   
             }
            $
                  .each(
                        res,
                        function(i, v) { //i 인덱스 , v 값
                           str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
                           str += "<td>" + v.num + "</td>"
                           str += '<td>' + '<img class="imgsize" src="' + v.image + '"/>' +'</td>';
                           str += '<td>' + getLink(v.link) +'</td>';
                           str += '<td>' + v.writer + '</td>';
                           str += '<td>' + v.daytostring + '</td>';
                           str += '<td>' + getDelete(v.idx,v.image) + '</td>';
                           str += '</tr>'
                        })

            $('#dataTable').append(str);
            
            
         },
         error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });
}

function getDelete(idx,image){
	var str = '';
	
	str += '<b class="filedelete" data-name="'+image+'" data-idx="'+idx+'"id="delete" type="text" style="color:black;">[삭제]</b>';
	str += '<input id="idx" type="hidden" value="'+idx+'"/>';
	
	return str;
}

function getLink(link){
	if(link==null || link==''){
	      return '-';
	   }else{
	      return link;
	   }
}



</script>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ready(function() {
   List();
   
   //추가버튼 클릭시
   $("#addbtn").on("click", function() {
      $("#modal").modal();
      $("#num").val("");
      $("#link").val("");
      $(".select_img img").attr("src", '').width(0);//이전에 첨부했던 이미지 초기화
      $("#imgattach").val("");
   });
  
    //저장버튼 클릭시
    $("#add").on("click", function(e) {
      e.preventDefault();
      
      if ($("#num").val() == "") {
         alert("배너 순서를 지정하여 주세요");
         $("#num").focus();
         return false;
      }
      if (document.getElementById('image').innerHTML == '<img src="" style="width: 0px;">') {
         alert("이미지를 선택하여 주세요");
         $("#image").focus();
         return false;
      }
      if ($("#num").val() < "1" ) {
         alert("1 이상의 값을 입력하여 주세요");
         $("#num").focus();
         return false;
      }
      
      var form = $('#bannerform')[0];
      var formData = new FormData(form);
	
      //
      $.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         enctype: 'multipart/form-data',
         contentType : false,
         processData : false,
         url : "/admin/mainbanner/add", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
         },
         data : formData, // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            // 응답코드 > 0000
            // 
            alert("저장 되었습니다");
            $("#idx").val("0"); // 입력 모드
            $("#modal").modal("hide"); // 닫기

            List();

            //     
         },
         error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });
      //
   });
   ////저장
   // ajaxstop 은 ajax가 실행완료이든 에러이든 발생 
   $(document).ajaxStop(function() {
   });
   //ajaxComplete 은 실행 완료 시에만 실행 
   $(document).ajaxComplete(function() {

      $('#load').hide();
      $("#hiddenDivLoading").hide();
   });
   
  
   $(document).on("click",".filedelete",function(e) {
      e.preventDefault();
      var idx = $(this).data('idx');
      var filename = $(this).data('name');
      //alert(JSON.stringify(idx));
      
      if (confirm("정말로 삭제하시겠습니까?")) {
    	  
         var params = {
            idx : idx,
            filename : filename
         }
         //
         $.ajax({
            type : "POST", // HTTP method type(GET, POST) 형식이다.
            url : "/admin/mainbanner/delete", // 컨트롤러에서 대기중인 URL 주소이다.
            beforeSend : function(xhr) {
               xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data : params, // Json 형식의 데이터이다.
            success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               // 응답코드 > 0000
               // 
               alert("삭제되었습니다");
               $("#idx").val("0");
               
               List();

               //     
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("통신 실패.")
            }
         });
      }
   });

});
</script>
<%@ include file="../../includes/adminfooter.jsp"%>