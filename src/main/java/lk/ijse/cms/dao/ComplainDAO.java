package lk.ijse.cms.dao;

import jakarta.servlet.ServletContext;
import lk.ijse.cms.model.Complain;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ComplainDAO {
    public static List<Complain> getComplains(ServletContext context, String sql, Object... obj) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i + 1, obj[i]);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Complain> complaintList = new java.util.ArrayList<>();
        while (resultSet.next()) {
            Complain complain = new Complain(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getString("status"),
                    resultSet.getString("remarks"),
                    resultSet.getString("created_at"),
                    resultSet.getString("user_id")
            );
            complaintList.add(complain);
        }
        connection.close();
        return complaintList;
    }

    public static int updateAddDeleteComplaint(ServletContext context, String sql, Object... obj) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i + 1, obj[i]);
        }
        int rowsAffected = preparedStatement.executeUpdate();
        connection.close();
        return rowsAffected;
    }

    public static Complain findByID(ServletContext context, String sql, int id) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        Complain complain = null;
        if (resultSet.next()) {
            complain = new Complain(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getString("status"),
                    resultSet.getString("remarks"),
                    resultSet.getString("created_at"),
                    resultSet.getString("user_id")
            );
        }
        connection.close();
        return complain;
    }
}
