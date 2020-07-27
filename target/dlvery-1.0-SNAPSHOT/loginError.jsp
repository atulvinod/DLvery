<%-- 
    Document   : loginError
    Created on : 27-Jul-2020, 3:49:28 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="/css/login.css"/>
    </head>
    <body>
        <%@include file="navbar.jsp"%>
        <div class="container">
            <div class="row login-row"> 
                <div class="col-md-12 text-center login-banner">
                    <h4>Welcome to DLvery!</h4>
                </div>
                <hr>

                <div class="col-md-4 offset-md-4 login-tabs"> 
                    <div class="login-banner-box">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-box-seam" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M8.186 1.113a.5.5 0 0 0-.372 0L1.846 3.5l2.404.961L10.404 2l-2.218-.887zm3.564 1.426L5.596 5 8 5.961 14.154 3.5l-2.404-.961zm3.25 1.7l-6.5 2.6v7.922l6.5-2.6V4.24zM7.5 14.762V6.838L1 4.239v7.923l6.5 2.6zM7.443.184a1.5 1.5 0 0 1 1.114 0l7.129 2.852A.5.5 0 0 1 16 3.5v8.662a1 1 0 0 1-.629.928l-7.185 2.874a.5.5 0 0 1-.372 0L.63 13.09a1 1 0 0 1-.63-.928V3.5a.5.5 0 0 1 .314-.464L7.443.184z"/>
                        </svg>
                        <span>Login For Management</span>
                    </div>
                    <hr>
                    <div >
                        <span class="error">Error in authentication! Either your username or password is incorrect or you don't have permissions to access the dashboard</span>
                    </div>
                    <form action="j_security_check" method="POST">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="text" class="form-control" id="exampleInputEmail1" name="j_username" aria-describedby="emailHelp">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" name="j_password" id="exampleInputPassword1">
                        </div>
                      
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>


                </div>


            </div>


        </div>

    </body>
</html>