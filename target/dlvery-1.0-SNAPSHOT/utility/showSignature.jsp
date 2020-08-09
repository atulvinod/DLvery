<%-- 
    Document   : showSignature
    Created on : 08-Aug-2020, 7:07:49 pm
    Author     : atulv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="modal" tabindex="-1" role="dialog" id="ackModal" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Acknowledgement</h5>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name" >Reciever name</label>
                            <input type="text" name="reciever" id="recieverName" class="form-control" readonly>
                        </div>
                        
                        <br>
                        <h6 class="text-success">Recipient signature</h6>
                        <div id="ackImageDiv">

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" onclick="closeAck()">Close</button>
                    </div>
                </div>


            </div>


        </div>

    </body>
    <script>
        function closeAck() {
            $("#ackImageDiv").empty();
            $('#ackModal').modal('hide');

        }
        function showAckModal(delivery_id, reciever_name) {
            $('#recieverName').val(reciever_name);
            $('#ackModal').modal('show');
            $.ajax({
                url: "/getSignatureImage",
                type: 'POST',
                data: {
                    delivery_id
                }
                , success: function (e) {
                    let image = $('<img src="data:image/jpeg;base64,' + e + '" width="400" height="200"></img>');
                    $('#ackImageDiv').append(image);

                }
            })
        }
    </script>
</html>
