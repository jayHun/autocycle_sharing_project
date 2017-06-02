package dbconn;

import java.io.IOException;
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
		Connection conn = null;
		PreparedStatement psmt = null;
		
		String userId = request.getParameter("ID");
		String passwd = request.getParameter("PW");
		int flag=0;
		try{
			conn=dbconn.getConn();
			String sql = String.format("SELECT id, name from MEMBER WHERE ID='"+userId+"' AND PASSWD='"+passwd+"'");
			psmt = conn.prepareStatement(sql);
			
			ResultSet rs = psmt.executeQuery();
			String name=null;
			while(rs.next()){
				name=rs.getString("name");
				flag++;
			}
			if(flag!=0){
				HttpSession session=request.getSession();
				session.setAttribute("ID", userId);
				session.setAttribute("NAME", name);
				response.sendRedirect("index.jsp");
			}
			else{
				System.out.println("아이디와 비밀번호를 확인하세요.");
				rs.close();
				conn.close();
				response.sendRedirect("loginFAIL.jsp");
			}
		}catch(ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}finally{
			try{psmt.close(); }catch(Exception ignored){}
			try{conn.close(); }catch(Exception ignored){}
		}
	}
}
