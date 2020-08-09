/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    $('#expiryDateInput').hide();
})

var perishableCheck = false;

$('#perishable').change(function (e) {
    perishableCheck = $(this).prop("checked");
})


$('#newInventoryItemForm').submit(function (e) {
    e.preventDefault();
    let formdata = $('#newInventoryItemForm').serialize();
    console.log(formdata);
    var moveInDate = $('#moveInDate').val();
    var moveOutDate = $('#moveOutDate').val();

    if (Date.parse(moveOutDate) < Date.parse(moveInDate)) {
        alert("Move in date cannot be greater than move out date");
        return;
    }
    if (Date.parse(moveOutDate) < Date.now()) {
        alert("Move out date cannot be in the past");
        return;
    }
    $.ajax({
        url: "/services/createNewInventoryItem",
        type: 'POST',
        data: formdata,
        success: function (data, textStatus, xhr) {
            console.log(xhr.status);
            let sku = $('#skuInput').val();


            let itemName = $('#itemName').val();
            let deliveryAddress = $('#deliveryAddress').val();

            let perishable = perishableCheck;

            var expiryDate = $('#expiryDate').val();
            expiryDate = expiryDate.trim().length == 0 ? "--No Expiry--" : expiryDate;

          

            let category = $('#category').val();

            // If no inventory banner is present, remove the banner
            if ($("#no-inventory").length) {
                $("#no-inventory").remove();
                let table = $('<table class="table"><thead><tr class="text-center"><th>SKU</th><th>Item Name</th><th>Category</th><th>Move-In Date</th><th>Perishable</th><th>Expiry</th><th>Damaged</th><th>Expected Move out date</th><th>Actions</th></tr></thead> <tbody id="inventoryTable"></tbody></table>');
                $("#tableContainer").append(table);
            }

            console.log(sku, moveInDate, moveOutDate, itemName, deliveryAddress, perishable, expiryDate, damaged);
            let newItem = $(` <tr class="text-center" id="inv${data}">
                    <td>${sku}</td>
                    <td>${itemName}</td>
                    <td>${category}</td>
                    <td>${moveInDate}</td>
                    <td>${perishable}</td>
                    <td>${expiryDate}</td>
                   
                    <td>${moveOutDate}</td>
                    <td> <a href="#" onclick="deleteInventory(${data})"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                </tr> `);
            $('#inventoryTable').append(newItem);
            
            $('#exampleModal').modal('hide');
        },
        error: function (xhr, textStatus) {
            if(xhr.status == 409){
                $('.invalid-feedback').css('display','block');
                $('#skuInput').css("border","1px solid red");
            }
        },
        
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

function updateAgent(id, status) {
    $.ajax({
        url: "/services/updateAgentStatus",
        type: 'POST',
        data: {
            id,
            status
        },
        complete: function (data, textStatus, xhr) {

            $("#" + id).remove();

        }

    })
}

