package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.NewsDAO;
import model.dao.NewsMybatisDAO;
import model.vo.NewsVO;


@WebServlet("/news")
public class NewsServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//출력, 제목 선택시, 삭제버튼 클릭시
		//NewsDAO dao = new NewsDAO();
		NewsMybatisDAO dao = new NewsMybatisDAO();
		
		String id_query = request.getParameter("id");
		String action_query =request.getParameter("action");
		String writer = request.getParameter("writer");
		String key = request.getParameter("key");
		String searchType = request.getParameter("searchType");
		String style = "display : none";
		
		if(id_query==null && action_query ==null) {
			List<NewsVO> list = dao.listAll();
			if(list.size()!=0) {
				request.setAttribute("list", list);
			} else {
				request.setAttribute("msg", "게시물이 존재하지 않습니다.");
			}
		} else if (action_query.equals("read")) {
			NewsVO vo = dao.listOne(Integer.parseInt(id_query));
			if(vo != null) {
				request.setAttribute("vo", vo);
				request.setAttribute("list", dao.listAll());
			} else {
				request.setAttribute("msg", id_query + "번 게시물이 존재하지 않습니다.");
			}
		} else if (action_query.equals("delete")) {
			boolean result = dao.delete(Integer.parseInt(id_query));
			if(result) {
				request.setAttribute("list", dao.listAll());
			} else {
				request.setAttribute("msg", id_query + "번 게시물 삭제에 실패했습니다.");
			}
		} else if (action_query.equals("listwriter")) {
			List<NewsVO> list = dao.listWriter(writer);
			if(list.size()!=0) {
				request.setAttribute("list", list);
				style = "display : inline";
			} else { 
				request.setAttribute("msg", writer +"님이 작성한 게시물이 존재하지 않습니다.");
			}
		} else if (action_query.equals("search")) {
			List<NewsVO> list = dao.search(key, searchType);
			if(list.size()!=0) {
				request.setAttribute("list", list);
				style = "display : inline";
			} else {
				request.setAttribute("msg", searchType +"에 "+ key +" 가(이) 포함된 게시물이 존재하지 않습니다.");
			}
		}
		request.setAttribute("style", style);
		request.getRequestDispatcher("/jsp/news.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//작성, 수정
		//NewsDAO dao = new NewsDAO();
		NewsMybatisDAO dao = new NewsMybatisDAO();
		
		request.setCharacterEncoding("UTF-8");
		String id_query = request.getParameter("id");
		String action_query =request.getParameter("action");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		NewsVO vo = new NewsVO();
		vo.setWriter(writer);
		vo.setTitle(title);
		vo.setContent(content);
		
		if(vo != null) {
			
			if(action_query.equals("insert")) {
				boolean result = dao.insert(vo);
				if(result) {
					List<NewsVO> list = dao.listAll();
					request.setAttribute("list", list);
					request.setAttribute("style", "display : none");
				} else {
					request.setAttribute("msg", "게시물 작성에 실패했습니다.");
				}
				
			} else if(action_query.equals("update")){
				vo.setId(Integer.parseInt(id_query));
				boolean result = dao.update(vo);
				if(!result) {
					request.setAttribute("msg", "수정에 실패했습니다.");
				} else {
					request.setAttribute("list", dao.listAll());
					request.setAttribute("style", "display : none");
				}
			}
		}
		request.getRequestDispatcher("/jsp/news.jsp").forward(request, response);
	}

}
