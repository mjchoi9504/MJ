package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.vo.JoinVO;
public class JoinDAO {
	// 멤버변수
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;

	// JDBC 드라이버 로딩 
	private Connection connectDB() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "jdbctest", "jdbctest");
			stmt = conn.createStatement();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	// DB서버와 접속 해제 
	private void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if(conn != null)
				conn.close();
			if(stmt != null)
				stmt.close();
			if(rs != null)
				rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	// All List
	public ArrayList<JoinVO> listAll() {
		ArrayList<JoinVO> list = new ArrayList<>();
		conn = connectDB();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT name,id,password,gender,ages,phonenum,emil FROM signup");
			JoinVO vo = null;
			while (rs.next()) {
				vo = new JoinVO();
				vo.setName(rs.getString("name"));
				vo.setId(rs.getString("id"));
				vo.setPassword(rs.getString("password"));
				vo.setGender(rs.getString("gender"));
				vo.setAges(rs.getString("ages"));
				vo.setPhonenum(rs.getString("phonenum"));
				vo.setEmail(rs.getString("email"));
				list.add(vo);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(conn,stmt,rs);	
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	// insert
	public boolean insert(JoinVO vo) {
		boolean result = true;
		conn = connectDB();
		try {
			pstmt = conn.prepareStatement("INSERT INTO signup VALUES(?, ?, ?, ?, ?, ?, ?)");	
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPassword());
			pstmt.setString(4, vo.getGender());
			pstmt.setString(5, vo.getAges());
			pstmt.setString(6, vo.getPhonenum());
			pstmt.setString(7, vo.getEmail());
			pstmt.executeUpdate();

			} catch (Exception e) {
			result = false;
			e.printStackTrace();
		}  finally {
			try {			
				if(pstmt != null)
					pstmt.close();
				close(conn,stmt,null);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	
	public boolean check(String id, String password) {
		boolean result=true;
		conn = connectDB();
		try {
			pstmt = conn.prepareStatement("SELECT id,password FROM signup WHERE id=? and password=?");
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			
			if (!rs.next()) {
				result=false;
			}
			
		} catch (Exception e) {
			result=false;
			e.printStackTrace();
		} finally {
			try {			
				if(pstmt != null)
					pstmt.close();
				close(conn,stmt,null);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
