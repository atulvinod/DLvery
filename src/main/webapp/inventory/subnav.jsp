<%-- 
    Document   : subnav
    Created on : 27-Jul-2020, 4:13:49 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/subnav.css"/>
    </head>
    <body>
        <div class="container subnav-top-margin subnav-border" >
            <div class="nav nav-pills nav-fill nav-justified">
            <a class="nav-item nav-link 
               <% if (this.getClass().getSimpleName().contains("reports")) {
                        out.print("active");
               }%>" href="reports.jsp">Reports</a>
            <a class="nav-item nav-link <% if (this.getClass().getSimpleName().contains("dashboard")) {
                        out.print("active");
            }%>" href="dashboard.jsp">Current Inventory</a>
            <a class="nav-item nav-link <% if (this.getClass().getSimpleName().contains("deliveries")) {
                        out.print("active");
            }%>" href="deliveries.jsp">Deliveries</a>

        </div>
            
          
        </div>
        
        
    </body>
</html>
