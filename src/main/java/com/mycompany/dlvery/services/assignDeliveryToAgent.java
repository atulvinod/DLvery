package com.mycompany.dlvery.services;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.mycompany.dlvery.datalayer.agentQueries;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sun.jvm.hotspot.utilities.soql.SOQLException;

/**
 *
 * @author atulv
 */
public class assignDeliveryToAgent extends HttpServlet {

 

    
    agentQueries agentQ;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inventory_id = request.getParameter("inventory_id");
        String agent_id = request.getParameter("agent_id");
        try{
            agentQueries.assignDeliveryToAgent(agent_id, inventory_id);
            response.setStatus(201);
        }catch(Exception e){
            response.setStatus(500,"SQL Exception");
            e.printStackTrace();
        }
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }

    @Override
    public void init() throws ServletException {
        super.init(); //To change body of generated methods, choose Tools | Templates.
        agentQ = new agentQueries();
    }
    
}
