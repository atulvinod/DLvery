<%-- 
    Document   : deliveries
    Created on : 27-Jul-2020, 4:21:15 pm
    Author     : atulv
    Description : To assign deliveries to agents in the database
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>

<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>
<jsp:useBean id="agentQ" class="com.mycompany.dlvery.datalayer.agentQueries"/>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../navbar.jsp" %>
        <div>
            <%@include file="../subnav.jsp" %>
            <%@include file="delivery-nav.jsp" %>
        </div>
        <div style="margin-top: 1rem" class="container">
            <% ResultSet getUndeliveredInventory = sql.getUndeliveredInventoryAccToPriority();
                if (getUndeliveredInventory.next() == false) {   %>
            <div class="text-center no-inventory-banner" >
                <h4 class="text-center text-muted">There are no undelivered inventory items</h4>
            </div>

            <%      } else {
                getUndeliveredInventory.beforeFirst(); %>
            <table class="table">
                <thead>
                    <tr>
                        <th>Inventory ID</th>
                        <th>SKU</th>
                        <th>Name</th>
                        <th>Move-In Date</th>
                        <th>Move-out Date</th>
                        <th>Perishable</th>
                        <th>Expiry</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%while (getUndeliveredInventory.next()) { %>
                    <tr id="inv<%out.print(getUndeliveredInventory.getString("inventory_id"));%>">
                        <td><%out.print(getUndeliveredInventory.getString("inventory_id"));%></td>
                        <td><%out.print(getUndeliveredInventory.getString("sku"));%></td>
                        <td><%out.print(getUndeliveredInventory.getString("name"));%></td>
                        <td><%out.print(getUndeliveredInventory.getString("move_in_date"));%></td>
                        <td><%out.print(getUndeliveredInventory.getString("move_out_date"));%></td>
                        <td><% out.print(getUndeliveredInventory.getString("perishable").equals("0") ? false : true);%></td>
                        <td><% out.print(getUndeliveredInventory.getString("damaged").equals("0") ? false : true);%></td>

                        <td><button class="btn btn-success" onclick="openAssignModal('<%out.print(getUndeliveredInventory.getString("inventory_id"));%>')">Assign</button> </td>
                    </tr>  

                    <% }%>

                </tbody>


            </table>


            <% }%>
        </div>

        <div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Assign delivery</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form  id="assignDeliveryForm">
                            <% ResultSet authenticatedAgents = agentQ.getAllAgentDetails();
                                while (authenticatedAgents.next()) {
                            %>
                            <div class="form-check" style="margin-bottom: 1.1rem">
                                <input class="form-check-input" type="radio" name="agentRadio"  value="<%out.print(authenticatedAgents.getString("agent_id"));%>">
                                <label class="form-check-label" for="agentRadio">
                                    <%out.print(authenticatedAgents.getString("agent_name"));%>
                                </label>
                            </div>
                            <% };%>
                            <div class="modal-footer">
                            <input type="submit" value="save" class="btn btn-success">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                            <script src="/javascript/deliveries.js"></script>
    </body>
</html>
