package lk.ijse.cms.db;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

@WebListener
public class DataSource implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/CMS");
        ds.setUsername("root");
        ds.setPassword("Ijse@1234");
        ds.setInitialSize(10);
        ds.setMaxTotal(10);

        ServletContext sc = sce.getServletContext();
        sc.setAttribute("ds", ds);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            ServletContext sc = sce.getServletContext();
            BasicDataSource ds = (BasicDataSource) sc.getAttribute("ds");
            ds.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
