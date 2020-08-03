
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>

<%-- 
    Document   : dashboard
    Created on : 27-Jul-2020, 3:51:04 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.dlvery.datalayer.inventoryQueries" %>
<%@page import="com.mycompany.dlvery.model.inventory_table"%>
<jsp:useBean id="sql" class="com.mycompany.dlvery.datalayer.inventoryQueries"/>

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


        <div class="container" id="tableContainer"> 
            <%
                List<inventory_table> inventory = sql.getAllInventory();

                if (inventory.size() == 0) {
            %>
            <div class="text-center no-inventory-banner" id="no-inventory" >
                <h4 class="text-center text-muted">Inventory is empty</h4>
            </div>
            <%
            } else {

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

                    <% for (int i = 0; i < inventory.size(); i++) {
                            inventory_table item = inventory.get(i);%>
                    <tr class="text-center" id="inv<% out.print(item.getInventory_id());%>">
                        <td><% out.print(item.getName()); %></td>
                        <td><% out.print(item.getMove_in_date());%></td>
                        <td><% out.print(item.getMove_out_date());%></td>
                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                        <td><% out.print(item.getDamaged().equals("0") ? false : true);%></td>
                        <td><% out.print(item.getMove_out_date());%></td>
                        <td> <a href="#" onclick="deleteInventory(<% out.print(item.getInventory_id()); %>)"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                    </tr> 
                    <% //while loop end 
                        }%>
                </tbody>

            </table>

            <%   }%>
        </div>



        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <img src="..." class="rounded mr-2" alt="...">
                <strong class="mr-auto">Bootstrap</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                Hello, world! This is a toast message.
            </div>
        </div>


        <%@include file="newitemModal.jsp"%>
        <script src="/javascript/dashboard.js"></script>
    </body>
</html>
