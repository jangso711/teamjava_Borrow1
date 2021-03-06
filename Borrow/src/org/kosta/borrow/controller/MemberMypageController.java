package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberVO;

public class MemberMypageController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO vo=(MemberVO) session.getAttribute("user");
		if(vo==null) {
			return "front?command=LoginForm";
		}
		request.setAttribute("url", "/member/member_mypage.jsp");
		return "/template/layout.jsp";
	}

}
