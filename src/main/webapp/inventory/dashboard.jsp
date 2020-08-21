
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>

<%-- 
    Document   : dashboard
    Created on : 27-Jul-2020, 3:51:04 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="/errorPage.jsp"%>
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
            <div class="row" id="infoRow">
                <%
                    // Inventory Upload Status
                    if (request.getAttribute("uploadSuccess") != null && (boolean) request.getAttribute("uploadSuccess") == true) {


                %>
                <div class="alert alert-success alert-dismissible fade show col-md-12" role="alert">
                    Inventory File upload was completed successfully
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%                    }

                    if (request.getAttribute("uploadErrors") != null && ((LinkedList) request.getAttribute("uploadErrors")).size() > 0) {
                        List<Exception> exceptions = (LinkedList) request.getAttribute("uploadErrors");
                %>
                <div class="alert alert-info alert-dismissible fade show col-md-12" role="alert">
                    <h5>There were some errors with your Inventory File. Rectify the errors that are listed below and upload again.</h5>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <hr class="col-md-12">
                <%
                    for (int i = 0; i < exceptions.size(); i++) {
                %>
                <div class="alert alert-danger alert-dismissible fade show col-md-12" role="alert">
                    <%  out.print(exceptions.get(i).getMessage());%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div> 
                <%
                    } %>
                <<button onclick="function () {
                            $('#infoRow').remove()
                        }" class="btn btn-primary btn-sm">Clear All</button>
                <hr class="col-md-12">
                <%}
                %>



            </div>




            <% // For Filters
                List<inventory_table> inventory = null;
                String stateFilter = null, categoryFilter = null;
                stateFilter = request.getAttribute("stateFilter") == null ? "all" : (String) request.getAttribute("stateFilter");

                if ((request.getAttribute("categoryFilter") == null) || request.getAttribute("categoryFilter").equals("all")) {
                    categoryFilter = "%%";
                } else {
                    categoryFilter = (String) request.getAttribute("categoryFilter");
                }

            %>

            <div class="row">
                <div class="col-md-1 text-center">
                    <svg style="font-size: 40px;  margin-top: 13%" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-box-seam" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M8.186 1.113a.5.5 0 0 0-.372 0L1.846 3.5l2.404.961L10.404 2l-2.218-.887zm3.564 1.426L5.596 5 8 5.961 14.154 3.5l-2.404-.961zm3.25 1.7l-6.5 2.6v7.922l6.5-2.6V4.24zM7.5 14.762V6.838L1 4.239v7.923l6.5 2.6zM7.443.184a1.5 1.5 0 0 1 1.114 0l7.129 2.852A.5.5 0 0 1 16 3.5v8.662a1 1 0 0 1-.629.928l-7.185 2.874a.5.5 0 0 1-.372 0L.63 13.09a1 1 0 0 1-.63-.928V3.5a.5.5 0 0 1 .314-.464L7.443.184z"/>
                    </svg>
                </div>

                <div class="col-md-6">
                    <form action="/inventory/getInventoryDashboard" method="GET" id="filterForm">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="inputGroupSelect01">Filter</label>
                            </div>

                            <select class="custom-select" id="stateFilter" name="stateFilter">
                                <option <% if (stateFilter.equals("all")) {
                                        out.print("selected");
                                    }%> value="all">Show All</option>

                                <option <% if (stateFilter.equals("perishable")) {
                                        out.print("selected");
                                    }%> value="perishable">Perishables</option>
                                <option <% if (stateFilter.equals("non_perishable")) {
                                        out.print("selected");
                                    }%> value="non_perishable">Non Perishable</option>
                                <option <% if (stateFilter.equals("near_expiry")) {
                                        out.print("selected");
                                    }%> value="near_expiry">Near Expiry</option>
                            </select>


                        </div>



                        <div class="input-group mb-4">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="inputGroupSelect01">Category</label>
                            </div>

                            <select class="custom-select" id="categoryFilter" name="categoryFilter">
                                <option <% if (categoryFilter.equals("%%")) {
                                        out.print("selected");
                                    }%> value="all">All</option>
                                <option <% if (categoryFilter.equals("clothing")) {
                                        out.print("selected");
                                    }%> value="clothing">Clothing</option>
                                <option <% if (categoryFilter.equals("food")) {
                                        out.print("selected");
                                    }%> value="food">Food</option>
                                <option <% if (categoryFilter.equals("medical")) {
                                        out.print("selected");
                                    }%> value="medical">Medical</option>
                                <option<% if (categoryFilter.equals("toys")) {
                                        out.print("selected");
                                    }%> value="toys">Toys</option>
                                <option <% if (categoryFilter.equals("electronics")) {
                                        out.print("selected");
                                    }%> value=electronics>Electronics</option>

                            </select>


                        </div>
                    </form>

                </div>

                <div class="col-md-5 clearfix inventory-buttons">

                    <button class="btn btn-primary float-right" data-toggle="modal" data-target="#uploadModal">Upload Inventory File</button>


                    <button class="btn btn-primary float-right" data-toggle="modal" data-target="#exampleModal" >New Inventory Items</button>

                </div>

            </div>
            <hr>
        </div> 


        <div class="container" id="tableContainer"> 
            <%
                try {
                    if (stateFilter.equals("damaged")) {
                        //out.print("All Acc To damaged true");

                        inventory = sql.getAccToCategoryAndDamagedStatus(categoryFilter, true);
                    } else if (stateFilter.equals("non_damaged")) {
                        //out.print("All Acc To damaged false");

                        inventory = sql.getAccToCategoryAndDamagedStatus(categoryFilter, false);
                    } else if (stateFilter.equals("perishable")) {
                        inventory = sql.getAccToCategoryAndPerishableStatus(categoryFilter, true);
                        // out.print("All Acc To perishble false");

                    } else if (stateFilter.equals("non_perishable")) {
                        inventory = sql.getAccToCategoryAndPerishableStatus(categoryFilter, false);
                    } else if (stateFilter.equals("perishable")) {
                        // out.print("All Acc To perishable true");

                        inventory = sql.getAccToCategoryAndPerishableStatus(categoryFilter, true);

                    } else if (stateFilter.equals("near_expiry")) {
                        //   out.print("All Acc To near expiry");

                        inventory = sql.getAccToCategoryAndNearExpiry(categoryFilter);

                    } else {
                        //  out.print("All Acc To category");
                        inventory = sql.getAllInventoryAccToCategory(categoryFilter);

                    }

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
                        <th>Category</th>
                        <th>Move-In Date</th>
                        <th>Perishable</th>
                        <th>Expiry</th>
                        <th>Deliver To</th>
                        <th>Expected Delivery Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="inventoryTable">

                    <% for (int i = 0; i < inventory.size(); i++) {
                            inventory_table item = inventory.get(i);%>
                    <tr class="text-center" id="inv<% out.print(item.getInventory_id());%>">
                        <td><%  out.print(item.getSku());%></td>
                        <td><% out.print(item.getName()); %></td>
                        <td><%out.print(item.getCategory());%></td>
                        <td><% out.print(item.getMove_in_date());%></td>

                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                        <td><%=  item.getDelivery_address()%></td>
                        <td><% out.print(item.getMove_out_date());%></td>
                        <td> <a href="#" onclick="deleteInventory(<% out.print(item.getInventory_id()); %>)"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                    </tr> 
                    <% //while loop end 
                        }%>
                </tbody>

            </table>

            <%  //Closing all inventory tag 
                    }

                } catch (Exception e) {
                    request.setAttribute("ExceptionObject", e);
                    request.getServletContext().getRequestDispatcher("errorPage.jsp");
                }%>


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

        <div class="modal fade" id="uploadModal" role="dialog" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Upload Inventory File
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="/inventory/getInventoryDashboard" method="POST" enctype="multipart/form-data" id="uploadInventoryFileForm">
                            <h6>Please upload JSON file following the inventory format.</h6>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="uploadInventory" name="uploadInventory">
                                <label class="custom-file-label" for="customFile" id="inventoryFileLabel">Choose Inventory file</label>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-success" onclick="uploadInventory()" id="uploadInventoryButton">Upload File</button>
                    </div>
                </div>
            </div>


        </div>       


        <%@include file="newitemModal.jsp"%>
        <script src="/javascript/dashboard.js"></script>

    </body>
  
</html>
