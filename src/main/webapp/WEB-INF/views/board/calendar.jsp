<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>
<style>

  #calendarbody {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>

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
    <link href='/resources/calendar/lib/main.css' rel='stylesheet' />
<!-- moment lib -->
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>

<!-- fullcalendar bundle -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.5.0/main.min.js'></script>

<!-- the moment-to-fullcalendar connector. must go AFTER the moment lib -->
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/moment@5.5.0/main.global.min.js'></script>
<script>
var params = {
   writer : userid
}
var writer=userid;
console.log(writer);
document.addEventListener('DOMContentLoaded', function() {
   var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
   headerToolbar: {
      left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
    },
   initialDate: new Date(),
   editable: true,
   selectable: true,
   businessHours: true,
   dayMaxEvents: true, // allow "more" link when too many events
   navLinks: true,
   locale: 'ko',
   dateClick: function(res) {
       Start=moment(res.date).format('YYYY-MM-DDTHH:mm');
        End="";
        Title="";
        Num="0";
        $(".col-11 #startday").val(Start);
        $(".col-11 #endday").val(End);
        $(".col-11 #title").val(Title);
        $(".modal-body #num").val(Num);
        $('#addModal').modal(
           { keyboard: false, backdrop: 'static' } 
        );
    },
    eventClick: function(res) {
        Start=moment(res.event.start).format('YYYY-MM-DDTHH:mm');
      Content=res.event.extendedProps.content;
        if (res.event.allDay==true) {
           if(res.event.end==null) {
              End=moment(res.event.start).format('YYYY-MM-DD')+"T23:59";                
           }
           else {
              End=moment(res.event.end).subtract(1, 'days').format('YYYY-MM-DD')+"T23:59";
         }           
      }
        else {
           End=moment(res.event.end).format('YYYY-MM-DDTHH:mm');
        }
        Title=res.event.title;
        Num=res.event.id;
        $(".col-11 #startdayU").val(Start);
        $(".col-11 #enddayU").val(End);
        $(".col-11 #titleU").val(Title);
        $(".col-11 #contentU").val(Content);
        $(".modal-body #numU").val(Num);
        $('#updateModal').modal(
              { keyboard: false, backdrop: 'static' } 
        );
   },
   eventDrop: function(res) {
      Start=moment(res.event.start).format('YYYY-MM-DDTHH:mm');
      Content=res.event.extendedProps.content;
        if (res.event.allDay==true) {
           if(res.event.end==null) {
              End=moment(res.event.start).format('YYYY-MM-DD')+"T23:59";                
           }
           else {
              End=moment(res.event.end).subtract(1, 'days').format('YYYY-MM-DD')+"T23:59";
         }           
      }
        else {
           End=moment(res.event.end).format('YYYY-MM-DDTHH:mm');
        }
        Title=res.event.title;
        Num=res.event.id;
        $(".col-11 #startdayU").val(Start);
        $(".col-11 #enddayU").val(End);
        $(".col-11 #titleU").val(Title);
        $(".col-11 #contentU").val(Content);
        $(".modal-body #numU").val(Num);
        $('#updateModal').modal(
              { keyboard: false, backdrop: 'static' } 
        );
   },
   eventResize: function(res) {
      Start=moment(res.event.start).format('YYYY-MM-DDTHH:mm');
      Content=res.event.extendedProps.content;
        if (res.event.allDay==true) {
           if(res.event.end==null) {
              End=moment(res.event.start).format('YYYY-MM-DD')+"T23:59";                
           }
           else {
              End=moment(res.event.end).subtract(1, 'days').format('YYYY-MM-DD')+"T23:59";
         }           
      }
        else {
           End=moment(res.event.end).format('YYYY-MM-DDTHH:mm');
        }
        Title=res.event.title;
        Num=res.event.id;
        $(".col-11 #startdayU").val(Start);
        $(".col-11 #enddayU").val(End);
        $(".col-11 #titleU").val(Title);
        $(".col-11 #contentU").val(Content);
        $(".modal-body #numU").val(Num);
        $('#updateModal').modal(
              { keyboard: false, backdrop: 'static' } 
        );
   },
   events:
   $.ajax({
       type: "POST",
        url: "/schedule/calendar",
        beforeSend : function(xhr) {
           xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        data: params,
        success: function (res) {
           result = res.result
            for (i=0; i<res.length; i++) {
               if(res[i].writer==userid) {
                  if((moment(res[i].startday).format('THH:mm')=="T00:00") && (moment(res[i].endday).format('THH:mm')=="T23:59")) {
                if(moment(res[i].startday).format('YYYY-MM-DD') != moment(res[i].endday).format('YYYY-MM-DD')) {
                   var time=moment(res[i].endday).format('THH:mm')
                   res[i].endday=moment(res[i].endday).add(1, 'days').format('YYYY-MM-DD')+time;
                    console.log(res[i].endday);
                }
                  }
                  else {
                       if(moment(res[i].startday).format('YYYY-MM-DD') != moment(res[i].endday).format('YYYY-MM-DD')) {
                           var time=moment(res[i].endday).format('THH:mm')
                           res[i].endday=moment(res[i].endday).format('YYYY-MM-DD')+time;
                            console.log(res[i].endday);
                        }
                  }
                if(res[i].personal=="1") {
                   if((moment(res[i].startday).format('THH:mm')=="T00:00") && (moment(res[i].endday).format('THH:mm')=="T23:59")) {
                      calendar.addEvent({
                           id: res[i]['num'],
                           title: res[i]['title'],
                           content: res[i]['content'],
                           start: res[i]['startday'],
                           end: res[i]['endday'],
                           backgroundColor: "navy",
                           allDay: true
                      })
                   }
                   else {
                       calendar.addEvent({                       
                             id: res[i]['num'],
                             title: res[i]['title'],
                             content: res[i]['content'],
                             start: res[i]['startday'],
                            end: res[i]['endday'],
                             backgroundColor: "navy"
                        })
                   }
            } else if(res[i].personal=="0") {
                   if((moment(res[i].startday).format('THH:mm')=="T00:00") && (moment(res[i].endday).format('THH:mm')=="T23:59")) {
                        calendar.addEvent({
                           id: res[i]['num'],
                            title: res[i]['title'],
                            content: res[i]['content'],
                            start: res[i]['startday'],
                            end: res[i]['endday'],
                            backgroundColor: "green",
                            allDay: true
                        })
                    }
                   else {
                       calendar.addEvent({
                             id: res[i]['num'],
                            title: res[i]['title'],
                            content: res[i]['content'],
                            start: res[i]['startday'],
                            end: res[i]['endday'],
                            backgroundColor: "green"
                          })
                   }
            } else {
                   if((moment(res[i].startday).format('THH:mm')=="T00:00") && (moment(res[i].endday).format('THH:mm')=="T23:59")) {
                        calendar.addEvent({
                           id: res[i]['num'],
                            title: res[i]['title'],
                            content: res[i]['content'],
                            start: res[i]['startday'],
                            end: res[i]['endday'],
                            allDay: true
                        })
               }
                   else {
                       calendar.addEvent({
                             id: res[i]['num'],
                            title: res[i]['title'],
                            content: res[i]['content'],
                            start: res[i]['startday'],
                            end: res[i]['endday']
                          })
                   }
            }}
         }
      }
   })    
   });
    calendar.render();
})
</script>

<input type="hidden" id="writer" name="writer" value=userid/>

<br>
<div>
  <div id='calendar'></div>
<br><br>
</div>


<!-- Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" 
aria-labelledby="addModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="addModalLabel">일정추가</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <input type="hidden" id="num" name="num" value="0" />
            <div class="form-group row">
               <label class="control-label col-1" for="title">일정명</label>
               <div class="col-11">
                  <input class="form-control" type="text" id="title" name="title"
                  maxlength="100">
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="period">기간</label>
               <div class="col-11">
                  <input class="form-control" style="display:inline-block; width:45%;" 
                  maxlength="10" id="startday" name='startday' type="datetime-local">
                  <span>&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
                  <input class="form-control" style="display:inline-block; width:45%;" 
                  maxlength="10" id="endday" name='endday' type="datetime-local">
               </div>
            </div>

            <div class="form-group row">
               <label class="control-label col-1" for="con">내용</label>
               <div class="col-11">
                  <textarea rows="10" cols="50" class="form-control" id="content"
                  name="content"></textarea>

               </div>
            </div>
                             
            <div class="form-group row">
               <label class="control-label col-1" for="personal">분류</label>
               <div class="col-11">
                        <select class="form-control" id="personal" name="personal"><option
                        value="">-----</option></select>
                     </div>
            </div>
         </div>
        <div class="modal-footer" align="right">
            <button id="btnSave" type="button" class="btn btn-success">저장</button>
            <button id="dismiss" type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
         </div>
      </div>
   </div>
</div>


<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" 
   aria-labelledby="updateModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="updateModalLabel">일정수정</h5>
            <button type="button" class="closeU" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <input type="hidden" id="numU" name="numU"/>
            <div class="form-group row">
               <label class="control-label col-1" for="title">일정명</label>
               <div class="col-11">
                  <input class="form-control" type="text" id="titleU" name="titleU"
                  maxlength="100">
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="period">기간</label>
               <div class="col-11">
                  <input class="form-control" style="display:inline-block; width:45%;" id="startdayU" name='startdayU' type="datetime-local">
                  <span>&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
                  <input class="form-control" style="display:inline-block; width:45%;" id="enddayU" name='enddayU' type="datetime-local">
               </div>
            </div>
            
            <div class="form-group row">
               <label class="control-label col-1" for="con">내용</label>
               <div class="col-11">
                  <textarea rows="10" cols="50" class="form-control" id="contentU"
                  name="contentU"></textarea>

               </div>
            </div>
                             
            <div class="form-group row">
               <label class="control-label col-1" for="personal">분류</label>
               <div class="col-11">
                        <select class="form-control" id="personalU" name="personalU">
                           <option value="0">개인</option>
                     <option value="1">부서</option>
                     <option value="2">직책</option></select>
                     </div>
            </div>
         
           <br />
            <div align="right">
               <button class="btn btn-warning" style="color:white;" id="btnModify">수정</button>
               <button class="btn btn-danger" id="btnDelete">삭제</button>
            </div>
         </div>
      </div>
   </div>
</div>


<script>
$(document).ready(function(e) {
   $.ajax({
        type : "POST", // HTTP method type(GET, POST) 형식이다.
        url : "/schedule/personal", // 컨트롤러에서 대기중인 URL 주소이다.
        beforeSend : function(xhr) {
           xhr.setRequestHeader(csrfHeaderName,
                 csrfTokenValue);
        },
        //data : "list", // Json 형식의 데이터이다.
        success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
           $.each(res, function(i, item) {
              $('#personal').append($('<option>', {
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
   $("#btnSave").on("click",function(e) {
      e.preventDefault();

      if ($("#title").val() === "") {
         alert("제목을 입력하여 주세요");
         $("#title").focus();
         return false;
      }
      if ($("#startday").val() === "") {
         alert("기간을 지정하여 주세요");
         $("#startday").focus();
         return false;
      }
      if ($("#endday").val() === "") {
         alert("기간을 지정하여 주세요");
         $("#endday").focus();
         return false;
      }
      if ($("#endday").val() < $("#startday").val()) {
         alert("기간을 다시 확인 해주세요");
         $("#endday").focus();
         return false;
      }
      if ($("#endday").val() == $("#startday").val()) {
          alert("기간을 다시 확인 해주세요");
          $("#endday").focus();
          return false;
       }
      if ($("#personal").val() === "") {
         alert("일정을 분류 해주세요");
         $("#personal").focus();
         return false;
      }

      var params = {
         num : $("#num").val(),
         title : $("#title").val(),
         content : $("#content").val(),
         startday: $("#startday").val(),
         endday: $("#endday").val(),
         personal: $("#personal").val(),
         writer: userid
      }
                              
      $.ajax({
         type : "POST",
         url : "/schedule/add",
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
         },
         data : params,
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            alert("저장 되었습니다");
            location.reload();
         },
         error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });

   });
   
   var Start = "";
   var End = "";
   var Title = "";
   var Num = "";
   var Content = "";
   
   $("#btnModify").on("click",function(e) {
      e.preventDefault();

      if ($("#titleU").val() === "") {
         alert("제목을 입력하여 주세요");
         $("#titleU").focus();
         return false;
      }
      if ($("#startdayU").val() === "") {
         alert("기간을 지정하여 주세요");
         $("#startdayU").focus();
         return false;
      }
      if ($("#enddayU").val() === "") {
         alert("기간을 지정하여 주세요");
         $("#enddayU").focus();
         return false;
      }
      if ($("#enddayU").val() < $("#startdayU").val()) {
         alert("기간을 다시 확인 해주세요");
         $("#enddayU").focus();
         return false;
      }
      if ($("#enddayU").val() == $("#startdayU").val()) {
          alert("기간을 다시 확인 해주세요");
          $("#endday").focus();
          return false;
       }

      var params = {
         num : $("#numU").val(),
         title : $("#titleU").val(),
         content : $("#contentU").val(),
         startday: $("#startdayU").val(),
         endday: $("#enddayU").val(),
         personal: $("#personalU").val(),
         writer: userid
      }
                              
      $.ajax({
         type : "POST",
         url : "/schedule/add",
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
         },
         data : params,
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            alert("수정 되었습니다");
            location.reload();
         },
         error : function(XMLHttpRequest,textStatus,errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });
   })
   
   $(".close, .closeU, #dismiss").on("click",function(e) {
      location.reload();
   })
   
   $("#btnDelete").on("click",function(e){
        e.preventDefault();
        if (confirm("정말로 삭제하시겠습니까?")) {
           var params = {
              num : $("#numU").val()
           }
           $.ajax({
              type : "POST", // HTTP method type(GET, POST) 형식이다.
              url : "/schedule/delete", // 컨트롤러에서 대기중인 URL 주소이다.
              beforeSend : function(xhr) {
                 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
              },
              data : params, // Json 형식의 데이터이다.
              success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                 alert("삭제되었습니다");
                 location.reload();
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