<%-- 
    Document   : history
    Created on : 31-Jul-2020, 3:18:21 pm
    Author     : atulv
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.dlvery.model.delivery_details"%>
<jsp:useBean id="inv" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="/errorPage.jsp"%>
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
            <h5>Delivery History</h5>
            <br>
        </div>

        <div class="container">

            <%
                try {
                    List<delivery_details> res = inv.getAllDeliveredDetails();

                    if (res.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" id="no-inventory" >
                <h4 class="text-center text-muted">No new deliveries</h4>
            </div>

            <% } else { %>
            <table class="table">
                <thead>
                    <tr>
                        <th>SKU</th>
                        <th>Reciever Name</th>
                        <th>Delivery Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < res.size(); i++) {
                            delivery_details item = res.get(i);%>
                    <tr id="inv<%out.print(item.getDelivery_id());%>">
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getReciever_name());%></td>
                        <td><%out.print(item.getDelivery_date());%></td>

                        <td>
                            <button class="btn btn-primary" onclick="showAckModal('<%out.print(item.getDelivery_id());%>', '<%out.print(item.getReciever_name());%>')">Show Acknowledgement</button>
                        </td>

                    </tr>


                    <% }%>

                </tbody>
                <% }

                    } catch (SQLException e) {
                        request.setAttribute("ExceptionObject", e);
                        request.getServletContext().getRequestDispatcher("errorPage.jsp");
                    }%>
            </table>


        </div>
        <%@include file="/utility/showSignature.jsp" %>

    </body>

</html>
