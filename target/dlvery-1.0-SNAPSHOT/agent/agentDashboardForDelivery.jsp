<%-- 
    Document   : agentDashboardForDelivery
    Created on : 07-Aug-2020, 11:14:25 am
    Author     : atulv
--%>



<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.dlvery.model.pending_for_agent"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" errorPage="/errorPage.jsp"%>
<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.delivery_table" %>
<jsp:useBean id="agentQ" class="com.mycompany.dlvery.datalayer.agentQueries"/>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/navbar.jsp" %>
        <%@include file="agent-nav.jsp" %>
        <%
            String filterBy = (String) request.getAttribute("filterBy") != null ? (String) request.getAttribute("filterBy") : "TODAY";
            //out.println(filterBy);
        %>


        <div class="container-fluid">
            <br>


            <%
                //Generate the items 
                try {
                    List<pending_for_agent> today = agentQ.getExpectedDeliveryTodayForAgent(session.getAttribute("id").toString());
                    List<pending_for_agent> missed = agentQ.getPendingDeliveriesForAgent(session.getAttribute("id").toString());
                    List<pending_for_agent> upcoming = agentQ.getUpcomingDeliveryForAgent(session.getAttribute("id").toString());

            %>




            <div class="accordion" id="accordionExample">

                <div class="card">
                    <div class="card-header" id="headingOne">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Deliveries Expected Today
                            </button>
                        </h2>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                        <div class="card-body">
                            <%                                if (today.size() == 0) {
                            %>
                            <div class="text-center" id="no-inventory" >
                                <h4 class="text-center text-muted">No new deliveries</h4>
                            </div>

                            <% } else {
                            %>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>SKU</th>
                                        <th>Item Name</th>
                                        <th>Deliver To Name</th>
                                        <th>Delivery Address</th>
                                        <th>Contact Number</th>
                                        <th>Perishable</th>
                                        <th>Expiry Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < today.size(); i++) {
                                            pending_for_agent item = today.get(i); %>
                                    <tr id="inv<%out.print(item.getDelivery_id());%>">
                                        <td><%out.print(item.getSku());%></td>
                                        <td><%out.print(item.getDelivery_name());%></td>
                                        <td><%out.print(item.getDelivery_to_name());%></td>
                                        <td><%out.print(item.getDelivery_address());%></td>
                                        <td><%= item.getDelivery_to_contact()%></td>
                                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                                        <td>
                                            <button class="btn btn-primary" onclick="takeOutForDelivery(<%out.print(item.getDelivery_id());%>)">Take out for Delivery</button>
                                        </td>

                                    </tr>


                                    <% }
                                        }%>

                                </tbody>

                            </table>

                        </div>
                    </div>
                </div>

            
                <div class="card">
                    <div class="card-header" id="headingTwo">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                Deliveries Missed / Pending
                            </button>
                        </h2>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                        <div class="card-body">


                            <%                                
                                if (missed.size() == 0) {
                            %>


                            <div class="text-center" id="no-inventory" >
                                <h4 class="text-center text-muted">No new deliveries</h4>
                            </div>

                            <% } else {
                            %>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>SKU</th>
                                        <th>Item Name</th>
                                        <th>Deliver To Name</th>
                                        <th>Delivery Address</th>
                                        <th>Contact Number</th>
                                        <th>Perishable</th>
                                        <th>Expiry Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < missed.size(); i++) {
                                            pending_for_agent item = missed.get(i); %>
                                    <tr id="inv<%out.print(item.getDelivery_id());%>">
                                        <td><%out.print(item.getSku());%></td>
                                        <td><%out.print(item.getDelivery_name());%></td>
                                        <td><%out.print(item.getDelivery_to_name());%></td>
                                        <td><%out.print(item.getDelivery_address());%></td>
                                        <td><%= item.getDelivery_to_contact()%></td>
                                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                                        <td>
                                            <button class="btn btn-primary" onclick="takeOutForDelivery(<%out.print(item.getDelivery_id());%>)">Take out for Delivery</button>
                                        </td>

                                    </tr>


                                    <% }
                                        }%>

                                </tbody>

                            </table>

                        </div>
                    </div>
                </div>

            

                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                Upcoming deliveries
                            </button>
                        </h2>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                        <div class="card-body">


                            <%                                
                                if (upcoming.size() == 0) {
                            %>


                            <div class="text-center" id="no-inventory" >
                                <h4 class="text-center text-muted">No new deliveries</h4>
                            </div>

                            <% } else {
                            %>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>SKU</th>
                                        <th>Item Name</th>
                                        <th>Deliver To Name</th>
                                        <th>Delivery Address</th>
                                        <th>Contact Number</th>
                                        <th>Perishable</th>
                                        <th>Expiry Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < upcoming.size(); i++) {
                                            pending_for_agent item = upcoming.get(i); %>
                                    <tr id="inv<%out.print(item.getDelivery_id());%>">
                                        <td><%out.print(item.getSku());%></td>
                                        <td><%out.print(item.getDelivery_name());%></td>
                                        <td><%out.print(item.getDelivery_to_name());%></td>
                                        <td><%out.print(item.getDelivery_address());%></td>
                                        <td><%= item.getDelivery_to_contact()%></td>
                                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                                        <td>
                                            <button class="btn btn-primary" onclick="takeOutForDelivery(<%out.print(item.getDelivery_id());%>)">Take out for Delivery</button>
                                        </td>

                                    </tr>


                                    <% }
                                        }%>

                                </tbody>

                            </table>

                        </div>
                    </div>
                </div>
            </div>
            <% } catch (SQLException e) {
                    request.setAttribute("ExceptionObject", e);
                    request.getServletContext().getRequestDispatcher("errorPage.jsp");
                }
            %>       
        </div>



    </body>
    <script>

        function takeOutForDelivery(delivery_id) {
            $.ajax({
                url: "/agentServices/setDeliveryStatus",
                type: 'POST',
                data: {
                    delivery_id,
                    delivery_status: "OUT_FOR_DELIVERY",

                },
                success: function (e) {
                    $("#inv" + delivery_id).remove();
                    alert("This delivery is now taken out for delivery");
                }
            })
        }
        $("#filterBy").change(function (e) {
            $("#filterForm").submit();
        });
    </script>
</html>
