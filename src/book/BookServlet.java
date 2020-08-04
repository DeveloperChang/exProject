package book;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet(value= {"/book/list","/book/cart","/book/cartUpdate","/book/insert","/book/list.json"})
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out=response.getWriter();
		DAO dao = new DAO();
		
		switch(request.getServletPath()) {
			case "/book/cart":
				response.sendRedirect("cart.jsp");
				break;

			case "/book/insert":
				response.sendRedirect("insert.jsp");
				break;
			case "/book/list.json" : 
				
				String key=request.getParameter("key")==null?"code":request.getParameter("key");
				String word=request.getParameter("word")==null?"":request.getParameter("word");
				String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
				int page=Integer.parseInt(strPage);
				String strPerPage=request.getParameter("perPage")==null?"10":request.getParameter("perPage");
				int perPage=Integer.parseInt(strPerPage);
				
				System.out.println(dao.list(key,word,page,perPage));
				out.println(dao.list(key,word,page,perPage));
				break;
			case "/book/list":
				response.sendRedirect("list.jsp");
				break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
			case "/book/cart":
				String code=request.getParameter("code");
				String title=request.getParameter("title");
				String strPrice=request.getParameter("price");
				int price=Integer.parseInt(strPrice);
				
				CartVO cartvo = new CartVO();
				cartvo.setCode(code);
				cartvo.setTitle(title);
				cartvo.setPrice(price);
				cartvo.setNumber(1);
				
				HttpSession session = request.getSession();
				ArrayList<CartVO> listCart=(ArrayList<CartVO>)session.getAttribute("listCart");
				if(listCart == null) {
					listCart = new ArrayList<CartVO>();
					listCart.add(cartvo);
				}else {
				   boolean find=false;
		            for(CartVO v:listCart) {
		               if(v.getCode().equals(code)) {
		                  v.setNumber(v.getNumber()+1);
		                  find=true;
		               }
		            }
		            if(find==false) 
					listCart.add(cartvo);
				}
				session.setAttribute("listCart", listCart);
				break;
				
		      case "/book/cartUpdate":
		          code=request.getParameter("code");
		          String strNumber=request.getParameter("number");
		          int number=Integer.parseInt(strNumber);
		          
		          session = request.getSession();
		          listCart=(ArrayList<CartVO>)session.getAttribute("listCart");
		          for(CartVO v:listCart) {
		             if(v.getCode().equals(code)) {
		                v.setNumber(number);
		                v.setSum(v.getPrice()*v.getNumber());
		             }
		          }
		          break;
			     
			case "/book/insert":
				BookVO vo = new BookVO();
				vo.setCode(request.getParameter("code"));
				vo.setTitle(request.getParameter("title"));
				vo.setWriter(request.getParameter("writer"));
				strPrice=request.getParameter("price");
				vo.setPrice(Integer.parseInt(strPrice));
				
				DAO dao = new DAO();
				int count=dao.insert(vo);
				
				JSONObject jObject = new JSONObject();
				jObject.put("count",count);
				
				System.out.println(jObject);
				out.println(jObject);
				break;
		}
	}
	
}
