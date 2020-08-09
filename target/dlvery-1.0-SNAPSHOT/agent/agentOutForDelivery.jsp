<%-- 
    Document   : agentDashboard
    Created on : 30-Jul-2020, 12:35:32 pm
    Author     : atulv
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="com.mycompany.dlvery.datalayer.agentQueries" %>
<%@page import="com.mycompany.dlvery.model.pending_for_agent" %>
<jsp:useBean id="agentQ" class="com.mycompany.dlvery.datalayer.agentQueries"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/navbar.jsp" %>
        <%@include file="agent-nav.jsp" %>
        <br>
        <div class="container">
            
            

            <% List<pending_for_agent> res = agentQ.getOutForDeliveryForAgent(session.getAttribute("id").toString());
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
                        <td><% out.print(item.getPerishable().equals("0") ? false : true);%></td>
                        <td><% out.print(item.getExpiry() == null ? "--No Expiry--" : item.getExpiry());%></td>
                        <td>
                            <button class="btn btn-primary" onclick='openDeliveryModal("<%out.print(item.getDelivery_to_name());%>", "<%out.print(item.getDelivery_address());%>", "<%out.print(item.getDelivery_id());%>", "<%out.print(item.getInventory_id());%>")'>Update Status</button>
                        </td>

                    </tr>


                    <% }%>

                </tbody>
                <% }%>
            </table>


        </div>

        <!--     Deliver Modal -->
        <div class="modal fade" tabindex="-1" role="dialog" id="deliveryModal" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Deliver</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>
                    <div class="modal-body">
                        <form id="deliveryForm">
                            <div class="form-group">
                                <label for="deliverToName">Recipient</label>
                                <input type="text" name="deliverToName" id="deliverToName" class="form-control">
                                <small id="deliverToNameHelp" class="form-text text-muted">Change the recipient name if the person receiving the package is different</small>

                            </div>
                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">Delivery Address</label>
                                <textarea class="form-control" id="deliveryAddress" rows="3"></textarea>
                            </div>
                            <div class="form-group">


                            </div>

                            <hr>
                            <div>
                                <h5>Delivery Status</h5>
                                <div class="form-check">
                                    <input type="radio" name="deliveryStatus" value="DELIVERED" class="form-check-input" id="deliveredRadio">
                                    <label class="form-check-label" for="exampleCheck1">Delivered</label>
                                </div> 
                                <div id="recipientSignature">
                                    <h6>Recipient signature here</h6>
                                    <canvas width="400" height="200" style="border:1px solid #000000;" id="signature">

                                    </canvas>
                                </div>
                                <div class="form-check">
                                    <input type="radio" name="deliveryStatus" class="form-check-input" id="doorLockedRadio" value="DOOR_LOCK">
                                    <label class="form-check-label" for="exampleCheck1">Door Locked</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" name="deliveryStatus" class="form-check-input" id="transitDamagedRadio" value="TRANSIT_DAMAGED">
                                    <label class="form-check-label" for="exampleCheck1">Transit Damaged</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" name="deliveryStatus" class="form-check-input" id="returnedRadio" value="RETURNED">
                                    <label class="form-check-label" for="exampleCheck1">Returned</label>
                                </div>
                            </div>
                            <hr>
                            <div class="modal-footer">
                                <input type="submit" value="Submit Delivery Status" class="btn btn-success">
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>

        <script>

            var delivery_id_to_remove;
            var inventory_id_to_remove;
            function openDeliveryModal(deliverTo, deliveryAddress, delivery_id, inventory_id) {
                delivery_id_to_remove = delivery_id;
                inventory_id_to_remove = inventory_id;
                $('#deliveryModal').modal('show');
                $('#deliverToName').val(deliverTo);
                $('#deliveryAddress').val(deliveryAddress);
            }

            // For the canvas drawing
            $(document).ready(function () {
                var flag, dot_flag = false,
                        prevX, prevY, currX, currY = 0,
                        color = 'black', thickness = 2;
                var $canvas = $('#signature');
                var ctx = $canvas[0].getContext('2d');
                $canvas.on('mousemove mousedown mouseup mouseout', function (e) {
                    prevX = currX;
                    prevY = currY;
                    currX = e.clientX - $canvas.offset().left;
                    currY = e.clientY - $canvas.offset().top;
                    if (e.type == 'mousedown') {
                        flag = true;
                    }
                    if (e.type == 'mouseup' || e.type == 'mouseout') {
                        flag = false;
                    }
                    if (e.type == 'mousemove') {
                        if (flag) {
                            ctx.beginPath();
                            ctx.moveTo(prevX, prevY);
                            ctx.lineTo(currX, currY);
                            ctx.strokeStyle = color;
                            ctx.lineWidth = thickness;
                            ctx.stroke();
                            ctx.closePath();
                        }
                    }
                });
            });



            $(document).ready(function () {

                // Hide the recipientsignature 


                $('input[name="deliveryStatus"]').change(function (e) {
                    if (this.value == "DELIVERED") {
                        $('#recipientSignature').show();
                    } else {
                        $('#recipientSignature').hide();
                    }
                })
            });

            $('#deliveryForm').submit(function (e) {
                e.preventDefault();
                let recipientName = $('#deliverToName').val();
                let status = $('input[name="deliveryStatus"]:checked').val();
                let signatureData = null;
                if (status == "DELIVERED") {
                    let canvas = document.getElementById('signature');
                    signatureData = canvas.toDataURL().replace(/^data:image\/(png|jpg|jpeg|gif);base64,/, "");

                    $.ajax({
                        url: "/agentServices/setDeliveredDetails",
                        type: 'POST',
                        data: {
                            recipientName,
                            status,
                            signatureData,
                            deliveryId: delivery_id_to_remove,
                            inventory_id: inventory_id_to_remove
                        }
                        ,
                        success: function (e) {
                            clearCanvas();
                            $("#inv" + delivery_id_to_remove).remove();
                            $('#deliveryModal').modal('hide');

                        }
                    })
                } else {
                    $.ajax({
                        url: "/agentServices/setDeliveryStatus",
                        type: 'POST',
                        data: {
                            delivery_id :delivery_id_to_remove,
                            delivery_status: status
                        },
                        success: function (e) {
                            clearCanvas();
                            $("#inv" + delivery_id_to_remove).remove();
                            $('#deliveryModal').modal('hide');

                        }
                    })
                }

            })

            function clearCanvas() {
                var $canvas = $('canvas');
                var ctx = $canvas[0].getContext('2d');
                c_width = $canvas.width();
                c_height = $canvas.height();
                ctx.clearRect(0, 0, c_width, c_height);
            }

        </script>


    </body>

</html>
