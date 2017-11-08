package temp;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/start")

public class StartRidingServlet extends HttpServlet {
	//오토바이 선택해서 출발할때 servlet
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		long curTime = System.currentTimeMillis();
		HttpSession session = request.getSession();
		String userId= (String)session.getAttribute("LOGIN_USER");
		String bikeId=request.getParameter("BIKEID");
		String startLocLat= request.getParameter("LATITUDE");   //선택한 오토바이의 위치입니다
		String startLocLng= request.getParameter("LONGITUDE");
		
		
		
		RideInfoBean bean= new RideInfoBean();
		bean.setUserId(userId);
		bean.setStartLocLat(startLocLat);		//navigation때 시작 marker위치 및 추후에 db에 저장하기 위해 bean에저장
		bean.setStartLocLng(startLocLng);
		bean.setStartTime(curTime);
		bean.setBikeId(bikeId);
		
	
		request.setAttribute("RIDE_INFO", bean);
		session.setAttribute("RIDE_INFO", bean);
		
		
		RequestDispatcher disp= request.getRequestDispatcher("NavigationView.jsp");
		disp.forward(request, response);
	}
}
