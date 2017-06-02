package temp;
import dbconn.*;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
@SuppressWarnings("serial")


public class EnrollRidingInfoServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String endLocLat = request.getParameter("LAT");
		String endLocLng = request.getParameter("LNG");
		long endTime = System.currentTimeMillis();
		
		HttpSession session = request.getSession();
		RideInfoBean bean= (RideInfoBean)session.getAttribute("RIDE_INFO");
		String userId= (String)session.getAttribute("LOGIN_USER");
		bean.setUserId(userId);
		bean.setEndLocLat(endLocLat);
		bean.setEndLocLng(endLocLng);
		bean.setEndTime(endTime);
		long startTime= bean.getStartTime();
		long usingTime = (endTime-startTime)/1000;
		bean.setUsingTime(usingTime);
		
		dbWrite(bean);
		int initPrice=2000;  //기본요금
		int price = initPrice+((int)usingTime/3600)*2000;   //시간당 2천원추가
		
		request.setAttribute("PRICE", price);
		RequestDispatcher dispatcher= request.getRequestDispatcher("PriceView.jsp");
		dispatcher.forward(request, response);
		
	}
	private void dbWrite(RideInfoBean bean){
		Connection conn=null;
		Statement state= null;
		try{
			conn= dbconn.getConn();
			state=conn.createStatement(); 		//아래와 같은 db테이블하나 만들어야 할 것 같습니다ㅎㅎ 
			state.executeUpdate("insert into ride_info values('"+bean.getUserid()+"','"+bean.getStartLocLat()+"','"+bean.getStartLocLng()+"','"
												+bean.getEndLocLat()+"','"+bean.getEndLocLng()+"',"+bean.getStartTime()+","+bean.getEndTime()+","+bean.getUsingTime()+")");
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
}