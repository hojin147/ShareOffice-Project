package filter;

import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import office.User_account;
import java.io.IOException;
import java.io.PrintWriter;

public class checkFilter implements Filter {
	
	public void init(FilterConfig config) throws ServletException{
		System.out.println("오피스 필터");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println(getURLPath(request));
		HttpServletRequest req= (HttpServletRequest)request;
		HttpSession reqSession = req.getSession();
		//현재 세션 받기
		String sessionId= (String)reqSession.getAttribute("uEmail");
		//널일 경우 공백처리
		if(sessionId==null) sessionId="";
		
		//현재 세션에 대한 유저정보 불러오기
		UserDAO userDAO = new UserDAO();
		User_account user = userDAO.selectOneuser(sessionId);
		
		//세션의 타입 저장
		String type = user.getuType();
		//널일경우 공백처리
		if(type==null) type="";
		
		HttpServletResponse res = (HttpServletResponse) response;
		
		res.setCharacterEncoding("UTF-8");
		
		//타입이 admin이 아닐 경우의 처리
		if(!type.equals("admin")) {
			PrintWriter writer = res.getWriter();
			writer.println("<script>");
			writer.println("alert('관리자 계정으로 접속해주세요.')");
			writer.println("location.href = '../pagemain/mainpage.jsp'");
			writer.println("</script>");
		}		
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		
	}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		String currentPath="";
		String queryString="";
		if(request instanceof HttpServletRequest) {
			req = (HttpServletRequest)request;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? "":"?" + queryString;
		}
		return currentPath+queryString;
	}
}