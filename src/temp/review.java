package temp;

import dbconn.dbconn;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;


/**
 * Servlet implementation class review
 */
@WebServlet("/review")
public class review extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public review() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int cnt=0;
		String userId = request.getParameter("LOGIN_USER");
		Connection conn = null;
		Statement state = null;
		ResultSet rs = null;
		
		try{
			conn = dbconn.getConn();
			BikeBean bean= new BikeBean();
			
			state= conn.createStatement();
			rs= state.executeQuery("select * from pos");
			
			while(rs.next()){
				String bikeid = rs.getString("bikeid");
				String latitude = rs.getString("latitude");
				String longitude = rs.getString("longitude");
				
				bean.setBikeId(cnt, bikeid);
				bean.setLatitude(cnt, latitude);
				bean.setLongitude(cnt, longitude);
			}
			
			state=null;
			rs=null;
			LogBean logbean = new LogBean();
			
			state= conn.createStatement();
			rs= state.executeQuery("select sum(usingtime) sumusing, count(*) counter from ride_info where id='"+userId+"';");
			
			if(rs.next()){
				String sumusing= rs.getString("sumusing");
				String counter = rs.getString("counter");
				
				logbean.setSum(sumusing);
				logbean.setCounter(counter);
			}
			
			HttpSession session=request.getSession();
			session.setAttribute("LOGIN_UESR", userId);
			
			request.setAttribute("BIKE_INFO", bean);
			request.setAttribute("USER_LOG", logbean);
			RequestDispatcher disp = request.getRequestDispatcher("index.jsp");
			disp.forward(request, response);
			
			rs.close();
			state.close();
			
		}catch(ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}finally{
			try{conn.close(); }catch(Exception ignored){}
		}
	}

}
