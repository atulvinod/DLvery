<%-- 
    Document   : status
    Created on : 31-Jul-2020, 3:18:11 pm
    Author     : atulv
--%>

<%@page import="com.mycompany.dlvery.model.assigned_delivery"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.model.agent_details"%>
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
            <% try {

                    List<assigned_delivery> res = sql.getAssignedInventoryStatus();

                    if (res.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" >
                <h4 class="text-center text-muted">There are no undelivered inventory items</h4>
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
                        <td><%out.print(item.getPerishable());%></td>
                        <td><%out.print(item.getExpiry());%></td>
                    </tr>


                    <% }%>

                    </tbody>



            </table>

            <% }
            } catch (Exception e) {
                e.printStackTrace(); %>


            <% }%>
        </div>
        <div class="modal" tabindex="-1" id="signatureModal" data-background="static" role="dialog">
            <div class="modal-dialog">
                <div class="modal-header">
                    <h5 class="modal-title">Signature Details</h5>
                </div>
                <div class="modal-content">
                    <div class="form-group">
                        <label for="recipient">Recieved By</label>
                        <input type="text" class="form-control disabled">
                    </div>

                    <div id="signatureContainer"></div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Close</button>
                </div>
            </div>

        </div>

    </body>
    <script>

    </script>
</html>
