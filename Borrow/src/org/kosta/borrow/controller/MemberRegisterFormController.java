package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.MemberDAO;

public class MemberRegisterFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("url", "/member/member_register_form.jsp");
		return "/template/layout.jsp";
	}

}
