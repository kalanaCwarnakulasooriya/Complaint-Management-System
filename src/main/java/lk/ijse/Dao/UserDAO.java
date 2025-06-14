package lk.ijse.Dao;

import lk.ijse.Model.User;
import org.apache.commons.dbcp2.BasicDataSource;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

            return pstm.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User validateLogin(String username, String inputPassword) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, username);

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    if (BCrypt.checkpw(inputPassword, hashedPassword)) {
                        User user = new User();
                        user.setUserId(String.valueOf(rs.getInt("user_id")));
                        user.setName(rs.getString("name"));
                        user.setAddress(rs.getString("address"));
                        user.setMobile(rs.getString("mobile"));
                        user.setEmail(rs.getString("email"));
                        user.setUsername(rs.getString("username"));
                        user.setPassword(hashedPassword);
                        user.setDepartment(rs.getString("department"));
                        user.setJobRole(rs.getString("job_role"));
                        return user;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isUsernameTaken(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, username);

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<String> getAllUsernames() {
        List<String> usernames = new ArrayList<>();
        String sql = "SELECT username FROM users";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql);
             ResultSet rs = pstm.executeQuery()) {

            while (rs.next()) {
                usernames.add(rs.getString("username"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usernames;
    }
}