<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta name="Name" content="http://localhost/">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
   content="${_csrf.headerName}" />
<title>SB Admin 2 - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="/resources/admin/vendor/fontawesome-free/css/all.min.css"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
<script src="/resources/admin/vendor/jquery/jquery.js"></script>
<script src="/resources/admin/vendor/bootstrap/js/bootstrap.js"></script>
<script
   src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>

</head>

<body id="page-top">

   <!-- Page Wrapper -->
   <div id="wrapper">

      <!-- Sidebar -->
      <ul
         class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
         id="accordionSidebar">

         <!-- Sidebar - Brand -->
         <li class="nav-item active"><a href='/'><img src="/resources/img/ERP.png" style="image-rendering: -webkit-optimize-contrast; backface-visibility: hidden; transform: translateZ(0);" class="img-fluid"></a>
            <hr class="sidebar-divider my-0">
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/member/detils">
            <sec:authorize access="isAuthenticated()">
             <sec:authentication property="principal.username"/>
          </sec:authorize></a>
          </li>
         <!-- Divider -->
         <hr class="sidebar-divider my-0">

         <!-- Nav Item - Dashboard -->
         
         <li class="nav-item active"><a class="nav-link"
            href="/admin/member/list">  <span><i
               class="fas fa-fw fa-cog"></i>회원관리</span></a>
         <li class="nav-item active"><a class="nav-link"
            href="/admin/board/declarlist">  <span><i
               class="fas fa-fw fa-cog"></i>신고리스트</span></a>
      <li class="nav-item active"><a class="nav-link"
            href="/admin/mainbanner/list">  <span><i
               class="fas fa-fw fa-cog"></i>메인 배너 관리</span></a>
         <!-- Divider -->
         <hr class="sidebar-divider">

         <!-- Heading -->
         <div class="sidebar-heading">Interface</div>

         <!-- Nav Item - Pages Collapse Menu -->
         <li class="nav-item"><a class="nav-link collapsed" href="#"
            data-toggle="collapse" data-target="#collapseTwo"
            aria-expanded="true" aria-controls="collapseTwo"> <i
               class="fas fa-fw fa-tachometer-alt"></i> <span>게시판</span>
         </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
               data-parent="#accordionSidebar">
               <div id="divboard" class="bg-white py-2 collapse-inner rounded">
                  <!--                         <h6 class="collapse-header">Custom Components:</h6> -->
                  <!--                         <a class="collapse-item" href="/board/adminselect">Buttons</a> -->
                  <!--                         <a class="collapse-item" href="cards.html">Cards</a> -->
               </div>
            </div></li>

         <!-- Nav Item - Utilities Collapse Menu -->
          <li class="nav-item"><a class="nav-link" href="/admin/projectadmin/select">
               <i class="fas fa-fw fa-wrench"></i> <span>프로젝트 관리</span>
         </a></li>
          <li class="nav-item"><a class="nav-link" href="/admin/sms/list">
               <i class="fas fa-fw fa-wrench"></i> <span>SMS 관리</span>
         </a></li>


         <!-- Divider -->
         <hr class="sidebar-divider">

         <!-- Heading -->
         <div class="sidebar-heading">Addons</div>

         <!-- Nav Item - Pages Collapse Menu -->
         <li class="nav-item"><a class="nav-link collapsed" href="#"
            data-toggle="collapse" data-target="#collapsePages"
            aria-expanded="true" aria-controls="collapsePages"> <i
               class="fas fa-fw fa-folder"></i> <span>프로젝트 결재 관리</span>
         </a>
            <div id="collapsePages" class="collapse"
               aria-labelledby="headingPages" data-parent="#accordionSidebar">
               <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">결재 관리:</h6>
                  <a class="collapse-item" href="/admin/reportresult/list">결재 승인</a> 
               </div>
            </div></li>
         
         <!-- Nav Item - Charts -->
        <!-- Nav Item - Charts -->
         <li class="nav-item"><a class="nav-link" href="/admin/bonus/charts">
               <i class="fas fa-fw fa-chart-area"></i> <span>실적 차트</span>
         </a></li>

         <!-- Nav Item - Tables -->
        <!-- Nav Item - Tables -->
         <li class="nav-item"><a class="nav-link" href="/admin/bonus/select">
               <i class="fas fa-fw fa-table"></i> <span>실적 관리</span>
         </a></li>
         
         <!-- Sidebar - Brand -->
         <hr class="sidebar-divider my-0">
         <li class="nav-item active">
         <sec:authorize access="isAuthenticated()">
            <form role="form" method="post" action="/logout">
               <fieldset>
                  <span class="sidebar-brand d-flex align-items-center justify-content-center">
                     <img src="/resources/img/logout.png" class="img-fluid" width="15px" height="15px">
                     <a class="nav-link" id="logout" href="#" style="font-size: small;">Logout</a>
                  </span>
               </fieldset>
               <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
            </form>            
                     
         </sec:authorize>
         <sec:authorize access="isAnonymous()">
            <span class="sidebar-brand d-flex align-items-center justify-content-center"><img src="/resources/img/login.png" width="20px" height="25px">
               <a class="nav-link" href="/login">Login</a></span>
         </sec:authorize>
         </li>

         <!-- Divider -->
         <hr class="sidebar-divider d-none d-md-block">

         <!-- Sidebar Toggler (Sidebar) -->
         <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
         </div>

         

      </ul>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">

         <!-- Main Content -->
         <div id="content">

            <script>
            var csrfHeaderName = "${_csrf.headerName}";
           var csrfTokenValue = "${_csrf.token}";
            <sec:authorize access="isAnonymous()">
             window.location.href = "/login";
          </sec:authorize>
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
                              str += "<a href='/admin/boardadmin/list'><h6 class='collapse-header'>게시판관리:</h6></a>";
                              $
                                    .each(
                                          res,
                                          function(i, v) { //i 인덱스 , v 값
                                             str += "<a class='collapse-item' href='/admin/board/select?code="
                                                   + v.code
                                                   + "'>"
                                                   + v.title
                                                   + "</a>";
                                          })

                              $('#divboard').append(str);

                           },
                           error : function(XMLHttpRequest,
                                 textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
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