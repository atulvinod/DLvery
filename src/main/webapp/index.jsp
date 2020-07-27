<%-- 
    Document   : index
    Created on : 27-Jul-2020, 3:16:21 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/css/login.css"/>

        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="navbar.jsp"%>

        <div class="container">

            <div class="row login-row">
                <div class="col-md-12 text-center login-banner">
                    <h4>Welcome to DLvery!</h4>
                </div>
                <hr>
                
                <div class="col-md-4 offset-md-2 login-tabs right-margin">
                    <div class="login-icon">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-box-seam" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M8.186 1.113a.5.5 0 0 0-.372 0L1.846 3.5l2.404.961L10.404 2l-2.218-.887zm3.564 1.426L5.596 5 8 5.961 14.154 3.5l-2.404-.961zm3.25 1.7l-6.5 2.6v7.922l6.5-2.6V4.24zM7.5 14.762V6.838L1 4.239v7.923l6.5 2.6zM7.443.184a1.5 1.5 0 0 1 1.114 0l7.129 2.852A.5.5 0 0 1 16 3.5v8.662a1 1 0 0 1-.629.928l-7.185 2.874a.5.5 0 0 1-.372 0L.63 13.09a1 1 0 0 1-.63-.928V3.5a.5.5 0 0 1 .314-.464L7.443.184z"/>
                        </svg>
                    </div>
                    <div class="login-heading">
                                            <h5>Inventory Management</h5>

                    </div>
                    <div class="text-center">
                        <a href="/inventory/dashboard.jsp" class="btn btn-primary">Login to Inventory Management</a>
                    </div> 

                </div>    
                <div class="col-md-4 login-tabs">
                    <div class="login-icon">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bag-check" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M14 5H2v9a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V5zM1 4v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4H1z"/>
                        <path d="M8 1.5A2.5 2.5 0 0 0 5.5 4h-1a3.5 3.5 0 1 1 7 0h-1A2.5 2.5 0 0 0 8 1.5z"/>
                        <path fill-rule="evenodd" d="M10.854 7.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 10.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                        </svg>
                    </div> 
                    <div class="login-heading">
                         <h5>Delivery Management</h5>
                    </div>
                    <div class="text-center">
                        <a href="" class="btn btn-primary">Login to Delivery Management</a>
                    </div> 
                   

                </div>
            </div>
        </div>
    </body>
</html>
