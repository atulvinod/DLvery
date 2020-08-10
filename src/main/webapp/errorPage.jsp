<%-- 
    Document   : errorPage
    Created on : 09-Aug-2020, 11:03:35 am
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/navbar.jsp" %>

        <%
            Exception e = (Exception) request.getAttribute("ExceptionObject");
        %>
        <br>
        <br>
        <div class="container">
            <div class="text-center">
                <h2>An Error has occurred :(</h2>
                <hr>
             
            </div>
            <div>
                <div class="text-center">
                    
                    <span class="text-danger" style="font-size:5rem"><%= request.getAttribute("javax.servlet.error.status_code")%></span>
                </div>


                <% if (request.getAttribute("javax.servlet.error.message") != null) {%>
                <p class="text-danger" >

                    <%= request.getAttribute("javax.servlet.error.message")%>
                </p>
                <%}%>
            </div>
            <div>
                <div class="accordion" id="accordionExample">
                    <div class="card">
                        <div class="card-header" id="headingOne">
                            <h2 class="mb-0">
                                <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    Stack Trace
                                </button>
                            </h2>
                        </div>

                        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                            <div class="card-body">
                                <%= request.getAttribute("javax.servlet.error.exception")%><br>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <br>
            <div class="text-muted text-center">
                <h6>Try again or contact the administrator</h6>
            </div>
        </div>

    </body>
</html>
