<%-- 
    Document   : delivery-nav
    Created on : 31-Jul-2020, 3:13:48 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/css/management-dashboard.css"/>
        <link rel="stylesheet" href="/css/subnav.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <ul class="nav nav-tabs container" style="margin-top:2rem">
  <li class="nav-item">
      <a class="nav-link <% if(request.getRequestURI().contains("deliveries.jsp")){out.print("active");}%>" href="/inventory/delivery/deliveries.jsp">Assign Deliveries</a>
  </li>
  <li class="nav-item">
      <a class="nav-link <% if(request.getRequestURI().contains("status.jsp")){out.print("active");}%>" href="/inventory/delivery/status.jsp">Delivery Status</a>
  </li>
  <li class="nav-item">
      <a class="nav-link <% if(request.getRequestURI().contains("history.jsp")){out.print("active");}%>" href="/inventory/delivery/history.jsp">Delivery History</a>
  </li>
 
</ul>
          <script src="../../javascript/deliveries.js"></script>

    </body>
</html>
