package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet(value= {"/user/list","/user/insert","/user/login","/user/logout","/user/list.json"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out=response.getWriter();
		UDAO dao=new UDAO();
		RequestDispatcher dis = null;
		
		switch(request.getServletPath()) {
			case "/user/insert":
				dis=request.getRequestDispatcher("insert.jsp");
				dis.forward(request, response);
			break;
			case "/":
				dis=request.getRequestDispatcher("index.jsp");
				dis.forward(request, response);
				break;
				
			case "/user/logout" :
				
				HttpSession session = request.getSession();
				session.invalidate();
				response.sendRedirect("/index.jsp");
				break;
				
			case "/user/login" :
				
				dis=request.getRequestDispatcher("login.jsp");
				dis.forward(request, response);
				break;
				
			case "/user/list.json" : 
				
				String key=request.getParameter("key")==null?"code":request.getParameter("key");
				String word=request.getParameter("word")==null?"":request.getParameter("word");
				
				String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
				int page=Integer.parseInt(strPage);
				
				String strPerPage=request.getParameter("perPage")==null?"10":request.getParameter("perPage");
				int perPage=Integer.parseInt(strPerPage);
				
				System.out.println(dao.list(key,word,page,perPage));
				out.println(dao.list(key,word,page,perPage));
				break;
			case "/user/list":
				response.sendRedirect("list.jsp");
				break;
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		UDAO udao = new UDAO();
		
		switch(request.getServletPath()) {
			case "/user/insert":
				UserVO vo = new UserVO();
				vo.setId(request.getParameter("id"));
				vo.setPassword(request.getParameter("password"));
				vo.setName(request.getParameter("name"));
				JSONObject jObject = udao.insert(vo);
				out.println(jObject);
			break;
			
			case "/user/login" :
				String id = request.getParameter("id");
				String password = request.getParameter("password");
				
				
				vo = udao.loginCheck(id,password);
				
				jObject = new JSONObject();
				jObject.put("id", vo.getId());
				out.print(jObject);
				
				HttpSession session = request.getSession();
				session.setAttribute("id", vo.getId());
				session.setAttribute("name", vo.getName());
				
			break;
		}	
	}
	
}
