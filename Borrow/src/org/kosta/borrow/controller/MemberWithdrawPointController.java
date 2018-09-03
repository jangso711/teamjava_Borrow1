package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberWithdrawPointController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int point=Integer.parseInt(request.getParameter("point"));
		HttpSession session=request.getSession();
		MemberVO mvo=(MemberVO) session.getAttribute("user");
		if(mvo==null) {
			return "front?command=LoginForm";
		}
		String id=mvo.getId();
		if(point>=1000) {
		MemberDAO.getInstance().withdrawPoint(id, point);
		
		}
		return "redirect:front?command=MemberDetail";
	}

}
