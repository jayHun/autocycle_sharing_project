package signup;

import java.sql.*;
import signup.SignupDTO;
import dbconn.*;

public class SignupDAO {
	
	private static SignupDAO instance = new SignupDAO();
	
	public static SignupDAO getInstance(){return instance;}
	
	
	// 회원 가입 함수
	public int insertMember(SignupDTO signupdto) throws ClassNotFoundException, SQLException
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		int result=0;
		String sql="";

		try{
			conn=dbconn.getConn();
			sql = "INSERT INTO MEMBER(ID, PASSWD, NAME, HP, BIRTH) VALUES(?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, signupdto.getId());
			pstmt.setString(2, signupdto.getPasswd());
			pstmt.setString(3, signupdto.getName());
			pstmt.setString(4, signupdto.getHp());
			pstmt.setString(5, signupdto.getBirth());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e + "=> memberInsert fail");
		}finally{
			if(pstmt != null)
				try{pstmt.close();} catch(SQLException ex){}
			if(conn != null)
				try{conn.close();} catch(SQLException ex){}
		}
		return result;
	}
	
	
	// 회원 탈퇴 함수
	public int deleteMember(String id, String passwd) throws ClassNotFoundException, SQLException
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String dbpasswd = "";
		int x = -1;
		
		try{
			conn = dbconn.getConn();
			pstmt = conn.prepareStatement("select passwd from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				dbpasswd = rs.getString("passwd");
				
				if(dbpasswd.equals(passwd))
				{
					pstmt = conn.prepareStatement("delete from member where id = ?");
					
					pstmt.setString(1, id);
					pstmt.executeQuery();
					
					x = 1;
					if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
				}
				else
					x = 0;
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(rs != null) try{rs.close();} catch(SQLException ex){}
			if(conn != null) try{conn.close();} catch(SQLException ex){}
		}
		return x;
	}
	
	
	// 아이디 중복체크 함수
	public int confirmId(String id)throws Exception
	{
		int x=-1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		
		try{
			conn = dbconn.getConn();
			sql = "select id from MEMBER where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				x=1;
			else
				x=-1;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally {
			if(rs != null) try{rs.close();} catch(SQLException ex){}
			if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
			if(conn != null) try{conn.close();} catch(SQLException ex){}
		}
		return x;
	}
}