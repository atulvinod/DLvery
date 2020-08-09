<%-- 
    Document   : subnav
    Created on : 27-Jul-2020, 4:13:49 pm
    Author     : atulv
--%>

<%@page import="java.util.List"%>
<%@page import="com.mycompany.dlvery.model.agent_details"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mycompany.dlvery.datalayer.agentAuthenticationQueries"%>
<jsp:useBean id="agent" class="com.mycompany.dlvery.datalayer.agentAuthenticationQueries"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/subnav.css"/>
    </head>
    <body>
        <div class="container subnav-top-margin subnav-border" >
            <div class="nav nav-pills nav-fill nav-justified">
          
                <a class="nav-item nav-link 
                   <% if (request.getRequestURI().contains("reports")) {
                           out.print("active");
                       }%>" href="/inventory/reports/getDeliveredInRangeReport">Reports</a>
                <a class="nav-item nav-link <% if (request.getRequestURI().contains("dashboard")) {
                    out.print("active");
                }%>" href="/inventory/dashboard.jsp">Current Inventory</a>
                <a class="nav-item nav-link <% if (request.getRequestURI().contains("delivery/deliveries") || request.getRequestURI().contains("history")) {
                    out.print("active");
                }%>" href="/inventory/delivery/deliveries.jsp">Deliveries</a>

            </div>


        </div>
                
                     <div class="modal fade" id="agentsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Authentication Requests</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%
                            List<agent_details> agentAuth = agent.getPendingAgentAuths();

                        %>
                        <table class="table">    
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email </th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%for(int i = 0 ; i< agentAuth.size() ; i++) { agent_details item = agentAuth.get(i);
                                %>
                                <tr id="<%out.print(item.getAgent_auth_id());%>">
                                    <td><%out.print(item.getAgent_name());%></td>
                                    <td><%out.print(item.getAgent_email());%></td>
                                    <td><button class="btn btn-success" onclick="updateAgent('<% out.print(item.getAgent_auth_id());%>', true)">Accept</button>&nbsp;<button class="btn btn-danger" onclick="updateAgent('<% out.print(item.getAgent_auth_id());%>', false)">Reject</button></td>
                                </tr>


                                <% }%>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
