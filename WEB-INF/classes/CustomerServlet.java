import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String first = request.getParameter("first_name");
        String last = request.getParameter("last_name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String notes = request.getParameter("notes");

        String dbUrl = System.getenv("URL");
        String user = System.getenv("USER");
        String password = System.getenv("DB_PASSWORD");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection conn = DriverManager.getConnection(dbUrl, user, password)) {
            String sql = "INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, first);
            stmt.setString(2, last);
            stmt.setString(3, address);
            stmt.setString(4, city);
            stmt.setString(5, state);
            stmt.setString(6, zip);
            stmt.setString(7, phone);
            stmt.setString(8, email);
            stmt.setString(9, notes);
            stmt.executeUpdate();

            out.println("<h3>Customer Added Successfully!</h3>");
        } catch (SQLException e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
