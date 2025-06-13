package lk.ijse.Util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import org.apache.commons.dbcp2.BasicDataSource;

public class DBCPDataSource implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("DBCPDataSource initialized");
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/CMS");
        dataSource.setUsername("root");
        dataSource.setPassword("Ijse@1234");
        dataSource.setInitialSize(5);
        dataSource.setMaxTotal(100);

        ServletContext context = sce.getServletContext();
        context.setAttribute("dbcpDataSource", dataSource);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("DBCPDataSource destroyed");
        ServletContext context = sce.getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("dbcpDataSource");
        if (dataSource != null) {
            try {
                dataSource.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
