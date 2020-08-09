<%-- 
    Document   : deliveryPendingReport
    Created on : 07-Aug-2020, 4:30:41 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.mycompany.dlvery.model.agent_details"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>



<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.assigned_delivery" %>

<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>
<jsp:useBean id="agentQ" class="com.mycompany.dlvery.datalayer.agentQueries"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%@include file="../../navbar.jsp" %>
        <div>
            <%@include file="../subnav.jsp" %>
            <%@include file="reports-nav.jsp" %>
        </div>
             <div class="container">
                 <br>
                 <h5>Pending Deliveries</h5>
                 <hr>
            <% try {

                    List<assigned_delivery> res = sql.getAssignedInventoryStatus();

                    if (res.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" >
                <h4 class="text-center text-muted">There are no pending inventory items</h4>
            </div>

            <%} else {
                %>
            <table class="table">
                <thead>
                    <tr>
                        <th>SKU</th>
                        <th>Item name</th>
                        <th>Assigned To</th>
                        <th>Status</th>
                        <th>Perishable</th>
                        <th>Expiry</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0 ; i < res.size() ; i ++) { assigned_delivery item = res.get(i);%>

                    <tr>
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getName());%></td>
                        <td><%out.print(item.getAgent_name());%></td>
                        <td><%out.print(item.getStatus());%></td>
                        <td><%out.print(item.getPerishable().equals("0")? false : true);%></td>
                        <td><%out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                    </tr>


                    <% }%>

                    </tbody>



            </table>

            <% }
            } catch (Exception e) {
                e.printStackTrace(); %>


            <% }%>
        </div>
    </body>
</html>
