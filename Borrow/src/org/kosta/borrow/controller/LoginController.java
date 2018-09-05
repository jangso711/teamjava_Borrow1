package org.kosta.borrow.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class LoginController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response)  {
		String id = request.getParameter("memberId");
		String pwd = request.getParameter("memberPwd");
		String result = null;
		try {
			MemberVO user = MemberDAO.getInstance().login(id,pwd);
			if(user==null) {
				result = "fail";
				//return "member/login_fail.jsp";
			}else {
				//로그인 성공
				result = "ok";
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				
			}
			HttpSession session = request.getSession();
			//조회수 체크를 위해 noList를 추가한다 
			session.setAttribute("noList",new ArrayList<Integer>());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("responsebody", result);
		return "AjaxView";
		//return "redirect:index.jsp";
	}

}
