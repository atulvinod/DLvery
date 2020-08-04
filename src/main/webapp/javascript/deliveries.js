/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var inventory_id;
function openAssignModal(id){
    inventory_id = id;
    $('#assignModal').modal('show');
}
$('#assignDeliveryForm').submit(function(e){
    e.preventDefault();
    let agent_id = $('input[name="agentRadio"]').val();
    console.log(agent_id);
    $.ajax({
        url:'/services/assignDeliveryToAgent',
        type: 'POST',
        data:{
            inventory_id,
            agent_id
        },
        success:function(){
            $("#inv"+inventory_id).remove();
            alert("Delivery has been assigned to the agent");
            $('#assignModal').modal('hide');
        }
    })
})