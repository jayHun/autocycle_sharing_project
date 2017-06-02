package temp;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class StartRidingServlet extends HttpServlet {
	//오토바이 선택해서 출발할때 servlet
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		long curTime = System.currentTimeMillis();
		String startLocLat= request.getParameter("LATITUDE");   //선택한 오토바이의 위치입니다
		String startLocLng= request.getParameter("LONGITUDE");
		RideInfoBean bean= new RideInfoBean();
		bean.setStartLocLat(startLocLat);
		bean.setStartLocLng(startLocLng);
		bean.setStartTime(curTime);             
		
		request.setAttribute("RIDE_INFO", bean);   
		
		HttpSession session = request.getSession();
		session.setAttribute("RIDE_INFO", bean);
		
		
		RequestDispatcher disp= request.getRequestDispatcher("NavigationView.jsp");
		disp.forward(request, response);
	}
}
