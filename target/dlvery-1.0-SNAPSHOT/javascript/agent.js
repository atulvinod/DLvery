/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function openDeliveryModal(deliverTo, deliveryAddress){
    $('#deliveryModal').modal('show');
    $('#deliverToName').val(deliverTo);
    $('#deliveryAddress').val(deliveryAddress);
}