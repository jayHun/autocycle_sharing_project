package temp;
import dbconn.*;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
@SuppressWarnings("serial")

public class SearchBikeServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
								throws IOException,ServletException{
	String curLat= request.getParameter("LATITUDE"); //���� ��ġ �޾ƿ���  -> �� ������ ȣ���ϴ� jsp�� �ڹٽ�ũ��Ʈ�� �ƿ� ������ġ ���ȭ���ѳ��� ���޸��ϸ� �˴ϴ�  �׷��Ծ��ϰ� ������� ã�� 
													 //ȭ�鿡�� �ص� ����� ���� �� �����ؿ�
	String curLng= request.getParameter("LONGITUDE");
	
	BikeBean bean = readDb();
	setCurLocation(curLat, curLng, bean);
	
	//���� ��ġ�� �ֺ� ������� ���� jsp(������ġ�� �ֺ���ġ �����ִ� view)�� ���� 
	request.setAttribute("BIKE_INFO", bean);
	RequestDispatcher disp= request.getRequestDispatcher("BikeView.jsp");
	disp.forward(request, response);
	
}   
	
	private void setCurLocation(String curLat, String curLng,BikeBean bean){
		bean.setCurLocationLat(curLat);
		bean.setCurLocationLng(curLng);
	}
	private BikeBean readDb(){ //�̸� �����ص� �ֺ� ������� ��ǥ �ҷ����� �޼���
		int cnt=0;
		Connection conn=null;
		Statement state=null;
		ResultSet rs=null;
		BikeBean bean= new BikeBean();
		
		try{
		conn=dbconn.getConn();
		state= conn.createStatement();
		rs= state.executeQuery("select * from pos");
		while((rs.next())){
			String bikeId= rs.getString("BIKEID");
			String latitude = rs.getString("LAT");
			String longitude = rs.getString("LONGITUDE");
			
			bean.setBikeId(cnt, bikeId);
			bean.setLatitude(cnt, latitude);
			bean.setLongitude(cnt, longitude);
		}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
			}
			catch(Exception ignored){
				
			}
			try{
				state.close();
			}catch(Exception ignored){
				
			}try{
				conn.close();
			}catch(Exception ignored){
				
			}
		}
		return bean;
	}
}

