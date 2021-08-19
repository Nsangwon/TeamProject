package kr.co.ezen;

import java.sql.Connection;
import java.sql.SQLException;


import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class DataSourceTest {
   
   @Autowired
   private DataSource dataFactory;
   
   @Test
   public void testConnection() {
      Connection conn = null;
      
      try {
         conn = dataFactory.getConnection();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if (conn != null) {
            try {
               conn.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         }
      }
   }

}
