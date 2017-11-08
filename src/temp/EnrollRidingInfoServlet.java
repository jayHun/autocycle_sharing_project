package temp;
import dbconn.dbconn;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
@SuppressWarnings("serial")
@WebServlet("/enddrive")

public class EnrollRidingInfoServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String endLocLat = request.getParameter("LAT");
		String endLocLng = request.getParameter("LNG");
		String distance = request.getParameter("DISTANCE");
		long endTime = System.currentTimeMillis();
		
		HttpSession session = request.getSession();
		RideInfoBean bean= (RideInfoBean)session.getAttribute("RIDE_INFO");
		bean.setEndLocLat(endLocLat);
		bean.setEndLocLng(endLocLng);
		bean.setEndTime(endTime);
		bean.setDistance(distance);
		long startTime= bean.getStartTime();
		long usingTime = (endTime-startTime)/1000;
		bikeEndPointDbWrite(bean.getBikeId(),bean.getEndLocLat(),bean.getEndLocLng());

		
		
		bean.setUsingTime(usingTime);
		
		rideInfoDbWrite(bean);	// db에 저장
		int initPrice=2000;  //기본요금
		int price = initPrice+((int)usingTime)*500;   //시간당 2천원추가 price를 double형으로 한번 바꾸어보기
		bean.setPrice(price);
		
		RideInfoBean newBean= new RideInfoBean();
		newBean.setUsingTime(usingTime);
		newBean.setDistance(distance);
		newBean.setPrice(price);
		
		request.setAttribute("RIDE_INFO", newBean);
		RequestDispatcher dispatcher= request.getRequestDispatcher("PriceView.jsp");
		dispatcher.forward(request, response);
		
	}
	private void rideInfoDbWrite(RideInfoBean bean){
		Connection conn=null;
		Statement state= null;
		try{
			conn= dbconn.getConn();
			state=conn.createStatement(); 		//아래와 같은 db테이블하나 만들어야 할 것 같습니다ㅎㅎ 
			state.executeUpdate("insert into ride_info values('"+bean.getUserid()+"','"+bean.getBikeId()+"','"+bean.getStartLocLat()+"','"+bean.getStartLocLng()+"','"
												+bean.getEndLocLat()+"','"+bean.getEndLocLng()+"',"+bean.getStartTime()+","+bean.getEndTime()+","+bean.getUsingTime()+","+bean.getDistance()+")");
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			try{
				state.close();
			}catch(Exception ignored){
				
			}try{
				conn.close();
			}catch(Exception ignored){
				
			}
		}
	}
	private void bikeEndPointDbWrite(String bikeId, String endLocLat, String endLocLng){
		Connection conn=null;
		Statement state= null;
		try{
			conn= dbconn.getConn();
			state=conn.createStatement();
			state.executeUpdate("update pos set latitude='"+endLocLat+"',longitude='"+endLocLng+"' where bikeid='"+bikeId+"'");
		}catch(Exception e){
			
		}finally{
			try{
				state.close();
				conn.close();
			}catch(Exception ignored){
				
			}
		}
	}
}