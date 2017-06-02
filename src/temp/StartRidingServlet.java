package temp;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class StartRidingServlet extends HttpServlet {
	//������� �����ؼ� ����Ҷ� servlet
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		long curTime = System.currentTimeMillis();
		String startLocLat= request.getParameter("LATITUDE");   //������ ��������� ��ġ�Դϴ�
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
