<%-- 
    Document   : login-agent
    Created on : 30-Jul-2020, 12:10:09 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id"
              content="859229192203-kuiasi2lq952q2d9ltrn9ilkmnekm0bu.apps.googleusercontent.com">

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
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bag-check" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M14 5H2v9a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V5zM1 4v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4H1z"/>
                        <path d="M8 1.5A2.5 2.5 0 0 0 5.5 4h-1a3.5 3.5 0 1 1 7 0h-1A2.5 2.5 0 0 0 8 1.5z"/>
                        <path fill-rule="evenodd" d="M10.854 7.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 10.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                        </svg>
                        <span>Login For Delivery Agents</span>
                    </div>
                    <hr>
                    <div>
                        <h6>Use your Google Account to Access your Dashboard</h6>
                    </div>
                    <br>
                    <div class="text-center">
                        <div class="g-signin2" data-onsuccess="onSignIn"></div>
                    </div>



                </div>

               
            </div>


        </div>
        <script>
            function onSignIn(googleUser) {
                var profile = googleUser.getBasicProfile();
                var redirectURL = '/agentServices/agentLogin'

                console.log('ID: ' + profile.getId());
                console.log('Name: ' + profile.getName());
                console.log('Image URL: ' + profile.getImageUrl());
                console.log('Email: ' + profile.getEmail());
                console.log('id_token: ' + googleUser.getAuthResponse().id_token);

                var form = $('<form action="' + redirectURL + '" method="post" style="visibility:hidden" >' +
                        '<input type="text" name="id_token" value="' +
                        googleUser.getAuthResponse().id_token + '" />' + ' <input type="text" value =" '+profile.getId()+' " name="id"/> '+
                        '</form>');
                $('body').append(form);
                form.submit();

            }

        </script>
    </body>
</html>
