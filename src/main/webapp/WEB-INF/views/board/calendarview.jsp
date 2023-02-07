<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <script src="/resources/client/vendor/jquery/jquery.min.js"></script>
<script src="/resources/client/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
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
        $("#addModal").modal();
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
        $("#updateModal").modal();
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
        $("#updateModal").modal();
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
        $("#updateModal").modal();
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
            }
         }}
      }
   })    
   });
    calendar.render();
})
</script>
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
</head>

<body id='calendarbody'>
  <div id='calendar'></div>
</body>

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
   
   
   var Start = "";
   var End = "";
   var Title = "";
   var Num = "";
   var Content = "";
   
  
});
</script>

</html>