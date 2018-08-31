package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberRegisterController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 String id=request.getParameter("id");
		 String pwd=request.getParameter("pwd");
		 String name=request.getParameter("name");
		 String address=request.getParameter("address");
		 String tel=request.getParameter("tel");
		 MemberDAO.getInstance().registerMember(new MemberVO(id, pwd, name, address, tel, 0));		 		 
		 request.setAttribute("url", "/member/login_form.jsp");
		 return "/template/layout.jsp";
	}

}
