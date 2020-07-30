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

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
        
        String perishable = request.getParameter("perishable");
        boolean perishableValue = perishable == null ? false : true;
        
        String damaged = request.getParameter("damaged");
        boolean damagedValue = damaged == null ? false : true;
        
        String expiry = request.getParameter("expiryDate");
        try {
            
            response.setStatus(201);
            response.getOutputStream().print(inventoryQueries.createNewInventoryItem(sku, itemName, moveInDate, moveOutDate, perishableValue, expiry, damagedValue, deliveryAddress));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
        }
        
        System.out.println(String.format("sku:%s moveInDate:%s moveOutDate:%s itemName:%s deliveryAddress:%s perishable:%s damaged:%s expiry:%s", sku, moveInDate, moveOutDate, itemName, deliveryAddress, perishable, damaged,expiry));
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
