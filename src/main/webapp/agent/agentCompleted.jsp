<%-- 
    Document   : agentCompleted
    Created on : 01-Aug-2020, 11:20:59 am
    Author     : atulv
--%>


<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.delivery_table" %>

<jsp:useBean id="agentQ" class="com.mycompany.dlvery.datalayer.agentQueries"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/navbar.jsp" %>
        <%@include file="agent-nav.jsp" %>
        <div class="container">

            <% List<delivery_table> res = agentQ.getDeliveredForAgent(session.getAttribute("id").toString());

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
                            delivery_table item = res.get(i);%>
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
                <% }%>
            </table>


        </div>
        
                <%@include file="/utility/showSignature.jsp" %>

    </body>
   
</html>
