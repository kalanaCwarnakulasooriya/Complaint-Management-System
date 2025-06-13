package lk.ijse.Dao;

import lk.ijse.Model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDAO {
    private final BasicDataSource dataSource;

    public UserDAO(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public boolean saveUser(User user) {
        String sql = "INSERT INTO users (name, address, mobile, email, username, password, department, job_role)"
                + " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, user.getName());
            pstm.setString(2, user.getAddress());
            pstm.setString(3, user.getMobile());
            pstm.setString(4, user.getEmail());
            pstm.setString(5, user.getUsername());
            pstm.setString(6, user.getPassword());
            pstm.setString(7, user.getDepartment());
            pstm.setString(8, user.getJobRole());

            int result = pstm.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
