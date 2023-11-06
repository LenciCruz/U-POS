/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author Lenci
 */
public class Inventory extends HttpServlet {

    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        ServletContext context = config.getServletContext();

        try {
            Class.forName(context.getInitParameter("jdbcClassName"));
            String username = context.getInitParameter("dbUser");
            String password = context.getInitParameter("dbPass");
            StringBuffer url = new StringBuffer(context.getInitParameter("jdbcDriverUrl")).append("://").append(context.getInitParameter("dbHost")).append(":").append(context.getInitParameter("dbPort")).append("/").append(context.getInitParameter("dbName"));
            conn = DriverManager.getConnection(url.toString(), username, password);
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - " + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - " + nfe.getMessage());
        }
    }

    @Override
    public void destroy() {
        super.destroy(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        try {
            conn.close();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession();
        String accid = (String) session.getAttribute("ACC_ID");
        String category = request.getParameter("category");
       // String search = request.getParameter("searchBar");
        String mvc = request.getParameter("filter");

        String query = "select * from accounts where acc_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, accid);
        ResultSet name = ps.executeQuery();
        request.setAttribute("username", name);

        if (accid == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // list all category types
            Statement stmt = conn.createStatement();
            ResultSet categories = stmt.executeQuery("select distinct prod_category from product");
            request.setAttribute("categories", categories);

            //checks if user selects a filter
            if (mvc == null) {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM PRODUCT");
                request.setAttribute("inventoryTable", rs);
                request.getRequestDispatcher("inventory.jsp").forward(request, response);
            } else {
                if (category.equals("all")) {
                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM PRODUCT");
                    ResultSet rs = ps1.executeQuery();
                    request.setAttribute("inventoryTable", rs);
                    request.getRequestDispatcher("inventory.jsp").forward(request, response);
                } else {
                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM PRODUCT where prod_category=? ");
                    ps1.setString(1, category);
                    ResultSet rs = ps1.executeQuery();
                    request.setAttribute("inventoryTable", rs);
                    request.getRequestDispatcher("inventory.jsp").forward(request, response);
                }

//                if (search.length() > 0) {
//                    PreparedStatement ps1 = conn.prepareStatement("select * from product where prod_name=?");
//                    ps1.setString(1, search);
//                    ResultSet rs = ps1.executeQuery();
//                    request.setAttribute("inventoryTable", rs);
//                    request.getRequestDispatcher("inventory.jsp").forward(request, response);
//                }
            }

        }
    }

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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Inventory.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Inventory.class.getName()).log(Level.SEVERE, null, ex);
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
