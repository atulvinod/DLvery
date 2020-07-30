package com.mycompany.dlvery.services;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.mycompany.dlvery.datalayer.agentAuthenticationQueries;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author atulv
 */
public class agentLogin extends HttpServlet {

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
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    agentAuthenticationQueries authentication;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        try {
            String idToken = request.getParameter("id_token");
            String id = request.getParameter("id");

            // Will throw an error if the token is invalid
            GoogleIdToken.Payload payLoad = IdTokenVerifierAndParser.getPayload(idToken);
            String name = (String) payLoad.get("name");
            String email = payLoad.getEmail();

            //If the agent does not exist
            if (!authentication.doesAgentExist(id)) {
                authentication.createAgent(name, email, id);
                request.getServletContext().getRequestDispatcher("/agent/agentPendingAuthorization.jsp").forward(request, response);
                return;

            }
            if (!authentication.isAgentAuthorized(id)) {
                request.getServletContext().getRequestDispatcher("/agent/agentPendingAuthorization.jsp").forward(request, response);

            }
            
            

            HttpSession session = request.getSession(true);
            session.setAttribute("userName", name);
            request.getServletContext()
                    .getRequestDispatcher("/agent/agentDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            throw new RuntimeException(e);
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
        authentication = new agentAuthenticationQueries();
    }

    @Override
    public void destroy() {
        super.destroy(); //To change body of generated methods, choose Tools | Templates.
        try{
        authentication.closeConnection();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
}
