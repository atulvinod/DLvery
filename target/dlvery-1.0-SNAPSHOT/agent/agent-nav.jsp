<%-- 
    Document   : agent-nav
    Created on : 01-Aug-2020, 11:08:35 am
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="/css/subnav.css"/>
    </head>
    <body>
         <div class="container subnav-top-margin subnav-border" >
        <ul class="nav nav-pills nav-fill">
            <li class="nav-item">
                <a class="nav-link <%if(request.getRequestURI().contains("agentDashboard")){out.print("active");}%>" href="#">Pending Deliveries</a>
            </li> 
             <li class="nav-item">
                <a class="nav-link <%if(request.getRequestURI().contains("agentCompletedDashboard")){out.print("active");}%>" href="#">Completed Deliveries</a>
            </li> 
        </ul>
         </div>
    </body>
</html>
