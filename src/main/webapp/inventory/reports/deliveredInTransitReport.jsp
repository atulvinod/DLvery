<%-- 
    Document   : deliveredInTransitReport
    Created on : 07-Aug-2020, 4:30:11 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="/errorPage.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>



<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.assigned_delivery" %>
<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%@include file="../../navbar.jsp" %>
        <div>
            <%@include file="../subnav.jsp" %>
            <%@include file="reports-nav.jsp" %>
        </div>
        <div class="container">
            <br>
            <h5>Deliveries Damaged In Transit Report</h5>
            <hr>
            <%
                try {
                    List<assigned_delivery> list = sql.getAssignedAndTransitDamagedInventoryStatus();
                    if (list.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" id="no-inventory" >
                <h4 class="text-center text-muted">No data available</h4>
            </div>


            <%} else {%>
            <table class="table">
                <thead>
                    <tr>
                        <th>Inventory Id</th>
                        <th>SKU</th>
                        <th>Item Name</th>
                        <th>Agent Id</th>
                        <th>Assigned To Agent</th>
                        <th>Expected Delivery</th>
                        <th>Delivery Attempted On</th>
                    </tr>
                </thead>

                <% for (int i = 0; i < list.size(); i++) {
                        assigned_delivery item = list.get(i);%>
                <tbody>
                    <tr>
                        <td><%out.print(item.getInventory_id());%></td>
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getName());%></td>
                        <td><%out.print(item.getAgent_id());%></td>
                        <td><%out.print(item.getAgent_name());%></td>
                        <td><%out.print(item.getMove_out_date());%></td>
                        <td><%out.print(item.getDelivery_date());%></td>
                    </tr>

                </tbody>

                <% }%>
            </table>




            <%}

                } catch (Exception e) {
                    request.setAttribute("ExceptionObject", e);
                    request.getServletContext().getRequestDispatcher("errorPage.jsp");
                }
            %>
        </div>

    </body>
</html>
