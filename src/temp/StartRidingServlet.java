package temp;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/start")

public class StartRidingServlet extends HttpServlet {
	//������� �����ؼ� ����Ҷ� servlet
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		long curTime = System.currentTimeMillis();
		HttpSession session = request.getSession();
		String userId= (String)session.getAttribute("LOGIN_USER");
		String bikeId=request.getParameter("BIKEID");
		String startLocLat= request.getParameter("LATITUDE");   //������ ��������� ��ġ�Դϴ�
		String startLocLng= request.getParameter("LONGITUDE");
		
		
		
		RideInfoBean bean= new RideInfoBean();
		bean.setUserId(userId);
		bean.setStartLocLat(startLocLat);		//navigation�� ���� marker��ġ �� ���Ŀ� db�� �����ϱ� ���� bean������
		bean.setStartLocLng(startLocLng);
		bean.setStartTime(curTime);
		bean.setBikeId(bikeId);
		
	
		request.setAttribute("RIDE_INFO", bean);
		session.setAttribute("RIDE_INFO", bean);
		
		
		RequestDispatcher disp= request.getRequestDispatcher("NavigationView.jsp");
		disp.forward(request, response);
	}
}
