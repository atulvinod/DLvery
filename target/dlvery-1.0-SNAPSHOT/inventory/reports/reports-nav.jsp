<%-- 
    Document   : reports-nav
    Created on : 07-Aug-2020, 4:31:59 pm
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
        <ul class="nav nav-tabs container" style="margin-top:2rem">
            <li class="nav-item">
                <a class="nav-link <% if (!(request.getRequestURI().contains("deliveredInTransitReport.jsp")) && !(request.getRequestURI().contains("deliveryPendingReport.jsp"))) {
                        out.print("active");
                    }%>" href="/inventory/reports/getDeliveredInRangeReport">Deliveries</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <% if (request.getRequestURI().contains("deliveredInTransitReport.jsp")) {
                        out.print("active");
                    }%>" href="/inventory/reports/deliveredInTransitReport.jsp">Damaged In Transit</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <% if (request.getRequestURI().contains("deliveryPendingReport.jsp")) {
                        out.print("active");
                    }%>" href="/inventory/reports/deliveryPendingReport.jsp">Pending Deliveries By Agent</a>
            </li>

        </ul>
    </body>
</html>
