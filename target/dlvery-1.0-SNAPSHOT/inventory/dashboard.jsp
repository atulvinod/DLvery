
<%@page import="java.sql.ResultSet"%>

<%-- 
    Document   : dashboard
    Created on : 27-Jul-2020, 3:51:04 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.datalayer.agentAuthenticationQueries"%>
<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>
<jsp:useBean id="agent" class="com.mycompany.dlvery.datalayer.agentAuthenticationQueries"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/management-dashboard.css"/>
    </head>
    <body>
        <%@include file="../navbar.jsp" %>
        <div>
            <%@include file="subnav.jsp" %>
        </div>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h3>Inventory</h3>
                </div>
                <div class="col-md-5 clearfix inventory-buttons">
                    
                        <button class="btn btn-primary float-right">Upload Inventory File</button>

                    
                        <button class="btn btn-primary float-right" data-toggle="modal" data-target="#exampleModal" >New Inventory Items</button>

                </div>
                
            </div>
            <hr>
        </div> 
    
        
        <div class="container"> 
            <% 
                ResultSet allInventoryItems = sql.getAllInventory();
                
                if(allInventoryItems.next()==false){
            %>
                    <div class="text-center no-inventory-banner" >
                      <h4 class="text-center text-muted">Inventory is empty</h4>
                     </div>
            <%
                }else{
            %>
            <table  class="table">
                <thead>
                    <tr class="text-center">
                        <th>SKU</th>
                        <th>Item Name</th>
                        <th>Move-In Date</th>
                        <th>Perishable</th>
                        <th>Expiry</th>
                        <th>Damaged</th>
                        <th>Expected Move out date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="inventoryTable">
                <% while(allInventoryItems.next()){ %>
                <tr class="text-center" id="inv<% out.print(allInventoryItems.getString("inventory_id"));%>">
                    <td><% out.print(allInventoryItems.getString("sku")); %></td>
                    <td><% out.print(allInventoryItems.getString("name"));%></td>
                    <td><% out.print(allInventoryItems.getString("move_in_date"));%></td>
                    <td><% out.print(allInventoryItems.getString("perishable").equals("0") ? false : true);%></td>
                    <td><% out.print(allInventoryItems.getString("expiry") == null ? "--No Expiry--" : allInventoryItems.getString("expiry"));%></td>
                    <td><% out.print(allInventoryItems.getString("damaged").equals("0") ? false : true);%></td>
                    <td><% out.print(allInventoryItems.getString("move_out_date"));%></td>
                    <td> <a href="#" onclick="deleteInventory(<% out.print(allInventoryItems.getString("inventory_id")); %>)"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                </tr> 
                <% //while loop end 
                  }%>
                </tbody>

            </table>
            
            <%   }  %>
        </div>
        
        <%@include file="newitemModal.jsp"%>
        <script src="/javascript/dashboard.js"></script>
    </body>
</html>
