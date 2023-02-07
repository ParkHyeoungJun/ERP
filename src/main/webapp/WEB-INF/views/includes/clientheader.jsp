<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Modern Business - Start Bootstrap Template</title>

<!-- Bootstrap core JavaScript -->
<script src="/resources/client/vendor/jquery/jquery.min.js"></script>
<script
   src="/resources/client/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="/resources/client/vendor/bootstrap/css/bootstrap.min.css"
   rel="stylesheet">

<!-- Custom styles for this template -->

<link href="/resources/client/css/modern-business.css" rel="stylesheet">


</head>

<body>

   <!-- Navigation -->
   <nav
      class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
      <a href='/'><img src="/resources/img/ERP2.png"
         style="image-rendering: -webkit-optimize-contrast; backface-visibility: hidden; transform: translateZ(0);"
         class="img-fluid"></a>
      <div class="container">
         <button class="navbar-toggler navbar-toggler-right" type="button"
            data-toggle="collapse" data-target="#navbarResponsive"
            aria-controls="navbarResponsive" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
            <sec:authentication property="principal" var="pinfo"/>
            <sec:authorize access="isAuthenticated()">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="nav-item"><a class="nav-link" href="/admin/boardadmin/list">관리자 화면</a></li>
            </sec:authorize>
            </sec:authorize>
            
               <li class="nav-item"><sec:authorize access="isAuthenticated()">
                     <form role="form" method="post" action="/logout">
                        <fieldset>
                           <a class="nav-link" id="logout" href="#">로그아웃</a>
                        </fieldset>
                        <input type="hidden" name="${_csrf.parameterName }"
                           value="${_csrf.token}" />
                     </form>
                  </sec:authorize> <sec:authorize access="isAnonymous()">
                     <a class="nav-link" href="/login">로그인<!-- 익명 상태라면 로그인 표시 --></a>
                  </sec:authorize></li>
               <li class="nav-item dropdown"><sec:authorize access="isAuthenticated()"><a
                  class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog"
                  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     마이페이지 </a>
                     <div class="dropdown-menu dropdown-menu-right"
                        aria-labelledby="navbarDropdownMember">
                        <a class="dropdown-item" href="/member/detils">나의 정보 수정</a> <a
                           class="dropdown-item" href="/board/myselect">내 게시글</a> <a
                           class="dropdown-item" href="/declar/mydeclar">내 신고 내역</a> <a
                           class="dropdown-item" href="/schedule/select">스케쥴 관리</a> <a
                           class="dropdown-item" href="/schedule/projectschedule">내 프로젝트 일정</a>
                           <a class="dropdown-item" href="/report/myproject">내 프로젝트관리</a>
                           <a class="dropdown-item" href="/board/calendar">캘린더</a>
                           
                     </div>
                  </sec:authorize> <sec:authorize access="isAnonymous()">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog"
                  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     회원관리</a>
                     <div class="dropdown-menu dropdown-menu-right"
                        aria-labelledby="navbarDropdownMember">
                        <a class="dropdown-item" href="/membership">회원가입</a> <a
                           class="dropdown-item" href="/finduserid">아이디찾기</a> <a
                           class="dropdown-item" href="/findpwd">비밀번호찾기</a>
                     </div>
                  </sec:authorize></li>
              
               <li class="nav-item active dropdown"><a
                  class="nav-link dropdown-toggle" href="#" id="navbarDropdownPages"
                  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     게시판 </a>
                  <div id="divboard" class="dropdown-menu dropdown-menu-right"
                     aria-labelledby="navbarDropdownPages">
                     <!-- <a class="dropdown-item" href="full-width.html">Full Width Page</a>
              <a class="dropdown-item" href="sidebar.html">Sidebar Page</a>
              <a class="dropdown-item active" href="faq.html">FAQ</a>
              <a class="dropdown-item" href="404.html">404</a>
              <a class="dropdown-item" href="pricing.html">Pricing Table</a> -->
                  </div></li>
            </ul>
         </div>
      </div>
   </nav>

   <!-- Page Content -->
   <div class="container">
      <br> <br>

      <script>
         var csrfHeaderName = "<c:out value='${_csrf.headerName}'></c:out>";
         var csrfTokenValue = "<c:out value='${_csrf.token}'></c:out>";

         function BoardList() {
            $
                  .ajax({
                     type : "POST", // HTTP method type(GET, POST) 형식이다.
                     url : "/admin/boardadmin/listajax", // 컨트롤러에서 대기중인 URL 주소이다.
                     beforeSend : function(xhr) {
                        xhr.setRequestHeader(csrfHeaderName,
                              csrfTokenValue);

                     },
                     //data : params, // Json 형식의 데이터이다.
                     success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        var str = "";

                        $
                              .each(
                                    res,
                                    function(i, v) { //i 인덱스 , v 값
                                       str += "<a class='dropdown-item' href='/board/select?code="
                                             + v.code
                                             + "'>"
                                             + v.title + "</a>";
                                    })

                        $('#divboard').append(str);

                     },
                     error : function(XMLHttpRequest, textStatus,
                           errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert("통신 실패.")
                     }
                  });
         }
         $(document).ready(function() {
            BoardList();
            $("#logout").on("click", function(e) {
               e.preventDefault();
               $("form").submit();
            });
         });
      </script>