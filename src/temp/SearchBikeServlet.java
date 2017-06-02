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
	String curLat= request.getParameter("LATITUDE"); //현재 위치 받아오기  -> 이 서블릿을 호출하는 jsp의 자바스크립트에 아예 현재위치 상수화시켜놓고 전달만하면 됩니다  그렇게안하고 오토바이 찾는 
													 //화면에서 해도 상관은 없을 것 같긴해요
	String curLng= request.getParameter("LONGITUDE");
	
	BikeBean bean = readDb();
	setCurLocation(curLat, curLng, bean);
	
	//현재 위치와 주변 오토바이 정보 jsp(현재위치와 주변위치 보여주는 view)에 전달 
	request.setAttribute("BIKE_INFO", bean);
	RequestDispatcher disp= request.getRequestDispatcher("BikeView.jsp");
	disp.forward(request, response);
	
}   
	
	private void setCurLocation(String curLat, String curLng,BikeBean bean){
		bean.setCurLocationLat(curLat);
		bean.setCurLocationLng(curLng);
	}
	private BikeBean readDb(){ //미리 저장해둔 주변 오토바이 좌표 불러오는 메서드
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

