<%-- 
    Document   : agent-nav
    Created on : 01-Aug-2020, 11:08:35 am
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="/css/subnav.css"/>
    </head>
    <body>
        <div class="container mt-3  md-5 ">
            <div class="row">
                <div class="col-md-10">
                    <h4>Agent Dashboard</h4>
                </div>
                <div class="col-md-2">
                    <form action="/agentServices/getAgentDashboard" onsubmit="logout()")>
                        <input type="submit" value="Logout"  class="btn btn-danger btn-sm" style="width:100%">
                    </form>



                </div>
            </div>

        </div>

        <div class="container subnav-top-margin subnav-border" >
            <ul class="nav nav-pills nav-fill">
                <li class="nav-item">
                    <a class="nav-link <%if (!request.getRequestURI().contains("agentOutForDelivery") && !request.getRequestURI().contains("agentCompleted")) {
                            out.print("active");
                        }%>" href="/agentServices/getAgentDashboard">Dashboard</a>
                </li> 
                <li class="nav-item">
                    <a class="nav-link <%if (request.getRequestURI().contains("agentOutForDelivery")) {
                            out.print("active");
                        }%>" href="/agent/agentOutForDelivery.jsp">Out For Delivery</a>
                </li> 
                <li class="nav-item">
                    <a class="nav-link <%if (request.getRequestURI().contains("agentCompleted")) {
                            out.print("active");
                        }%>" href="/agent/agentCompleted.jsp">Completed Deliveries</a>
                </li> 
            </ul>
        </div>

        <script>
            function logout(){
                $.ajax({
                    url: "/agentServices/getAgentDashboard",
                    type: 'DELETE',
                    success: function(){
                        window.location.replace('/')
                    }
                })
            }
        </script>


    </body>

</html>
