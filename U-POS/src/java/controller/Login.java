package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Security;

public class Login extends HttpServlet {

    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        ServletContext context = config.getServletContext();

        try {
            Class.forName(context.getInitParameter("jdbcClassName"));
            String username = context.getInitParameter("dbUser");
            String password = context.getInitParameter("dbPass");
            StringBuffer url = new StringBuffer(context.getInitParameter("jdbcDriverUrl"))
                    .append("://")
                    .append(context.getInitParameter("dbHost"))
                    .append(":")
                    .append(context.getInitParameter("dbPort"))
                    .append("/")
                    .append(context.getInitParameter("dbName"));
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

        //retrieve key using servlet context and convert to bytes
        String publicKey = getServletContext().getInitParameter("key");
        byte[] key = publicKey.getBytes();
        String ePass = Security.encrypt(request.getParameter("password"), key);

        try {
            String mvc = request.getParameter("login");
            if (mvc == null) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            //for login credentials, using parameterized query
            if (conn != null) {
                String loginquery = "SELECT * FROM EMPLOYEE WHERE EMP_USERNAME = ? AND EMP_PASSWORD = ?";
                PreparedStatement ps = conn.prepareStatement(loginquery);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, ePass);
                ResultSet rs = ps.executeQuery();

                // correct credentials
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("EMP_ID", rs.getString("EMP_ID"));
                    session.setAttribute("EMP_ROLE", rs.getString("EMP_ROLE"));
                    session.setAttribute("EMP_STATUS", rs.getString("EMP_STATUS"));
                    //insert into activity table
                    String actQuery = "INSERT INTO ACTIVITY (ACT_DATETIME, EMP_ID, ACT_TYPE, ACT_DESCRIPTION) VALUES (now(), ? , ?, ?);";
                    PreparedStatement ps1 = conn.prepareStatement(actQuery);
                    ps1.setString(1, rs.getString("EMP_ID"));
                    ps1.setString(2, "Login");
                    ps1.setString(3, rs.getString("EMP_FULLNAME") + " logged in the system");
                    ps1.executeUpdate();

                    request.getRequestDispatcher("loadingScreen.jsp").forward(request, response);
                } else {
                    request.setAttribute("incorrectCreds", true);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
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
