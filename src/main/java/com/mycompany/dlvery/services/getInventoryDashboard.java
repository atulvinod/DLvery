/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dlvery.services;

import com.mycompany.dlvery.datalayer.inventoryQueries;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author atulv
 */
public class getInventoryDashboard extends HttpServlet {

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
        String categoryFilter = request.getParameter("categoryFilter");
        String stateFilter = request.getParameter("stateFilter");
        if (stateFilter == null) {
            stateFilter = "all";
        }
        if (categoryFilter == null) {
            categoryFilter = "all";
        }
        request.setAttribute("stateFilter", stateFilter);
        request.setAttribute("categoryFilter", categoryFilter);
        request.getServletContext().getRequestDispatcher("/inventory/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.getSession().invalidate();//To change body of generated methods, choose Tools | Templates.
    }
    
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 50 * 1024;
    private int maxMemSize = 4 * 1024;
    private File json;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            response.sendError(400);
            return;
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);
        File jsonFile = new File("jsonFile");
        try {
            List fileItems = upload.parseRequest(request);
            Iterator i = fileItems.iterator();

            while (i.hasNext()) {
                FileItem fileItem = (FileItem) i.next();
                if (!fileItem.isFormField()) {
                    fileItem.write(jsonFile);
                }
            }

            BufferedReader reader = new BufferedReader(new FileReader(jsonFile));
            StringBuilder stringBuilder = new StringBuilder();
            String line = null;
            String ls = System.getProperty("line.separator");
            while ((line = reader.readLine()) != null) {
                stringBuilder.append(line);
                stringBuilder.append(ls);
            }
            // delete the last new line separator
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            reader.close();

            String content = stringBuilder.toString();
            System.out.println(content);

            JSONParser jsonParser = new JSONParser();
            JSONArray jsonObject = (JSONArray) jsonParser.parse(content);

            Iterator jsonArrayInterator = jsonObject.iterator();

            List<Exception> exceptionsList = new LinkedList<Exception>();

            while (jsonArrayInterator.hasNext()) {

                try {
                    JSONObject object = (JSONObject) jsonArrayInterator.next();
                    String sku = (String) object.get("sku");
                    String name = (String) object.get("itemName");
                    String category = (String) object.get("category");
                    boolean perishable = (String) object.get("perishable") == null || ((String) object.get("perishable")).equals("false") ? false : true;
                    String expiry = (String) object.get("expiry");
                  
                    String moveOutDate = (String) object.get("moveOutDate");
                    String moveInDate = (String) object.get("moveInDate");
                    String deliveryAddress = (String) object.get("deliveryAddress");
                    String deliveryToName = (String) object.get("deliveryToName");
                    String deliveryToContactNumber = (String)object.get("deliveryToContactNumber");
                    String deliveryFromAddress = (String)object.get("deliveryToAddress");

                    inventoryQueries.createNewInventoryItem(sku, name, category, moveInDate, moveOutDate, perishable, expiry, deliveryAddress, deliveryToName,deliveryToContactNumber,deliveryFromAddress);
                } catch (Exception e) {
                    e.printStackTrace();
                    exceptionsList.add(e);

                }

            }

            //Set the exceptions list
            request.setAttribute("uploadErrors", exceptionsList);
            request.setAttribute("uploadSuccess",exceptionsList.size()==0);
            request.getServletContext().getRequestDispatcher("/inventory/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
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
