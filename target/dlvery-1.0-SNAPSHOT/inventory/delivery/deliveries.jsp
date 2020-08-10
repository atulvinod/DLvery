<%-- 
    Document   : deliveries
    Created on : 27-Jul-2020, 4:21:15 pm
    Author     : atulv
    Description : To assign deliveries to agents in the database, checks for unassigned
--%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="/errorPage.jsp"%>
<%@page import="com.mycompany.dlvery.model.agent_details"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>



<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.inventory_table" %>

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
        <div class="container">
            <br>
            <h5>Assign Deliveries to Agents</h5>
            <br>
        </div>

        <div  class="container">


            <%
                try {
                    List<inventory_table> getUndeliveredInventory = sql.getUnAssigned();
                    if (getUndeliveredInventory.size() == 0) {   %>


            <%      } else {
            %>
            <table class="table">
                <thead>
                    <tr>
                        <th>Inventory ID</th>
                        <th>SKU</th>
                        <th>Name</th>
                        <th>Delivery From</th>
                        <th>Delivery To Address</th>
                        <th>Move-In Date</th>
                        <th>Move-out Date/Deliver By</th>
                        <th>Perishable</th>
                        <th>Expiry</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < getUndeliveredInventory.size(); i++) {
                            inventory_table item = getUndeliveredInventory.get(i);%>
                    <tr id="inv<%out.print(item.getInventory_id());%>">
                        <td><%out.print(item.getInventory_id());%></td>
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getName());%></td>
                        <td><%= item.getDelivery_from()%></td>
                        <td><%= item.getDelivery_address() %></td>
                        <td><%out.print(item.getMove_in_date());%></td>
                        <td><%out.print(item.getMove_out_date());%></td>
                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                        <td><%out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>

                        <td><button class="btn btn-success" onclick="openAssignModal('<%out.print(item.getInventory_id());%>')">Assign</button> </td>
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
                            <% List<agent_details> authenticatedAgents = agentQ.getAllAgentDetails();
                                for (int i = 0; i < authenticatedAgents.size(); i++) {
                                    agent_details detail = authenticatedAgents.get(i);
                            %>
                            <div class="form-check" style="margin-bottom: 1.1rem">
                                <input class="form-check-input" type="radio" name="agentRadio"  value="<%out.print(detail.getAgent_id());%>">
                                <label class="form-check-label" for="agentRadio">
                                    <%out.print(detail.getAgent_name());%>
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
        <%} catch (SQLException e) {
                request.setAttribute("ExceptionObject", e);
                request.getServletContext().getRequestDispatcher("errorPage.jsp");
            }%>
        <script src="/javascript/deliveries.js"></script>
    </body>
</html>
