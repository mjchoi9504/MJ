package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.vo.EvaluationVO;




@WebServlet("/toilet")
public class ToiletServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		


		request.getRequestDispatcher("/jsp/toiletView.jsp").forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		
		
		int num=Integer.parseInt(request.getParameter("str"));
		System.out.println("가지고 왔어...."+num);
	
		
		EvaluationVO vo=new EvaluationVO();
		vo.setTotal(num);
		
		session.setAttribute("result",num);


		request.getRequestDispatcher("/jsp/toiletView.jsp").forward(request, response);
	}

}
