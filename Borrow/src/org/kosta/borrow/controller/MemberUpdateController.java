package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberUpdateController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		String address=request.getParameter("address");
		String tel=request.getParameter("tel");
		HttpSession session=request.getSession();
		String id=((MemberVO)(session.getAttribute("user"))).getId();
		MemberVO vo=new MemberVO(id, pwd, name, address, tel, 0);
		MemberDAO.getInstance().updateMember(vo);		 	
		 return "front?command=MemberDetail";
	}

}
