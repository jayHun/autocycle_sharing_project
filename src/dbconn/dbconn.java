package dbconn;

import java.sql.*;



public class dbconn {

   //1. �����ͺ��̽� ���� ����
   public static Connection getConn()
         throws ClassNotFoundException, SQLException {
	  
	  Connection conn = null; //Connection(�����ͺ��̽� ����) ��ü ����� ���� ����
	  System.setProperty("javax.net.ssl.trustStore","/home/project/truststore");
	  System.setProperty("javax.net.ssl.trustStorePassword", "somepass");
	  
	  String user="admin";
	  String password="CQJZHPHVUBTYNAID";
	  String URL = "jdbc:mysql://sl-aus-syd-1-portal.3.dblayer.com:16065/compose";
	  
      try{
         if (conn == null) {
        	Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(URL, user, password);
         }
      }
      
      catch(Exception e){
         System.out.println(e);
      }
      
      return conn;
   }
}