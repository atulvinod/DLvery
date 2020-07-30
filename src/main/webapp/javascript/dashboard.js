/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $('#expiryDateInput').hide();
})
$('#newInventoryItemForm').submit(function (e) {
    e.preventDefault();
    let formdata = $('#newInventoryItemForm').serialize();
    console.log(formdata);
    $.ajax({
        url: "/services/createNewInventoryItem",
        type: 'POST',
        data: formdata,
        success: function (data, textStatus, xhr) {
         
        },
        complete: function (xhr, textStatus) {
            console.log(xhr.status);
            let sku = $('#skuInput').val();
            let moveInDate = $('#moveInDate').val();
            let moveOutDate = $('#moveOutDate').val();
            let itemName = $('#itemName').val();
            let deliveryAddress = $('#deliveryAddress').val();
           
            let perishable = $('#perishable').val();
            perishable = perishable == "on" ? true : false;
            
            let expiryDate = $('#expiryDate').val();
            expiryDate = expiryDate.trim().length == 0 ? "--No Expiry--" : expiryDate;
            
            let damaged = $('#damaged').val();
            damaged = damaged == "on" ? true : false;
            
            console.log(sku, moveInDate, moveOutDate, itemName, deliveryAddress, perishable, expiryDate, damaged);
            let newItem = $(` <tr class="text-center" id="inv${data}">
                    <td>${sku}</td>
                    <td>${itemName}</td>
                    <td>${moveInDate}</td>
                    <td>${perishable}</td>
                    <td${expiryDate}</td>
                    <td>${damaged}</td>
                    <td>${moveOutDate}</td>
                    <td> <a href="#" onclick="deleteInventory(${data})"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                </tr> `);
             $('#inventoryTable').append(newItem);
            $('#exampleModal').modal('hide');
        }
    })
});

function deleteInventory(id) {
    console.log(id);
    $.ajax({
        url: "/services/deleteInventoryItem",
        type: 'POST',
        data: {"id": id},
        success: function (data, textStatus, xhr) {
            console.log(xhr.status);
            $(`#inv${id}`).remove();
        }
    })
}

$('#perishable').change(function (e) {
    if (this.checked) {
        $('#expiryDateInput').show();
    } else {
        $('#expiryDateInput').hide();
    }
});


