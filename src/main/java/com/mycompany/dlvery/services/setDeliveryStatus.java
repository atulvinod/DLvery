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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author atulv
 */
public class setDeliveryStatus extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    inventoryQueries q;

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
        String delivery_id = request.getParameter("delivery_id");
        String delivery_status = request.getParameter("delivery_status");

        try {
            switch (delivery_status) {
                case "DOOR_LOCK":
                    agentQueries.setDoorLocked(delivery_id);
                    break;
                case "TRANSIT_DAMAGED":
                    agentQueries.setTransitDamaged(delivery_id);
                    break;
                case "RETURNED":
                    agentQueries.setReturned(delivery_id);
                    break;
                case "OUT_FOR_DELIVERY":
                    inventoryQueries.setOutForDelivery(delivery_id);
                    break;
                default:
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ExceptionObject", e);
            request.getServletContext().getRequestDispatcher("errorPage.jsp");
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

    @Override
    public void init() throws ServletException {
        super.init(); //To change body of generated methods, choose Tools | Templates.
        q = new inventoryQueries();
    }

}
