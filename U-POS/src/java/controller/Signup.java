package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Security;

/**
 *
 * @author Lenci
 */
public class Signup extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //retrieve key using servlet context and convert to bytes
            String publicKey = getServletContext().getInitParameter("key");
            byte[] key = publicKey.getBytes();

            //check if user clicks add account
            String mvc = request.getParameter("add");
            if (mvc == null) {
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            } else {
                String username = request.getParameter("username");
                String fullname = request.getParameter("fullname");
                String ePass = Security.encrypt(request.getParameter("password"), key);
                String role = request.getParameter("user-role-radio");
                String question = request.getParameter("sec-qs");
                String answer = request.getParameter("answer");

                Statement st = conn.createStatement();
                ResultSet duplicates = st.executeQuery("SELECT * FROM employee where EMP_USERNAME='" + username + "'");

                String query = "INSERT INTO employee (EMP_USERNAME, EMP_FULLNAME, EMP_PASSWORD, EMP_ROLE, EMP_STATUS, EMP_QUESTION, EMP_ANSWER) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, fullname);
                pstmt.setString(3, ePass);
                pstmt.setString(4, role);
                pstmt.setString(5, "deactivated");
                pstmt.setString(6, question);
                pstmt.setString(7, answer);

                //checks if account already exists
                if (duplicates.next()) {
                    request.setAttribute("duplicate", true);
                    request.getRequestDispatcher("Login").forward(request, response);

                } else {
                    pstmt.executeUpdate();
                    request.setAttribute("addedAccount", true);
                    request.getRequestDispatcher("Login").forward(request, response);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
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
        processRequest(request, response);
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
        processRequest(request, response);
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
