package controller;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.JoinDAO;
import model.vo.JoinVO;


@WebServlet("/join")
public class JoinServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		JoinDAO dao = new JoinDAO();
		ArrayList<JoinVO> list = null;
		HttpSession session=request.getSession();
		String action = request.getParameter("action");

		if(action == null) {
			list = dao.listAll();
		    if(list.size() != 0) {
			   request.setAttribute("list", list);
		   }else {
			   request.setAttribute("msg", "추출된 news리스트가 없습니다.");
		   }	
		}else if(action.equals("logout")) {
			session.invalidate();
			System.out.println("로그아웃되었습니다.");
		}
		request.getRequestDispatcher("/jsp/main.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 작성(insert)
		JoinDAO dao = new JoinDAO();// DAO
		JoinVO vo =null;
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String ages = request.getParameter("ages");
		String phonenum = request.getParameter("phonenum");
		String email = request.getParameter("email");
		String action = request.getParameter("action");
		System.out.println(ages);
		// VO
		
		String route="/jsp/main.jsp";
		if(action!=null) {
			// INSERT
			if( action.equals("insert")) {
				vo = new JoinVO();
				vo.setName(name);
				vo.setId(id);
				vo.setPassword(password);
				vo.setGender(gender);
				vo.setAges(ages);
				vo.setPhonenum(phonenum);
				vo.setEmail(email);
				System.out.println(vo.toString());
				boolean result1 = dao.insert(vo);
				if(result1) {
					request.setAttribute("msg", "가입이 완료되었습니다.");
				} else {
					request.setAttribute("msg", "작성을 실패하셨습니다.");
				}
				
			}else if(action.equals("check")) {
				String userid = request.getParameter("userid");
				String userpassword = request.getParameter("userpassword");
				System.out.println("id "+userid);
				System.out.println("pass "+userpassword);
				
				HttpSession session=request.getSession();
				
				boolean result=dao.check(userid, userpassword);
				
				if (result) {
					session.setAttribute("login", userid);
					session.setMaxInactiveInterval(30*60);
					System.out.println("로그인이 되었습니다.");
				}else {
					session.setAttribute("login", null);
					route="/jsp/news.jsp";	
				}
				
				
			}
		}request.getRequestDispatcher(route).forward(request, response);			
			}
}