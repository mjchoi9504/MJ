package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.vo.SuggestionVO;

public class SuggestionDAO {
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt =null;
	ResultSet rs = null;
	
	private Connection connectDB() {
		String url = "jdbc:oracle:thin:@70.12.111.134:1521:XE";
		String user = "jdbctest";
		String password = "jdbctest";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");			
			conn = DriverManager.getConnection(url, user, password);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	private void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if(rs!=null) {
				rs.close();
			}			
			if(stmt!=null) {
				stmt.close();
			}
			if(conn!=null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean insert(SuggestionVO vo) {
		boolean result = true;
		connectDB();
		try {
			pstmt = conn.prepareStatement("INSERT INTO suggestions VALUES(suggestions_seq.nextval,?,?,?,?,sysdate,0)");
			pstmt.setString(1, vo.getCon_type());
			pstmt.setString(2, vo.getWriter());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.executeUpdate(); 
		} catch(Exception e) {
			result = false;
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);			
		}
		return result;
	}
	
	public boolean update(SuggestionVO vo) {
		boolean result = true;
		try {
			connectDB();
			pstmt = conn.prepareStatement("UPDATE suggestions SET writer=?, con_type =?, title=?, content =? WHERE id=?");
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getCon_type());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getId());
			pstmt.executeUpdate();
		} catch(Exception e) {
			result=false;
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	public boolean delete(int id) {
		boolean result =true;
		connectDB();
		try {
			pstmt = conn.prepareStatement("DELETE FROM suggestions WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			result = false;
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	public List<SuggestionVO> listAll() {
		ArrayList<SuggestionVO> list = new ArrayList<SuggestionVO>();
		connectDB();
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery("SELECT id, con_type, title, writer, writeDate, cnt, content FROM suggestions ORDER BY id DESC");
			SuggestionVO vo =null;
			while(rs.next()) {
				vo = new SuggestionVO();
				vo.setId(rs.getInt("id"));
				vo.setCon_type(rs.getString("con_type"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setCnt(rs.getInt("cnt"));
				vo.setContent(rs.getString("content"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, stmt, rs);			
		}
		return list;
	}
	
	public SuggestionVO listOne(int id) {
		SuggestionVO vo = new SuggestionVO();
		connectDB();
		try {
			pstmt=conn.prepareStatement("UPDATE suggestions SET cnt = cnt+1 WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement("SELECT con_type, title, writer, content FROM suggestions WHERE id = ?");			
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				vo.setCon_type(rs.getString("con_type"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setContent(rs.getString("content"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);			
		}
		if(vo == null) {
			return null;
		} else {
			return vo;
		}
	}
	
	public List<SuggestionVO> listType(String con_type) {
		ArrayList<SuggestionVO> list = new ArrayList<SuggestionVO>();
		connectDB();
		try {
			pstmt = conn.prepareStatement("SELECT id, con_type, title, writer, writeDate, cnt FROM suggestions WHERE con_type =? ORDER BY id DESC");
			pstmt.setString(1, con_type);
			rs = pstmt.executeQuery();
			SuggestionVO vo = null;
			while(rs.next()) {
				vo = new SuggestionVO();
				vo.setId(rs.getInt("id"));
				vo.setCon_type(rs.getString("con_type"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setCnt(rs.getInt("cnt"));
				list.add(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	public List<SuggestionVO> search(String key, String searchType){
		ArrayList<SuggestionVO> list = new ArrayList<SuggestionVO>();
		connectDB();
		try {
			if(searchType.equals("title")) {
				pstmt = conn.prepareStatement("SELECT id, con_type, title, writer, writeDate, cnt FROM suggestions WHERE title LIKE ?");				
			} else if(searchType.equals("content")) {
				pstmt = conn.prepareStatement("SELECT id, con_type, title, writer, writeDate, cnt FROM suggestions WHERE content LIKE ?");
			}
			pstmt.setString(1, "%"+ key +"%");
			rs = pstmt.executeQuery();
			SuggestionVO vo = null;
			while(rs.next()) {
				vo = new SuggestionVO();
				vo.setId(rs.getInt("id"));
				vo.setCon_type(rs.getString("con_type"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setCnt(rs.getInt("cnt"));
				list.add(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
}
