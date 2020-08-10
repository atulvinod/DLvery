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

        <div class="container">
            <div class="row mt-3">
                <div class="col-md-12">
                    <form action="/agentServices/getAgentDashboard" method="POST" id="filterForm">
                        <div class="input-group md-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="inputGroupSelect01">Filter By</label>
                            </div>
                            <select name="filterBy" id="filterBy" class="custom-select">
                                <option value="TODAY" <% if (filterBy.equals("TODAY")) {
                                        out.print("selected");
                                    }%>>
                                    Expected Today
                                </option>
                                <option value="MISSED" <% if (filterBy.equals("MISSED")) {
                                        out.print("selected");
                                    }%>>
                                    Missed/Pending
                                </option>
                                <option value="UPCOMING" <% if (filterBy.equals("UPCOMING")) {
                                        out.print("selected");
                                    }%>>
                                    Upcoming
                                </option>
                            </select>
                        </div>


                    </form>
                </div>            
            </div>
            <hr>

        </div>
        <div class="container">



            <%
                //Generate the items 

                try {
                    List<pending_for_agent> res = null;

                    if (filterBy.equals("TODAY")) {
                        res = agentQ.getExpectedDeliveryTodayForAgent(session.getAttribute("id").toString());
                    }
                    if (filterBy.equals("MISSED")) {
                        res = agentQ.getPendingDeliveriesForAgent(session.getAttribute("id").toString());
                    }
                    if (filterBy.equals("UPCOMING")) {
                        res = agentQ.getUpcomingDeliveryForAgent(session.getAttribute("id").toString());
                    }

                    if (res.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" id="no-inventory" >
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
                    <% for (int i = 0; i < res.size(); i++) {
                            pending_for_agent item = res.get(i); %>
                    <tr id="inv<%out.print(item.getDelivery_id());%>">
                        <td><%out.print(item.getSku());%></td>
                        <td><%out.print(item.getDelivery_name());%></td>
                        <td><%out.print(item.getDelivery_to_name());%></td>
                        <td><%out.print(item.getDelivery_address());%></td>
                        <td><%= item.getDelivery_to_contact() %></td>
                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                        <td>
                            <button class="btn btn-primary" onclick="takeOutForDelivery(<%out.print(item.getDelivery_id());%>)">Take out for Delivery</button>
                        </td>

                    </tr>


                    <% }%>

                </tbody>
                <% }

                        } catch (SQLException e) {
                            request.setAttribute("ExceptionObject", e);
                            request.getServletContext().getRequestDispatcher("errorPage.jsp");
                        }
                    }%>
            </table>


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
