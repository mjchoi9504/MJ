package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.vo.NewsVO;

public class NewsDAO {
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt =null;
	ResultSet rs = null;
	// 로딩
	private Connection connectDB() {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
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
	// close
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
	// 1. insert
	public boolean insert(NewsVO vo) {
		boolean result = true;
		connectDB();
		try {
			pstmt = conn.prepareStatement("INSERT INTO news VALUES(visitor_seq.nextval,?,?,?,sysdate,0)");
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.executeUpdate(); 
		} catch(Exception e) {
			result = false;
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);			
		}
		return result;
	}
	// 2. update
	public boolean update(NewsVO vo) {
		boolean result = true;
		try {
			connectDB();
			pstmt = conn.prepareStatement("UPDATE news SET writer=?, title=?, content =? WHERE id=?");
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setInt(4, vo.getId());
			pstmt.executeUpdate();
		} catch(Exception e) {
			result=false;
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	// 3. delete
	public boolean delete(int id) {
		boolean result =true;
		connectDB();
		try {
			pstmt = conn.prepareStatement("DELETE FROM news WHERE id = ?");
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
	// 4. list
	public List<NewsVO> listAll() {
		ArrayList<NewsVO> list = new ArrayList<NewsVO>();
		connectDB();
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery("SELECT id, title, writer, writeDate, cnt, content FROM news ORDER BY id DESC");
			NewsVO vo =null;
			while(rs.next()) {
				vo = new NewsVO();
				vo.setId(rs.getInt("id"));
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
	// 5. 조회수
	public NewsVO listOne(int id) {
		NewsVO vo = new NewsVO();
		connectDB();
		try {
			pstmt=conn.prepareStatement("UPDATE news SET cnt = cnt+1 WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement("SELECT title, writer, content FROM news WHERE id = ?");			
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
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
	// 특정 작성자
	public List<NewsVO> listWriter(String writer) {
		ArrayList<NewsVO> list = new ArrayList<NewsVO>();
		connectDB();
		try {
			pstmt = conn.prepareStatement("SELECT id, title, writer, writeDate, cnt FROM news WHERE writer =? ORDER BY id DESC");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			NewsVO vo = null;
			while(rs.next()) {
				vo = new NewsVO();
				vo.setId(rs.getInt("id"));
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
	// 검색 ( 내용, 제목 )
	public List<NewsVO> search(String key, String searchType){
		ArrayList<NewsVO> list = new ArrayList<NewsVO>();
		connectDB();
		try {
			if(searchType.equals("title")) {
				pstmt = conn.prepareStatement("SELECT id, title, writer, writeDate, cnt FROM news WHERE title LIKE ?");				
			} else if(searchType.equals("content")) {
				pstmt = conn.prepareStatement("SELECT id, title, writer, writeDate, cnt FROM news WHERE content LIKE ?");
			}
			pstmt.setString(1, "%"+ key +"%");
			rs = pstmt.executeQuery();
			NewsVO vo = null;
			while(rs.next()) {
				vo = new NewsVO();
				vo.setId(rs.getInt("id"));
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
