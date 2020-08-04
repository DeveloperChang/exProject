package bbs;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(value={"/bbs/list","/bbs/read","/bbs/insert","/bbs/list.json"})
public class BbsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BBSDAO dao = new BBSDAO();
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis = null;
		
		switch(request.getServletPath()) {
		case "/bbs/read":
			String strNo=request.getParameter("no");
			dao.read(Integer.parseInt(strNo));
			request.setAttribute("vo", dao.read(Integer.parseInt(strNo)));
			dis = request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/insert":
			response.sendRedirect("insert.jsp");
			break;
		
		case "/bbs/list":
			response.sendRedirect("list.jsp");
			break;
		
		case "/bbs/list.json":
			String key=request.getParameter("key")==null?"writer":request.getParameter("key");
			String word=request.getParameter("word")==null?"":request.getParameter("word");
			
			String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
			int page=Integer.parseInt(strPage);
			
			String strPerPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
			int perPage=Integer.parseInt(strPerPage);
			
			System.out.println(dao.list(key,word,page,perPage));
			out.println(dao.list(key,word,page,perPage));
						
			break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/bbs/insert":
			BBSVO vo = new BBSVO();
			vo.setTitle(request.getParameter("title"));
			vo.setContent(request.getParameter("content"));
			vo.setWriter(request.getParameter("writer"));
			BBSDAO dao = new BBSDAO();
			dao.insert(vo);
			response.sendRedirect("list");
			break;
		}
	}
}
