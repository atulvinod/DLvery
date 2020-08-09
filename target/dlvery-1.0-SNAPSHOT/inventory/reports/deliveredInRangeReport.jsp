<%-- 
    Document   : deliveredInRangeReport
    Created on : 07-Aug-2020, 4:28:50 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.dlvery.model.agent_details"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>



<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.assigned_delivery" %>

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
            <%@include file="reports-nav.jsp" %>
        </div>
        <div class="container">

            <form action="/inventory/reports/getDeliveredInRangeReport" method="POST">

                <div class="row mt-3">
                    <div class="col-md-5">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="inputGroupSelect01">From</label>

                            </div>
                            <input type="date" name="fromDate" id="fromDate" class="form-control" required="true" <%if (request.getAttribute("fromDate") != null) {
                                    out.print("value=" + request.getAttribute("fromDate"));
                                }%>>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="inputGroupSelect01">To</label>
                            </div>
                            <input type="date" name="toDate" id="fromDate" class="form-control" required="true" <%if (request.getAttribute("toDate") != null) {
                                    out.print("value=" + request.getAttribute("toDate"));
                                }%>>
                        </div>
                    </div>
                    <div class="col-md-2">

                        <input type="submit" value="Look Up" class="btn btn-success">
                    </div>

                </div>



            </form>

        </div>
        <hr>
        <div class="container">
            <br>
            <%
                List<assigned_delivery> list = null;

                if (request.getAttribute("fromDate") == null && request.getAttribute("toDate") == null) {
                    list = sql.getAssignedAndDeliveredInventoryStatus();
            %>
            <h5>Showing all Deliveries</h5>
            <%                    } else {
                list = sql.getAssignedAndDeliveredInventoryStatusBetweenDates((String) request.getAttribute("fromDate"), (String) request.getAttribute("toDate"));
            %>
            <h5>Showing Deliveries between <%out.print(request.getAttribute("fromDate"));%> and <%out.print(request.getAttribute("toDate"));%></h5>
            <%
                }
                if (list.size() > 0) {
            %>
            <br>
            <table class="table">
                <thead>
                    <tr>
                        <th>Inventory Id</th>
                        <th>SKU</th>
                        <th>Delivered On</th>
                        <th>Delivered By</th>
                        <th>Recieved By</th>
                        <th>Delivery Address</th>
                        <th>Expected Delivery Was</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < list.size(); i++) {
                            assigned_delivery item = list.get(i);%>
                    <tr>
                        <td><%out.print(item.getInventory_id());%></td>
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getDelivery_date());%></td>
                        <td><%out.print(item.getAgent_name());%></td>
                        <td><%out.print(item.getReciever_name());%></td>
                        <td><%out.print(item.getDelivery_address());%></td>
                        <td><%out.print(item.getMove_out_date());%></td>
                        <td>
                            <button class="btn btn-primary" onclick="showAckModal('<%out.print(item.getDelivery_id());%>', '<%out.print(item.getReciever_name());%>')">Show Acknowledgement</button>

                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%} else {%>
            <div class="text-center">
                <br>
                <h6>No Deliveries</h6>
            </div>

            <%}%>

        </div>
            <%@include file="/utility/showSignature.jsp" %>
</html>
