/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.services;

import com.mycompany.dlvery.datalayer.agentQueries;
import com.mycompany.dlvery.datalayer.inventoryQueries;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author atulv
 */
public class setDeliveredDetails extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String recipientName = request.getParameter("recipientName");
        String status = request.getParameter("status");
        String signatureData = request.getParameter("signatureData");
        String delivery_id = request.getParameter("deliveryId");
        String inventory_id = request.getParameter("inventory_id");
       
        
        System.out.println(signatureData);
        System.out.println(recipientName);
        System.out.println(status);
        byte[] imageBlob = null;
        if (!(signatureData.equals("null") || signatureData == null)) {
            imageBlob = Base64.getDecoder().decode(signatureData);
        }
        try{
            //Update the delivery status 
            agentQueries.updateDeliveryStatus(Integer.parseInt(delivery_id), recipientName, status, imageBlob);
            
            // Set updated values in the inventory
            inventoryQueries.setDeliveredInventory(inventory_id);
            response.setStatus(201);
        }catch(Exception e){
            e.printStackTrace();
            response.sendError(500, e.getMessage());
            
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
