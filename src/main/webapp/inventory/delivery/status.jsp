<%-- 
    Document   : status
    Created on : 31-Jul-2020, 3:18:11 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="/css/subnav.css"/>
    </head>
    <body>
        <%@include file="../../navbar.jsp" %>
        <div>
            <%@include file="../subnav.jsp" %>
            <%@include file="delivery-nav.jsp" %>
        </div>
        <div class="container">
            <h5>Delivery Status</h5>
            <% ResultSet result = sql.getAssignedInventoryStatus();
                if (result.next() == false) {


            %>

            <div class="text-center no-inventory-banner" id="no-inventory" >
                <h4 class="text-center text-muted">No Status available</h4>
            </div>


            <% } else {
                result.beforeFirst();

            %>
            <table class="table">
                <thead>
                    <tr>
                        <th>SKU</th>
                        <th>Status</th>
                        <th>Assigned To</th>
                        <th>Expected Delivery</th>
                        <th>Delivered</th>
                    </tr>
                </thead>
                <tbody>
                    while(result.next()) { 
                    %> 
                    <tr>
                        <td><%out.print(result.getString("sku"));%></td> 
                        <td><%out.print(result.getString("status"));%></td>
                        <td><%out.print(result.getString("agent_name"));%></td>
                        <td><%out.print(result.getString("move_out_date"));%></td>
                        <td><% if(result.getString("delivery_date").equals("0000-00-00")){out.print("--Not Delivered--");}else{out.print(result.getString("delivery_date"));};%></td>
                    </tr>
                    <% }%>
                </tbody>

            </table>

        </div>
    </body>
</html>
