package org.kosta.borrow.controller;

import java.sql.SQLException;

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
		try {
			MemberVO user = MemberDAO.getInstance().login(id,pwd);
			if(user==null) {
				//로그인 실패
			}else {
				//로그인 성공
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:index.jsp";
	}

}
