package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO mvo=(MemberVO) session.getAttribute("user");
		String id=mvo.getId();
		MemberVO vo=MemberDAO.getInstance().memberDetail(id);
		request.setAttribute("vo", vo);
		request.setAttribute("url", "/member/member_detail.jsp");
		return "/template/layout.jsp";
	}

}
