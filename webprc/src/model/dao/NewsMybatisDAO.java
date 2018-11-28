package model.dao;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import model.vo.NewsVO;

public class NewsMybatisDAO {
	// 1. list
	public List<NewsVO> listAll() {
		System.out.println("AllList - Myvatis를 사용 DB 연동");
		List<NewsVO> list = null;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession();
			String statement = "resource.NewsMapper.selectNews";
			list = session.selectList(statement);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}

	// 2. insert
	public boolean insert(NewsVO news) {
		System.out.println("insert - Myvatis를 사용 DB 연동");
		boolean result = false;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession(true);
			String statement = "resource.NewsMapper.insertNews";
			session.insert(statement,news);
			result = true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return result;
	}
	// 3. update
	public boolean update(NewsVO news) {
		System.out.println("update - Myvatis를 사용 DB 연동");
		boolean result = false;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession(true);
			String statement = "resource.NewsMapper.updateNews";
			session.update(statement,news);
			result = true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return result;
	}
	// 4. delete
	public boolean delete(int id) {
		System.out.println("delete - Myvatis를 사용 DB 연동");
		boolean result =false;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession(true);
			String statement = "resource.NewsMapper.deleteNews";
			session.update(statement,id);
			/** ==== */
			result =true;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return result;
	}

	// 5. 조회수 listOne
	public NewsVO listOne(int id) {
		System.out.println("listOne - Myvatis를 사용 DB 연동");
		NewsVO vo = new NewsVO();
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession(true);
			String statement = "resource.NewsMapper.listoneNews";
			session.update(statement,id);
			statement = "resource.NewsMapper.listoneNews2";
			vo = session.selectOne(statement,id); /** ==== */
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return vo;
	}
	// 6. 특정 작성자 listWriter
	public List<NewsVO> listWriter(String writer) {
		System.out.println("listWriter - Myvatis를 사용 DB 연동");
		List<NewsVO> list = null;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession();
			String statement = "resource.NewsMapper.listwriterNews";
			list = session.selectList(statement,writer);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	// 7. 검색 ( 내용, 제목 ) search
	public List<NewsVO> search(String key, String searchType){
		System.out.println("search - Myvatis를 사용 DB 연동");
		List<NewsVO> list = null;
		String resource = "resource/mybatis-config.xml";
		SqlSession session = null;
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession();
			/** ===[일반]=== */
			String sId = "";
			if(searchType.equals("title")) {
				sId ="searchtitleNews";
			} else if (searchType.equals("content")) {
				sId = "searchcontentNews";
			}
			list = session.selectList("resource.NewsMapper."+sId, key);
			/** ===[HashMap]=== */
			/*
			HashMap<String, String> map = new HashMap<>();
			map.put("searchType", searchType);
			map.put("key", key);
			try {
				String statement = "resource.NewsMapper.searchNews";
				session = sqlSessionFactory.openSession(true);
				list = session.selectList(statement,map);						
			} */
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
}
