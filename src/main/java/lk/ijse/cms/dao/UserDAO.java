package lk.ijse.cms.dao;

import jakarta.servlet.ServletContext;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDAO {
    public static Boolean addUser(ServletContext context, String sql, Object... obj) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i + 1, obj[i]);
        }
        int rowsAffected = preparedStatement.executeUpdate();
        connection.close();
        return rowsAffected > 0;
    }
}
