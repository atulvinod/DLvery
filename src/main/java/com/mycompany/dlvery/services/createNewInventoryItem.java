/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.services;

import com.mycompany.dlvery.datalayer.inventoryQueries;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author atulv
 */
public class createNewInventoryItem extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    public void init()
            throws ServletException {
        super.init(); //To change body of generated methods, choose Tools | Templates.
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sku = request.getParameter("sku");
        String moveInDate = request.getParameter("moveInDate");
        String moveOutDate = request.getParameter("moveOutDate");
        String itemName = request.getParameter("itemName");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String deliveryTo = request.getParameter("deliveryTo");
        
        String perishable = request.getParameter("perishable");
        boolean perishableValue = perishable == null ? false : true;
        
        String expiry = request.getParameter("expiryDate");
        String category  =request.getParameter("category");
        
        String deliveryToContact = request.getParameter("deliveryToContactNumber");
        String deliveryFromAddress = request.getParameter("deliveryFromAddress");
        try {
            
            response.setStatus(201);
            response.getOutputStream().print(inventoryQueries.createNewInventoryItem(sku, itemName, category,moveInDate, moveOutDate, perishableValue, expiry, deliveryAddress,deliveryTo,deliveryToContact,deliveryFromAddress));
        } catch (Exception e) {
            System.out.println("Stack Trace ");
            if(e.getMessage().contains("Duplicate entry")){
                response.sendError(409);
                
            }else{
            response.setStatus(500);
            }
        }
        
     }

  
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
