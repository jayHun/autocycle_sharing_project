package dbconn;

import java.sql.*;

public class dbconn {

   //1. 데이터베이스 연결 과정
   public static Connection getConn() 
         throws ClassNotFoundException, SQLException {
	   
	  Connection conn = null; //Connection(데이터베이스 연결) 객체 저장용 변수 선언
	   
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