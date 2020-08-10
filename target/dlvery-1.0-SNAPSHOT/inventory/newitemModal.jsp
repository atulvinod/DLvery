<%-- 
    Document   : newitemModal
    Created on : 27-Jul-2020, 7:59:58 pm
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
        <div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Create new Inventory item</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form  id="newInventoryItemForm">


                            <div class="form-group row">
                                <label for="sku" class="col-md-2 col-form-label text-center">SKU</label>
                                <div class="col-md-10">
                                    <input type="text" name="sku" id="skuInput" class="form-control" required="true">
                                    <small id="skuHelp" class="form-text text-muted">SKU is a unique identifier used to keep track of objects</small>                                
                                    <div class="invalid-feedback">
                                        SKU is invalid
                                    </div>
                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-md-6 ">
                                    <label for="moveInDate">Move In Date</label>
                                    <input type="date" name="moveInDate" id="moveInDate" class="form-control" required="true">
                                </div>
                                <div class="col-md-6 ">
                                    <label for="moveOutDate">
                                        Expected  move out date
                                    </label>
                                    <input type="date" name="moveOutDate" id="moveOutDate" class="form-control" required="true">
                                </div>
                            </div>
                            <div class="form-group">

                                <label for="itemName">Item Name</label>
                                <input type="text" name="itemName" id="itemName" class="form-control" required="true">
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <label class="input-group-text" for="inputGroupSelect01">Category</label>
                                </div>
                                <select class="custom-select" id="category" name="category">
                                    <option selected value="clothing">Clothing</option>
                                    <option value ="food">Food</option>
                                    <option value="medical">Medical</option>
                                    <option value="toys">Toys</option>
                                    <option value="electronics">Electronics</option>

                                </select>
                            </div>
                             <div class="form-group">
                                <label for="deliveryFromAddress">Delivery From Address</label>
                                <textarea class="form-control" id="deliveryFromAddress" rows="3" required="true" name="deliveryFromAddress"></textarea>
                            </div>
                            <div class="form-group">

                                <label for="deliveryTo">Recipient Name</label>
                                <input type="text" name="deliveryTo" id="deliveryTo" class="form-control" required="true">
                            </div>
                              <div class="form-group">

                                <label for="deliveryTo">Contact Number</label>
                                <input type="text" name="deliveryToContactNumber" id="deliveryToContactNumber" class="form-control" required="true">
                            </div>
                            
                            <div class="form-group">
                                <label for="deliveryAddress">Deliver to Address</label>
                                <textarea class="form-control" id="deliveryAddress" rows="3" required="true" name="deliveryAddress"></textarea>
                            </div>
                            <hr>
                            <h5>Item Characteristics</h5>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox"  id="perishable"  name="perishable" unchecked>
                                <label class="form-check-label" for="perishable">
                                    Perishable
                                </label>
                            </div>
                            <div class="form-group" id="expiryDateInput">
                                <label for="expiryDate">
                                    Expiry Date
                                </label>
                                <input type="date" name="expiryDate" id="expiryDate" class="form-control" >
                            </div>
                          
                            <hr>
                            <input type="submit" value="Submit" class="btn btn-success">

                        </form>



                    </div>

                </div>
            </div>
        </div>

    </body>

</html>
