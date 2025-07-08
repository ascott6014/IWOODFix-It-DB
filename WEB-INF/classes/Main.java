import java.sql.*;


public class Main {
    public static void main(String[] args) {
        String password = System.getenv("DB_PASSWORD");
        String url = System.getenv("URL");
        String user = System.getenv("USER");
        System.out.println(password + "\n" + url + "\n" + user);

        // String url = "jdbc:mysql://localhost:3306/SampleDB";
        // String user = "root";
        // String password = "your_password";  // Change this

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes)" +
                                "VALUES " +
                                "('John', 'Doe', '123 Elm St', 'Memphis', 'TN', '38101', '901-555-1234', 'john.doe@example.com', ''), " +
                                "('Jane', 'Smith', '456 Oak Ave', 'Marion', 'AR', '72364', '870-555-5678', 'jane.smith@example.com', 'VIP Client'), " +
                                "('Alice', 'Walker', '78 Pine St', 'West Memphis', 'AR', '72301', '870-555-1001', 'alice@example.com', 'Prefers weekend service'), " +
                                "('Brian', 'Nguyen', '920 Lakeshore Blvd', 'Memphis', 'TN', '38103', '901-555-2222', 'brian.nguyen@example.com', ''), " +
                                "('Carla', 'Lopez', '421 Maple Ave', 'Marion', 'AR', '72364', '870-555-3003', 'carla@example.com', 'Requires bilingual technician');");
            ResultSet rs = stmt.executeQuery("SELECT * FROM customers");

            while (rs.next()) {
                System.out.println(rs.getInt("customer_id") + ": " +
                                   rs.getString("last_name") + " - " +
                                   rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

