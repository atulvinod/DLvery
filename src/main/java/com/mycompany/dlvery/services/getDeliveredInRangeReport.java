/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.services;

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
public class getDeliveredInRangeReport extends HttpServlet {

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
        request.getServletContext().getRequestDispatcher("/inventory/reports/deliveredInRangeReport.jsp").forward(request,response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       request.setAttribute("fromDate",request.getParameter("fromDate"));
       request.setAttribute("toDate", request.getParameter("toDate"));
       request.getServletContext().getRequestDispatcher("/inventory/reports/deliveredInRangeReport.jsp").forward(request,response);

    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
