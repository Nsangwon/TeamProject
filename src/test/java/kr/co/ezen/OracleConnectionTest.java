package kr.co.ezen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

public class OracleConnectionTest {
	
	 private final String DRIVER = "orcle.jdbc.OracleDriver";
	 private final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	 private final String USERNAME = "ezen200";
	 private final String PASSWORD = "ezen200";
	 
	 @Test
	 public void testConnection() {
		 try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
		 Connection conn = null;
		 
		 
		 try {
			 conn = DriverManager.getConnection(URL,USERNAME,PASSWORD);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		 
		 
		 
	 }

}
