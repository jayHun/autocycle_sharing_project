package dbconn;

import java.sql.*;

public class dbconn {

   //1. �����ͺ��̽� ���� ����
   public static Connection getConn() 
         throws ClassNotFoundException, SQLException {
	   
	  Connection conn = null; //Connection(�����ͺ��̽� ����) ��ü ����� ���� ����
	   
      try{
         if (conn == null) {
   
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
   
            conn = DriverManager.getConnection(url,"web","web");
         }
      }
      
      catch(Exception e){
         System.out.println(e);
      }
      
      return conn;
   }
}