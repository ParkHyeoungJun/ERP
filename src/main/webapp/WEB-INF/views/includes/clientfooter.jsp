<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
String timeStamp = date.format(new Date());
%>
</div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website <%=timeStamp %></p>
    </div>
    <!-- /.container -->
  </footer>

</body>

</html>
