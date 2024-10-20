package mvcIntelliJIdea.dbHelper;

import mvcIntelliJIdea.model.Student;

import java.sql.*;

public class AddQuery {
    private Statement stmt;
    private ResultSet result;
    private Connection con;

    public AddQuery() { connect(); }

    private void connect() {
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            stmt = con.createStatement();
        } catch (Exception ex) {
            System.out.println("Connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public void doAdd(Student student) {
        String query = "INSERT INTO students (name, grade)  VALUES (?, ?)";
        PreparedStatement ps;
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, student.getName());
            ps.setInt(2, student.getGrade());

            //As long as we modify the DB, we shall use executeUpdate()
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
