package dbconn;
import temp.*;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

@WebServlet("/loginDAO")
public class loginDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public loginDAO() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PreparedStatement psmt = null;
		Connection conn = null;
		
		String userId = request.getParameter("ID");
		String passwd = request.getParameter("PW");
		int flag=0;
		try{
			
			conn=dbconn.getConn();
			String sql = String.format("select id, name from member where id='"+userId+"' and passwd='"+passwd+"';");
			psmt = conn.prepareStatement(sql);
			
			ResultSet rs = psmt.executeQuery();
			String name=null;
			while(rs.next()){
				name=rs.getString("name");
				flag++;
			}
			
			int cnt=0;
			Statement state=null;
			rs=null;
			BikeBean bean= new BikeBean();
			
			state= conn.createStatement();
			rs= state.executeQuery("select * from pos");
			
			while((rs.next())){
				String bikeId= rs.getString("bikeid");
				String latitude = rs.getString("latitude");
				String longitude = rs.getString("longitude");
				
				bean.setBikeId(cnt, bikeId);
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
			
			if(flag!=0){
				HttpSession session=request.getSession();
				session.setAttribute("LOGIN_USER", userId);
				session.setAttribute("NAME", name);
				
				request.setAttribute("BIKE_INFO", bean);
				request.setAttribute("USER_LOG", logbean);
				RequestDispatcher disp= request.getRequestDispatcher("index.jsp"); //주변오토바이 보여주는 jsp
				disp.forward(request, response);
			}
			else{
				System.out.println("아이디와 비밀번호를 확인하세요.");
				rs.close();
				conn.close();
				response.sendRedirect("loginFAIL.jsp");
				// 세션 초기화 필요??
			}
		}catch(ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}finally{
			try{psmt.close(); }catch(Exception ignored){}
			try{conn.close(); }catch(Exception ignored){}
		}
	}
}
