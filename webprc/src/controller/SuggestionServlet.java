package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.SuggestionDAO;
import model.vo.SuggestionVO;


@WebServlet("/suggestion")
public class SuggestionServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SuggestionDAO dao = new SuggestionDAO();
		String id_query = request.getParameter("id");
		String action_query =request.getParameter("action");
		String con_type = request.getParameter("con_type");
		String key = request.getParameter("key");
		String searchType = request.getParameter("searchType");
		String style = "display : none";
		if(id_query==null && action_query ==null) {
			List<SuggestionVO> list = dao.listAll();
			System.out.println(list);
			if(list.size()!=0) {
				request.setAttribute("list", list);
			} else {
				request.setAttribute("msg", "게시물이 존재하지 않습니다.");
			}
		} else if (action_query.equals("read")) {
			SuggestionVO vo = dao.listOne(Integer.parseInt(id_query));
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
		} else if (action_query.equals("listType")) {
			List<SuggestionVO> list = dao.listType(con_type);
			if(list.size()!=0) {
				request.setAttribute("list", list);
				style = "display : inline";
			} else { 
				request.setAttribute("msg", con_type +"로 분류된 게시물이 존재하지 않습니다.");
			}
		} else if (action_query.equals("search")) {
			List<SuggestionVO> list = dao.search(key, searchType);
			if(list.size()!=0) {
				request.setAttribute("list", list);
				style = "display : inline";
			} else {
				request.setAttribute("msg", searchType +"에 "+ key +" 가(이) 포함된 게시물이 존재하지 않습니다.");
			}
		}
		request.setAttribute("style", style);
		request.getRequestDispatcher("/jsp/SuggestionView.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SuggestionDAO dao = new SuggestionDAO();
		request.setCharacterEncoding("UTF-8");
		String id_query = request.getParameter("id");
		String action_query =request.getParameter("action");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String con_type = request.getParameter("con_type");
		SuggestionVO vo = new SuggestionVO();
		vo.setWriter(writer);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setCon_type(con_type);
		if(vo != null) {
			if(action_query.equals("insert")) {
				boolean result = dao.insert(vo);
				if(result) {
					List<SuggestionVO> list = dao.listAll();
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
		request.getRequestDispatcher("/jsp/SuggestionView.jsp").forward(request, response);
		
	}

}
